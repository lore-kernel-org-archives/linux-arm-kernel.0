From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 5 Mar 2015 09:35:13 +0000
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <CAH=tA9GbekVfCrCvVuR51y5tb_BvsCykeVSxmeagqF5uhOu-8A@mail.gmail.com>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
 <CAH=tA9GbekVfCrCvVuR51y5tb_BvsCykeVSxmeagqF5uhOu-8A@mail.gmail.com>
Message-ID: <7d475c1ba8224740898ee9c8881b839f@BN1AFFO11FD032.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolae Rosia,

        Thanks for reviewing the patch.

> -----Original Message-----
> From: Nicolae Rosia [mailto:nicolae.rosia at gmail.com]
> Sent: Tuesday, March 03, 2015 12:29 AM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; vinod.koul at intel.com; Michal Simek; Soren
> Brinkmann; Srikanth Vemula; linux-kernel at vger.kernel.org; Srikanth
> Thokala; Anirudha Sarangi; dmaengine at vger.kernel.org; Appana Durga
> Kedareswara Rao; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
>
> Hello,
>
> Here are my comments:
> You are not making efficient use of DMA's coalesce capability and chaining
> because you could keep a list of pending descriptors, chain and process them
> with a single IRQ by setting the coalese field equal to the number of End Of
> Frame bits set in the entire list. This works with very well with scatter gatter.
> You can cache the Control register to avoid reading it.

Ok will work on this.

>
> More comments are inline.
>
> I have a version in which I've addressed all of the issues I've presented if you
> are interested.

Yep sure please send me the changes if you have any will review it and will add it to next version of the patch.

>
> Best regards,
> Nicolae Rosia
>
> On Mon, Mar 2, 2015 at 7:55 PM, Kedareswara rao Appana
> <appana.durga.rao@xilinx.com> wrote:
> > This is the driver for the AXI Direct Memory Access (AXI DMA) core,
> > which is a soft Xilinx IP core that provides high- bandwidth direct
> > memory access between memory and AXI4-Stream type target
> peripherals.
> >
> > Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > This patch is rebased on top of dma: xilinx-dma: move header file to
> > common location.
> >
> > The deivce tree doc got applied in the slave-dmaengine.git.
> >
> > Changes in v5:
> > - Modified the xilinx_dma.h header file location to the
> >   include/linux/dma/xilinx_dma.h
> > Changes in v4:
> > - Add direction field to DMA descriptor structure and removed from
> >   channel structure to avoid duplication.
> > - Check for DMA idle condition before changing the configuration.
> > - Residue is being calculated in complete_descriptor() and is reported
> >   to slave driver.
> >
> > Changes in v3:
> > - Rebased on 3.16-rc7
> >
> > Changes in v2:
> > - Simplified the logic to set SOP and APP words in prep_slave_sg().
> > - Corrected function description comments to match the return type.
> > - Fixed some minor comments as suggested by Andy, Thanks.
> >
> >  drivers/dma/Kconfig             |   13 +
> >  drivers/dma/xilinx/Makefile     |    1 +
> >  drivers/dma/xilinx/xilinx_dma.c | 1242
> +++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma/xilinx_dma.h  |   14 +
> >  4 files changed, 1270 insertions(+)
> >  create mode 100644 drivers/dma/xilinx/xilinx_dma.c
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig index
> > a874b6e..3271f47 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -425,6 +425,19 @@ config IMG_MDC_DMA
> >         help
> >           Enable support for the IMG multi-threaded DMA controller (MDC).
> >
> > +config XILINX_DMA
> > +       tristate "Xilinx AXI DMA Engine"
> > +       depends on (ARCH_ZYNQ || MICROBLAZE)
> > +       select DMA_ENGINE
> > +       help
> > +         Enable support for Xilinx AXI DMA Soft IP.
> > +
> > +       This engine provides high-bandwidth direct memory access
> > +       between memory and AXI4-Stream type target peripherals.
> > +       It has two stream interfaces/channels, Memory Mapped to
> > +       Stream (MM2S) and Stream to Memory Mapped (S2MM) for the
> > +       data transfers.
> > +
> >  config DMA_ENGINE
> >         bool
> >
> > diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
> > index 3c4e9f2..6224a49 100644
> > --- a/drivers/dma/xilinx/Makefile
> > +++ b/drivers/dma/xilinx/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_XILINX_VDMA) += xilinx_vdma.o
> > +obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c new file mode 100644 index
> > 0000000..fdf2d54
> > --- /dev/null
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -0,0 +1,1242 @@
> > +/*
> > + * DMA driver for Xilinx DMA Engine
> > + *
> > + * Copyright (C) 2010 - 2014 Xilinx, Inc. All rights reserved.
> > + *
> > + * Based on the Freescale DMA driver.
> > + *
> > + * Description:
> > + *  The AXI DMA, is a soft IP, which provides high-bandwidth Direct
> > +Memory
> > + *  Access between memory and AXI4-Stream-type target peripherals. It
> > +can be
> > + *  configured to have one channel or two channels and if configured
> > +as two
> > + *  channels, one is to transmit data from memory to a device and
> > +another is
> > + *  to receive from a device.
> > + *
> > + * This program is free software: you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/dma/xilinx_dma.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +
> > +#include "../dmaengine.h"
> > +
> > +/* Register Offsets */
> > +#define XILINX_DMA_REG_CONTROL         0x00
> > +#define XILINX_DMA_REG_STATUS          0x04
> > +#define XILINX_DMA_REG_CURDESC         0x08
> > +#define XILINX_DMA_REG_TAILDESC                0x10
> > +#define XILINX_DMA_REG_SRCADDR         0x18
> > +#define XILINX_DMA_REG_DSTADDR         0x20
> > +#define XILINX_DMA_REG_BTT             0x28
> > +
> > +/* Channel/Descriptor Offsets */
> > +#define XILINX_DMA_MM2S_CTRL_OFFSET    0x00
> > +#define XILINX_DMA_S2MM_CTRL_OFFSET    0x30
> > +
> > +/* General register bits definitions */
> > +#define XILINX_DMA_CR_RUNSTOP_MASK     BIT(0)
> > +#define XILINX_DMA_CR_RESET_MASK       BIT(2)
> > +
> > +#define XILINX_DMA_CR_DELAY_SHIFT      24
> > +#define XILINX_DMA_CR_COALESCE_SHIFT   16
> > +
> > +#define XILINX_DMA_CR_DELAY_MAX                GENMASK(7, 0)
> > +#define XILINX_DMA_CR_COALESCE_MAX     GENMASK(7, 0)
> > +
> > +#define XILINX_DMA_SR_HALTED_MASK      BIT(0)
> > +#define XILINX_DMA_SR_IDLE_MASK                BIT(1)
> > +
> > +#define XILINX_DMA_XR_IRQ_IOC_MASK     BIT(12)
> > +#define XILINX_DMA_XR_IRQ_DELAY_MASK   BIT(13)
> > +#define XILINX_DMA_XR_IRQ_ERROR_MASK   BIT(14)
> > +#define XILINX_DMA_XR_IRQ_ALL_MASK     GENMASK(14, 12)
> > +
> > +/* BD definitions */
> > +#define XILINX_DMA_BD_STS_ALL_MASK     GENMASK(31, 28)
> > +#define XILINX_DMA_BD_SOP              BIT(27)
> > +#define XILINX_DMA_BD_EOP              BIT(26)
> > +
> > +/* Hw specific definitions */
> > +#define XILINX_DMA_MAX_CHANS_PER_DEVICE        0x2
> > +#define XILINX_DMA_MAX_TRANS_LEN       GENMASK(22, 0)
> > +
> > +/* Delay loop counter to prevent hardware failure */
> > +#define XILINX_DMA_LOOP_COUNT          1000000
> > +
> > +/* Maximum number of Descriptors */
> > +#define XILINX_DMA_NUM_DESCS           64
> > +#define XILINX_DMA_NUM_APP_WORDS       5
> > +
> > +/**
> > + * struct xilinx_dma_desc_hw - Hardware Descriptor
> > + * @next_desc: Next Descriptor Pointer @0x00
> > + * @pad1: Reserved @0x04
> > + * @buf_addr: Buffer address @0x08
> > + * @pad2: Reserved @0x0C
> > + * @pad3: Reserved @0x10
> > + * @pad4: Reserved @0x14
> > + * @control: Control field @0x18
> > + * @status: Status field @0x1C
> > + * @app: APP Fields @0x20 - 0x30
> > + */
> > +struct xilinx_dma_desc_hw {
> > +       u32 next_desc;
> > +       u32 pad1;
> > +       u32 buf_addr;
> > +       u32 pad2;
> > +       u32 pad3;
> > +       u32 pad4;
> > +       u32 control;
> > +       u32 status;
> > +       u32 app[XILINX_DMA_NUM_APP_WORDS]; } __aligned(64);
> > +
> > +/**
> > + * struct xilinx_dma_tx_segment - Descriptor segment
> > + * @hw: Hardware descriptor
> > + * @node: Node in the descriptor segments list
> > + * @phys: Physical address of segment  */ struct
> > +xilinx_dma_tx_segment {
> > +       struct xilinx_dma_desc_hw hw;
> > +       struct list_head node;
> > +       dma_addr_t phys;
> > +} __aligned(64);
> > +
> > +/**
> > + * struct xilinx_dma_tx_descriptor - Per Transaction structure
> > + * @async_tx: Async transaction descriptor
> > + * @segments: TX segments list
> > + * @node: Node in the channel descriptors list
> > + * @direction: Transfer direction
> > + */
> > +struct xilinx_dma_tx_descriptor {
> > +       struct dma_async_tx_descriptor async_tx;
> > +       struct list_head segments;
> > +       struct list_head node;
> > +       enum dma_transfer_direction direction; };
> > +
> > +/**
> > + * struct xilinx_dma_chan - Driver specific DMA channel structure
> > + * @xdev: Driver specific device structure
> > + * @ctrl_offset: Control registers offset
> > + * @lock: Descriptor operation lock
> > + * @pending_list: Descriptors waiting
> > + * @active_desc: Active descriptor
> > + * @allocated_desc: Allocated descriptor
> > + * @done_list: Complete descriptors
> > + * @free_seg_list: Free descriptors
> > + * @common: DMA common channel
> > + * @seg_v: Statically allocated segments base
> > + * @seg_p: Physical allocated segments base
> > + * @dev: The dma device
> > + * @irq: Channel IRQ
> > + * @id: Channel ID
> > + * @has_sg: Support scatter transfers
> > + * @err: Channel has errors
> > + * @tasklet: Cleanup work after irq
> > + * @residue: Residue
> > + */
> > +struct xilinx_dma_chan {
> > +       struct xilinx_dma_device *xdev;
> > +       u32 ctrl_offset;
> > +       spinlock_t lock;
> > +       struct list_head pending_list;
> > +       struct xilinx_dma_tx_descriptor *active_desc;
> > +       struct xilinx_dma_tx_descriptor *allocated_desc;
> > +       struct list_head done_list;
> > +       struct list_head free_seg_list;
> > +       struct dma_chan common;
> > +       struct xilinx_dma_tx_segment *seg_v;
> > +       dma_addr_t seg_p;
> > +       struct device *dev;
> > +       int irq;
> > +       int id;
> > +       bool has_sg;
> > +       int err;
> > +       struct tasklet_struct tasklet;
> > +       u32 residue;
> > +};
> > +
> > +/**
> > + * struct xilinx_dma_device - DMA device structure
> > + * @regs: I/O mapped base address
> > + * @dev: Device Structure
> > + * @common: DMA device structure
> > + * @chan: Driver specific DMA channel
> > + * @has_sg: Specifies whether Scatter-Gather is present or not  */
> > +struct xilinx_dma_device {
> > +       void __iomem *regs;
> > +       struct device *dev;
> > +       struct dma_device common;
> > +       struct xilinx_dma_chan
> *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
> > +       bool has_sg;
> > +};
> > +
> > +/* Macros */
> > +#define to_xilinx_chan(chan) \
> > +       container_of(chan, struct xilinx_dma_chan, common) #define
> > +to_dma_tx_descriptor(tx) \
> > +       container_of(tx, struct xilinx_dma_tx_descriptor, async_tx)
> > +
> > +/* IO accessors */
> > +static inline u32 dma_read(struct xilinx_dma_chan *chan, u32 reg) {
> > +       return ioread32(chan->xdev->regs + reg); }
> > +
> > +static inline void dma_write(struct xilinx_dma_chan *chan, u32 reg,
> > +u32 value) {
> > +       iowrite32(value, chan->xdev->regs + reg); }
> > +
> > +static inline u32 dma_ctrl_read(struct xilinx_dma_chan *chan, u32
> > +reg) {
> > +       return dma_read(chan, chan->ctrl_offset + reg); }
> > +
> > +static inline void dma_ctrl_write(struct xilinx_dma_chan *chan, u32 reg,
> > +                                 u32 value) {
> > +       dma_write(chan, chan->ctrl_offset + reg, value); }
> > +
> > +static inline void dma_ctrl_clr(struct xilinx_dma_chan *chan, u32
> > +reg, u32 clr) {
> > +       dma_ctrl_write(chan, reg, dma_ctrl_read(chan, reg) & ~clr); }
> > +
> > +static inline void dma_ctrl_set(struct xilinx_dma_chan *chan, u32
> > +reg, u32 set) {
> > +       dma_ctrl_write(chan, reg, dma_ctrl_read(chan, reg) | set); }
> > +
> > +/*
> > +---------------------------------------------------------------------
> > +--------
> > + * Descriptors and segments alloc and free  */
> > +
> > +/**
> > + * xilinx_dma_alloc_tx_segment - Allocate transaction segment
> > + * @chan: Driver specific dma channel
> > + *
> > + * Return: The allocated segment on success and NULL on failure.
> > + */
> > +static struct xilinx_dma_tx_segment *
> > +xilinx_dma_alloc_tx_segment(struct xilinx_dma_chan *chan) {
> > +       struct xilinx_dma_tx_segment *segment = NULL;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +       if (!list_empty(&chan->free_seg_list)) {
> > +               segment = list_first_entry(&chan->free_seg_list,
> > +                                          struct xilinx_dma_tx_segment,
> > +                                          node);
> > +               list_del(&segment->node);
> > +       }
> > +       spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +       return segment;
> > +}
> > +
> > +/**
> > + * xilinx_dma_clean_hw_desc - Clean hardware descriptor
> > + * @hw: HW descriptor to clean
> > + */
> > +static void xilinx_dma_clean_hw_desc(struct xilinx_dma_desc_hw *hw) {
> > +       u32 next_desc = hw->next_desc;
> > +
> > +       memset(hw, 0, sizeof(struct xilinx_dma_desc_hw));
> > +
> > +       hw->next_desc = next_desc;
> > +}
> > +
> > +/**
> > + * xilinx_dma_free_tx_segment - Free transaction segment
> > + * @chan: Driver specific dma channel
> > + * @segment: dma transaction segment
> > + */
> > +static void xilinx_dma_free_tx_segment(struct xilinx_dma_chan *chan,
> > +                                      struct xilinx_dma_tx_segment
> > +*segment) {
> > +       xilinx_dma_clean_hw_desc(&segment->hw);
> > +
> > +       list_add_tail(&segment->node, &chan->free_seg_list); }
> > +
> > +/**
> > + * xilinx_dma_tx_descriptor - Allocate transaction descriptor
> > + * @chan: Driver specific dma channel
> > + *
> > + * Return: The allocated descriptor on success and NULL on failure.
> > + */
> > +static struct xilinx_dma_tx_descriptor *
> > +xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan) {
> > +       struct xilinx_dma_tx_descriptor *desc;
> > +       unsigned long flags;
> > +
> > +       if (chan->allocated_desc)
> > +               return chan->allocated_desc;
> > +
> > +       desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> > +       if (!desc)
> > +               return NULL;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +       chan->allocated_desc = desc;
> > +       spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +       INIT_LIST_HEAD(&desc->segments);
> > +
> > +       return desc;
> > +}
> > +
> > +/**
> > + * xilinx_dma_free_tx_descriptor - Free transaction descriptor
> > + * @chan: Driver specific dma channel
> > + * @desc: dma transaction descriptor
> > + */
> > +static void
> > +xilinx_dma_free_tx_descriptor(struct xilinx_dma_chan *chan,
> > +                             struct xilinx_dma_tx_descriptor *desc) {
> > +       struct xilinx_dma_tx_segment *segment, *next;
> > +
> > +       if (!desc)
> > +               return;
> > +
> > +       list_for_each_entry_safe(segment, next, &desc->segments, node) {
> > +               list_del(&segment->node);
> > +               xilinx_dma_free_tx_segment(chan, segment);
> > +       }
> > +
> > +       kfree(desc);
> > +}
> > +
> > +/**
> > + * xilinx_dma_free_desc_list - Free descriptors list
> > + * @chan: Driver specific dma channel
> > + * @list: List to parse and delete the descriptor  */ static void
> > +xilinx_dma_free_desc_list(struct xilinx_dma_chan *chan,
> > +                                     struct list_head *list) {
> > +       struct xilinx_dma_tx_descriptor *desc, *next;
> > +
> > +       list_for_each_entry_safe(desc, next, list, node) {
> > +               list_del(&desc->node);
> > +               xilinx_dma_free_tx_descriptor(chan, desc);
> > +       }
> > +}
> > +
> > +/**
> > + * xilinx_dma_free_descriptors - Free channel descriptors
> > + * @chan: Driver specific dma channel  */ static void
> > +xilinx_dma_free_descriptors(struct xilinx_dma_chan *chan) {
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +
> > +       xilinx_dma_free_desc_list(chan, &chan->pending_list);
> > +       xilinx_dma_free_desc_list(chan, &chan->done_list);
> > +
> > +       xilinx_dma_free_tx_descriptor(chan, chan->active_desc);
> > +       chan->active_desc = NULL;
> > +
> > +       spin_unlock_irqrestore(&chan->lock, flags); }
> > +
> > +/**
> > + * xilinx_dma_free_chan_resources - Free channel resources
> > + * @dchan: DMA channel
> > + */
> > +static void xilinx_dma_free_chan_resources(struct dma_chan *dchan) {
> > +       struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > +
> > +       xilinx_dma_free_descriptors(chan);
> > +
> > +       dma_free_coherent(chan->dev,
> > +                         sizeof(*chan->seg_v) * XILINX_DMA_NUM_DESCS,
> > +                         chan->seg_v, chan->seg_p); }
> > +
> > +/**
> > + * xilinx_dma_chan_desc_cleanup - Clean channel descriptors
> > + * @chan: Driver specific dma channel  */ static void
> > +xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan) {
> > +       struct xilinx_dma_tx_descriptor *desc, *next;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +
> > +       list_for_each_entry_safe(desc, next, &chan->done_list, node) {
> > +               dma_async_tx_callback callback;
> > +               void *callback_param;
> > +
> > +               /* Remove from the list of running transactions */
> > +               list_del(&desc->node);
> > +
> > +               /* Run the link descriptor callback function */
> > +               callback = desc->async_tx.callback;
> > +               callback_param = desc->async_tx.callback_param;
> > +               if (callback) {
> > +                       spin_unlock_irqrestore(&chan->lock, flags);
> > +                       callback(callback_param);
> > +                       spin_lock_irqsave(&chan->lock, flags);
> > +               }
> > +
> > +               /* Run any dependencies, then free the descriptor */
> > +               dma_run_dependencies(&desc->async_tx);
> > +               xilinx_dma_free_tx_descriptor(chan, desc);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&chan->lock, flags); }
> > +
> > +/**
> > + * xilinx_dma_do_tasklet - Schedule completion tasklet
> > + * @data: Pointer to the Xilinx dma channel structure  */ static void
> > +xilinx_dma_do_tasklet(unsigned long data) {
> > +       struct xilinx_dma_chan *chan = (struct xilinx_dma_chan *)data;
> > +
> > +       xilinx_dma_chan_desc_cleanup(chan);
> > +}
> > +
> > +/**
> > + * xilinx_dma_alloc_chan_resources - Allocate channel resources
> > + * @dchan: DMA channel
> > + *
> > + * Return: '0' on success and failure value on error  */ static int
> > +xilinx_dma_alloc_chan_resources(struct dma_chan *dchan) {
> > +       struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > +       int i;
> > +
> > +       /* Allocate the buffer descriptors. */
> > +       chan->seg_v = dma_zalloc_coherent(chan->dev,
> > +                                         sizeof(*chan->seg_v) *
> > +                                         XILINX_DMA_NUM_DESCS,
> > +                                         &chan->seg_p, GFP_KERNEL);
> > +       if (!chan->seg_v) {
> > +               dev_err(chan->dev,
> > +                       "unable to allocate channel %d descriptors\n",
> > +                       chan->id);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
> > +               chan->seg_v[i].hw.next_desc =
> > +                               chan->seg_p + sizeof(*chan->seg_v) *
> > +                               ((i + 1) % XILINX_DMA_NUM_DESCS);
> > +               chan->seg_v[i].phys =
> > +                               chan->seg_p + sizeof(*chan->seg_v) * i;
> > +               list_add_tail(&chan->seg_v[i].node, &chan->free_seg_list);
> > +       }
> > +
> > +       dma_cookie_init(dchan);
> > +       return 0;
> > +}
> > +
> > +/**
> > + * xilinx_dma_tx_status - Get dma transaction status
> > + * @dchan: DMA channel
> > + * @cookie: Transaction identifier
> > + * @txstate: Transaction state
> > + *
> > + * Return: DMA transaction status
> > + */
> > +static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
> > +                                           dma_cookie_t cookie,
> > +                                           struct dma_tx_state
> > +*txstate) {
> > +       struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > +       enum dma_status ret;
> > +       unsigned long flags;
> > +
> > +       ret = dma_cookie_status(dchan, cookie, txstate);
> > +       if (ret != DMA_COMPLETE) {
> > +               spin_lock_irqsave(&chan->lock, flags);
> > +               dma_set_residue(txstate, chan->residue);
> > +               spin_unlock_irqrestore(&chan->lock, flags);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * xilinx_dma_is_running - Check if DMA channel is running
> > + * @chan: Driver specific DMA channel
> > + *
> > + * Return: 'true' if running, 'false' if not.
> > + */
> > +static bool xilinx_dma_is_running(struct xilinx_dma_chan *chan) {
> > +       return !(dma_ctrl_read(chan, XILINX_DMA_REG_STATUS) &
> > +                XILINX_DMA_SR_HALTED_MASK) &&
> > +               (dma_ctrl_read(chan, XILINX_DMA_REG_CONTROL) &
> > +                XILINX_DMA_CR_RUNSTOP_MASK); }
> > +
> > +/**
> > + * xilinx_dma_is_idle - Check if DMA channel is idle
> > + * @chan: Driver specific DMA channel
> > + *
> > + * Return: 'true' if idle, 'false' if not.
> > + */
> > +static bool xilinx_dma_is_idle(struct xilinx_dma_chan *chan) {
> > +       return dma_ctrl_read(chan, XILINX_DMA_REG_STATUS) &
> > +               XILINX_DMA_SR_IDLE_MASK; }
> > +
> > +/**
> > + * xilinx_dma_halt - Halt DMA channel
> > + * @chan: Driver specific DMA channel  */ static void
> > +xilinx_dma_halt(struct xilinx_dma_chan *chan) {
> > +       int loop = XILINX_DMA_LOOP_COUNT;
> > +
> > +       dma_ctrl_clr(chan, XILINX_DMA_REG_CONTROL,
> > +                    XILINX_DMA_CR_RUNSTOP_MASK);
> > +
> > +       /* Wait for the hardware to halt */
> > +       do {
> > +               if (dma_ctrl_read(chan, XILINX_DMA_REG_STATUS) &
> > +                       XILINX_DMA_SR_HALTED_MASK)
> > +                       break;
> > +       } while (loop--);
> > +
> > +       if (!loop) {
> > +               pr_debug("Cannot stop channel %p: %x\n",
> > +                        chan, dma_ctrl_read(chan, XILINX_DMA_REG_STATUS));
> > +               chan->err = true;
> > +       }
> > +}
> > +
> > +/**
> > + * xilinx_dma_start - Start DMA channel
> > + * @chan: Driver specific DMA channel  */ static void
> > +xilinx_dma_start(struct xilinx_dma_chan *chan) {
> > +       int loop = XILINX_DMA_LOOP_COUNT;
> > +
> > +       dma_ctrl_set(chan, XILINX_DMA_REG_CONTROL,
> > +                    XILINX_DMA_CR_RUNSTOP_MASK);
> > +
> > +       /* Wait for the hardware to start */
> > +       do {
> > +               if (!dma_ctrl_read(chan, XILINX_DMA_REG_STATUS) &
> > +                       XILINX_DMA_SR_HALTED_MASK)
> > +                       break;
> > +       } while (loop--);
> > +
> > +       if (!loop) {
> > +               pr_debug("Cannot start channel %p: %x\n",
> > +                        chan, dma_ctrl_read(chan, XILINX_DMA_REG_STATUS));
> > +               chan->err = true;
> > +       }
> > +}
> > +
> > +/**
> > + * xilinx_dma_device_slave_caps - Slave channel capabilities
> > + * @dchan: DMA channel
> > + * @caps: Slave capabilities to set
> > + *
> > + * Return: Always '0'
> > + */
> > +static int xilinx_dma_device_slave_caps(struct dma_chan *dchan,
> > +                                       struct dma_slave_caps *caps) {
> > +       caps->directions = BIT(DMA_DEV_TO_MEM) |
> BIT(DMA_MEM_TO_DEV);
> > +       caps->cmd_terminate = true;
> > +       caps->residue_granularity =
> DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * xilinx_dma_start_transfer - Starts DMA transfer
> > + * @chan: Driver specific channel struct pointer  */ static void
> > +xilinx_dma_start_transfer(struct xilinx_dma_chan *chan) {
> > +       struct xilinx_dma_tx_descriptor *desc;
> > +       struct xilinx_dma_tx_segment *head, *tail = NULL;
> > +       unsigned long flags;
> > +
> > +       if (chan->err)
> > +               return;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +
> > +       /* There's already an active descriptor, bail out. */
> > +       if (chan->active_desc)
> > +               goto out_unlock;
> > +
> > +       if (list_empty(&chan->pending_list))
> > +               goto out_unlock;
> > +
> > +       desc = list_first_entry(&chan->pending_list,
> > +                               struct xilinx_dma_tx_descriptor,
> > + node);
> > +
> > +       if (chan->has_sg && xilinx_dma_is_running(chan) &&
> > +           !xilinx_dma_is_idle(chan)) {
> > +               tail = list_entry(desc->segments.prev,
> > +                                 struct xilinx_dma_tx_segment, node);
> > +               dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> > +               goto out_free_desc;
> > +       }
> > +
> > +       if (chan->has_sg) {
> > +               head = list_first_entry(&desc->segments,
> > +                                       struct xilinx_dma_tx_segment, node);
> > +               tail = list_entry(desc->segments.prev,
> > +                                 struct xilinx_dma_tx_segment, node);
> > +               dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC, head->phys);
> > +       }
> > +
> > +       xilinx_dma_start(chan);
> > +       if (chan->err)
> > +               goto out_unlock;
> > +
> > +       /* Enable interrupts */
> > +       dma_ctrl_set(chan, XILINX_DMA_REG_CONTROL,
> > +                    XILINX_DMA_XR_IRQ_ALL_MASK);
> > +
> There is no reason to enable the interrupts on every transfer. We can do it
> only once.

Ok Will do this change in the next version of the patch.

>
> > +       /* Start the transfer */
> > +       if (chan->has_sg) {
> > +               dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> > +       } else {
> > +               struct xilinx_dma_tx_segment *segment;
> > +               struct xilinx_dma_desc_hw *hw;
> > +
> > +               segment = list_first_entry(&desc->segments,
> > +                                          struct xilinx_dma_tx_segment, node);
> > +               hw = &segment->hw;
> > +
> > +               if (desc->direction == DMA_MEM_TO_DEV)
> > +                       dma_ctrl_write(chan, XILINX_DMA_REG_SRCADDR,
> > +                                      hw->buf_addr);
> > +               else
> > +                       dma_ctrl_write(chan, XILINX_DMA_REG_DSTADDR,
> > +                                      hw->buf_addr);
> > +
> > +               /* Start the transfer */
> > +               dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> > +                              hw->control & XILINX_DMA_MAX_TRANS_LEN);
> > +       }
> > +
> > +out_free_desc:
> > +       list_del(&desc->node);
> > +       chan->active_desc = desc;
> > +
> > +out_unlock:
> > +       spin_unlock_irqrestore(&chan->lock, flags); }
> > +
> > +/**
> > + * xilinx_dma_issue_pending - Issue pending transactions
> > + * @dchan: DMA channel
> > + */
> > +static void xilinx_dma_issue_pending(struct dma_chan *dchan) {
> > +       struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
> > +
> > +       xilinx_dma_start_transfer(chan);
> You can lock here instead of locking inside the function in order to acquire
> the lock a single time in IRQ.

Ok Will do.

> > +}
> > +
> > +/**
> > + * xilinx_dma_complete_descriptor - Mark the active descriptor as
> > +complete
> > + * @chan : xilinx DMA channel
> > + */
> > +static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan
> > +*chan) {
> > +       struct xilinx_dma_tx_descriptor *desc;
> > +       struct xilinx_dma_tx_segment *segment, *next;
> > +       struct xilinx_dma_desc_hw *hw;
> > +       unsigned long flags;
> > +       u32 residue = 0;
> > +
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +
> > +       desc = chan->active_desc;
> > +       if (!desc) {
> > +               dev_dbg(chan->dev, "no running descriptors\n");
> > +               goto out_unlock;
> > +       }
> > +
> > +       if (chan->has_sg) {
> > +               list_for_each_entry_safe(segment, next, &desc->segments,
> node) {
> > +                       hw = &segment->hw;
> > +                       residue += (hw->control - hw->status) &
> > +                                  XILINX_DMA_MAX_TRANS_LEN;
> > +               }
> > +       }
> > +
> > +       chan->residue = residue;
> > +       dma_cookie_complete(&desc->async_tx);
> > +       list_add_tail(&desc->node, &chan->done_list);
> > +
> > +       chan->active_desc = NULL;
> > +
> > +out_unlock:
> > +       spin_unlock_irqrestore(&chan->lock, flags); }
> > +
> > +/**
> > + * xilinx_dma_reset - Reset DMA channel
> > + * @chan: Driver specific DMA channel
> > + *
> > + * Return: '0' on success and failure value on error  */ static int
> > +xilinx_dma_reset(struct xilinx_dma_chan *chan) {
> > +       int loop = XILINX_DMA_LOOP_COUNT;
> > +       u32 tmp;
> > +
> > +       dma_ctrl_set(chan, XILINX_DMA_REG_CONTROL,
> > +                    XILINX_DMA_CR_RESET_MASK);
> > +
> > +       tmp = dma_ctrl_read(chan, XILINX_DMA_REG_CONTROL) &
> > +             XILINX_DMA_CR_RESET_MASK;
> > +
> > +       /* Wait for the hardware to finish reset */
> > +       do {
> > +               tmp = dma_ctrl_read(chan, XILINX_DMA_REG_CONTROL) &
> > +                     XILINX_DMA_CR_RESET_MASK;
> > +       } while (loop-- && tmp);
> > +
> > +       if (!loop) {
> > +               dev_err(chan->dev, "reset timeout, cr %x, sr %x\n",
> > +                       dma_ctrl_read(chan, XILINX_DMA_REG_CONTROL),
> > +                       dma_ctrl_read(chan, XILINX_DMA_REG_STATUS));
> > +               return -EBUSY;
> > +       }
> > +
> > +       chan->err = false;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * xilinx_dma_irq_handler - DMA Interrupt handler
> > + * @irq: IRQ number
> > + * @data: Pointer to the Xilinx DMA channel structure
> > + *
> > + * Return: IRQ_HANDLED/IRQ_NONE
> > + */
> > +static irqreturn_t xilinx_dma_irq_handler(int irq, void *data) {
> > +       struct xilinx_dma_chan *chan = data;
> > +       u32 status;
> > +
> > +       /* Read the status and ack the interrupts. */
> > +       status = dma_ctrl_read(chan, XILINX_DMA_REG_STATUS);
> > +       if (!(status & XILINX_DMA_XR_IRQ_ALL_MASK))
> > +               return IRQ_NONE;
> > +
> > +       dma_ctrl_write(chan, XILINX_DMA_REG_STATUS,
> > +                      status & XILINX_DMA_XR_IRQ_ALL_MASK);
> > +
> > +       if (status & XILINX_DMA_XR_IRQ_ERROR_MASK) {
> > +               dev_err(chan->dev,
> > +                       "Channel %p has errors %x, cdr %x tdr %x\n",
> > +                       chan, dma_ctrl_read(chan, XILINX_DMA_REG_STATUS),
> > +                       dma_ctrl_read(chan, XILINX_DMA_REG_CURDESC),
> > +                       dma_ctrl_read(chan, XILINX_DMA_REG_TAILDESC));
> > +               chan->err = true;
> > +       }
> > +
> > +       /*
> > +        * Device takes too long to do the transfer when user requires
> > +        * responsiveness
> > +        */
> > +       if (status & XILINX_DMA_XR_IRQ_DELAY_MASK)
> > +               dev_dbg(chan->dev, "Inter-packet latency too long\n");
> > +
> > +       if (status & XILINX_DMA_XR_IRQ_IOC_MASK) {
> > +               xilinx_dma_complete_descriptor(chan);
> this call disables/restores IRQ state but we are already in IRQ.

Ok will cross check.

>
> > +               xilinx_dma_start_transfer(chan);
> this one does the same thing.

Ok will modify

Regards,
Kedar.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
