From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 29 Nov 2009 20:03:29 +0800
Subject: [PATCH V2] ARM: NUC900: add GDMA driver support for nuc900
	platform
In-Reply-To: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
References: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
Message-ID: <4B126311.5090104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Hu Ruihuan 

Thanks a lot for your patch, regarding this dma driver, it looks good to me,

but for submitting this patch, there are two points you should take care as following: 

(1)Please use 'scripts/checkpatch.pl' to check your patch.

(2)Before you submit some patches, Please read the Documentation/email-clients.txt
and check your email client.


> Hi, Wan ZongShun
>     This is the gdma driver for NUC900 platform, it is based apon the
> code several days ago I have submited.
> 
> Signed-off-by: Hu Ruihuan <specter118@163.com>
> ----
> iff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/dma.c
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/dma.c
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/dma.c        1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/dma.c 2010-11-20
> 00:06:44.000000000 +0800
> @@ -0,0 +1,318 @@
> +/*
> + * arch/arm/mach-w90p910/dma.c
> + *
> + * Support functions for the w90p910 internal DMA channels.
> + *
> + * Wan Zongshun <mcuos.com@gmail.com>
> + * Hu Ruihuan <specter118@gmail.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +
> +#include <asm/system.h>
> +#include <asm/irq.h>
> +#include <asm/atomic.h>
> +#include <mach/hardware.h>
> +
> +#define NUC900_DMA_CHANNELS           (2)
> +#define DMA_BASE                               (W90X900_VA_GDMA)
> +#define GDMA_INTCS                             (DMA_BASE + 0xa0)
> +
> +#define GDMA_GDGA                              (0x1c)
> +#define TC0F                                   (0x01 << 8)
> +#define TC1F                                   (0x01 << 10)
> +#define ENTC0F                                 (0x01)
> +#define ENTC1F                                 (0x01 << 2)
> +
> +#define GDMAEN                                 (0x01)
> +#define GDMAMS                                 (0x03 << 2)
> +#define DADIR                                  (0x01 << 4)
> +#define SADIR                                  (0x01 << 5)
> +#define DAFIX                                  (0x01 << 6)
> +#define SAFIX                                  (0x01 << 7)
> +#define D_INTS                                 (0x01 << 10)
> +#define TWSMASK                                (0x03 << 12)
> +#define TWS                                    (0x02 << 12)
> +
> +#define RUN                                    (0x01 << 3)
> +#define NON_DSCRIP                             (0x01 << 2)
> +#define ORDEN                                  (0x01 << 1)
> +#define RESET                                  (0x01)
> +#define DSCRIPMASK                             (0x0F)
> +#define CMDINFOMASK                            (0x03FFF)
> +
> +#define COUTN_TRANSFER                         (0x1000)/*count[13:0]=1024*/
> +#define CHANNELINERV                           (0x20)
> +
> +typedef void (*dma_callback_t)(void *data);
> +
> +struct nuc900_dma_descp {
> +       unsigned int next_descp;
> +       unsigned int srcaddr;
> +       unsigned int dstaddr;
> +       unsigned int commandinfo;
> +};
> +
> +struct nuc900_dma_t {
> +       const char *device;             /* this channel device, 0  if unused */
> +       dma_callback_t callback;        /* to call when DMA completes */
> +       void __iomem *dma_reg;
> +       void *data;                     /* ... with private data ptr */
> +       struct nuc900_dma_descp *descp;
> +};
> +
> +static struct nuc900_dma_t dma_chan[nuc900_DMA_CHANNELS];
> +static struct nuc900_dma_t *dmachan0, *dmachan1;
> +static atomic_t  shared_irq_using;
> +static spinlock_t dma_chan_lock;
> +
> +
> +
> +static int register_dmachan_fromname(const char *dev_name,
> +                       struct nuc900_dma_t *dma, unsigned int *irq_request)
> +{
> +       int err;
> +
> +       BUG_ON(!dev_name);
> +
> +       err = 0;
> +
> +       if (!(dmachan0->device) && !(dmachan1->device)) {
> +               dma = dmachan0;
> +               *irq_request = 1;
> +       } else if ((dmachan0->device) && !(dmachan1->device)) {
> +                       if (strcmp(dmachan0->device, dev_name) == 0)
> +                               err = -EBUSY;
> +                       else
> +                               dma = dmachan1;
> +       } else if ((dmachan1->device) && !(dmachan0->device)) {
> +                       if (strcmp(dmachan1->device, dev_name) == 0)
> +                               err = -EBUSY;
> +                       else
> +                               dma = dmachan0;
> +       } else
> +               err = -EBUSY;
> +
> +       return err;
> +
> +}
> +
> +static void match_dmachan_fromname(const char *dev_name,
> +                                       struct nuc900_dma_t *dma)
> +{
> +       BUG_ON(!dev_name);
> +
> +       if (dmachan1->device) {
> +               if (strcmp(dmachan1->device, dev_name) == 0)
> +                       dma = dmachan1;
> +       } else if (dmachan0->device) {
> +               if (strcmp(dmachan0->device, dev_name) == 0)
> +                       dma = dmachan0;
> +       }
> +}
> +
> +static irqreturn_t dma_irq_handler(int irq, void *dev_id)
> +{
> +       int status;
> +       local_irq_disable();
> +       status = __raw_readl(GDMA_GDGA);
> +
> +       if (status & (TC0F)) {
> +               __raw_writel((~TC0F), GDMA_GDGA);
> +               local_irq_enable();
> +               dmachan0->callback(dmachan0->data);
> +       }
> +
> +       if (status & (TC1F)) {
> +               __raw_writel((~TC1F), GDMA_GDGA);
> +               local_irq_enable();
> +               dmachan1->callback(dmachan1->data);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +int nuc900_request_dma(const char *dev_name, dma_callback_t callback,
> +                                                               void *data)
> +{
> +       struct nuc900_dma_t *dma = NULL;
> +       int err, irq_request;
> +
> +       err = 0;
> +       irq_request = 0;
> +       spin_lock(&dma_chan_lock);
> +       err = register_dmachan_fromname(dev_name, dma, &irq_request);
> +
> +       if (err < 0) {
> +               spin_unlock(&dma_chan_lock);
> +               return err;
> +       }
> +
> +       dma->device = dev_name;
> +
> +       if (irq_request) {
> +               err = request_irq(IRQ_GDMAGROUP, dma_irq_handler, IRQF_SHARED|
> +                               IRQF_DISABLED, NULL, NULL);
> +               if (err) {
> +                       dma->device = NULL;
> +                       spin_unlock(&dma_chan_lock);
> +                       return err;
> +               }
> +       }
> +
> +
> +       atomic_inc( &shared_irq_using);
> +       dma->callback = callback;
> +       dma->data = data;
> +       spin_unlock(&dma_chan_lock);
> +       return 0;
> +}
> +EXPORT_SYMBOL(nuc900_request_dma);
> +
> +int nuc900_free_dma(const char *dev_name)
> +{
> +       struct nuc900_dma_t *dma = NULL;
> +
> +       BUG_ON(!dev_name);
> +       WARN_ON(shared_irq_using.counter == 0);
> +       spin_lock(&dma_chan_lock);
> +       match_dmachan_fromname(dev_name, dma);
> +
> +       if (!dma)
> +               return -ENXIO;
> +
> +       dma->device = NULL;
> +       spin_unlock(&dma_chan_lock);
> +
> +       atomic_dec(&shared_irq_using);
> +
> +
> +       if (!(shared_irq_using.counter))
> +               free_irq(IRQ_GDMAGROUP, dma);
> +
> +       kzfree(dma->descp);
> +       return 0;
> +}
> +EXPORT_SYMBOL(nuc900_free_dma);
> +
> +static unsigned int set_start_cmd(unsigned int start)
> +{
> +       unsigned int dscp_cmd;
> +
> +       dscp_cmd = 0;
> +
> +       if (start) {
> +               dscp_cmd = (ORDEN|RUN);
> +               dscp_cmd &= ~(NON_DSCRIP|RESET);
> +       } else {
> +               dscp_cmd = (NON_DSCRIP);
> +       }
> +               dscp_cmd &= DSCRIPMASK;
> +
> +       return dscp_cmd;
> +}
> +
> +static unsigned int set_cmd_info(unsigned int countsize)
> +{
> +       unsigned int cmd_info;
> +
> +       cmd_info = (countsize >> 2);
> +
> +       cmd_info = (((cmd_info & CMDINFOMASK) << 18)|GDMAEN|D_INTS);
> +       cmd_info &= ~(GDMAMS|DADIR|SADIR|DAFIX|SAFIX|TWSMASK);
> +       cmd_info |= TWS;
> +
> +       return cmd_info;
> +
> +}
> +
> +static unsigned int get_descplist_num(unsigned int size, unsigned int *leave)
> +{
> +       unsigned int dscp_num, other_num;
> +
> +       dscp_num = 0;
> +       other_num = 0;
> +
> +       dscp_num = size / COUTN_TRANSFER;
> +       other_num = size % COUTN_TRANSFER;
> +
> +       if (other_num)
> +               dscp_num += 1;
> +
> +       *leave = other_num;
> +
> +       return dscp_num;
> +
> +}
> +
> +int nuc900_start_dma(const char *dev_name, dma_addr_t dma_src,
> +                                       dma_addr_t dma_dst, unsigned int size)
> +{
> +       struct nuc900_dma_descp *descp = NULL;
> +       struct nuc900_dma_t *dma = NULL;
> +       unsigned int i, dscp_num, other_num, val;
> +
> +       BUG_ON((!size|!dev_name));
> +
> +       match_dmachan_fromname(dev_name, dma);
> +
> +       if (!dma)
> +               return -ENXIO;
> +
> +       dscp_num = get_descplist_num(size, &other_num);
> +
> +       descp = kzalloc(dscp_num * sizeof(struct nuc900_dma_t), GFP_KERNEL);
> +
> +       if (!descp)
> +               return -ENOMEM;
> +
> +       dma->descp = descp;
> +
> +       for (i = 0; i < dscp_num; i++) {
> +               descp->next_descp = set_start_cmd(1);
> +               descp->srcaddr = dma_src + COUTN_TRANSFER * i;
> +               descp->dstaddr = dma_dst + COUTN_TRANSFER * i;
> +               descp->commandinfo = set_cmd_info(COUTN_TRANSFER);
> +               descp++;
> +       }
> +       descp--;
> +       descp->next_descp = set_start_cmd(0);
> +       descp->commandinfo = set_cmd_info(other_num);
> +
> +
> +       val = set_start_cmd(1);
> +       val |= (unsigned int)(dma->descp);
> +       local_irq_disable();
> +       __raw_writel(val, dma->dma_reg + GDMA_GDGA);
> +
> +       val = __raw_readl(GDMA_INTCS);
> +       val |= (ENTC0F|ENTC1F);
> +       __raw_writel(val, GDMA_INTCS);
> +       local_irq_enable();
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(nuc900_start_dma);
> +
> +void __init nuc900_init_dma(void)
> +{
> +       unsigned        i;
> +       struct nuc900_dma_t *dma_channel;
> +       spin_lock_init(&dma_chan_lock);
> +       for (i = 0; i < NUC900_DMA_CHANNELS; i++) {
> +               dma_channel = &dma_chan[i];
> +               dma_channel->dma_reg = DMA_BASE + i * CHANNELINERV;
> +               dma_channel->device = NULL;
> +       }
> +
> +       dmachan0 = &dma_chan[0];
> +       dmachan1 = &dma_chan[1];
> +}
> diff -Naur linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile
> linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile
> --- linux-2.6.32-rc8/arch/arm/mach-w90x900/Makefile     2009-11-20
> 06:32:38.000000000 +0800
> +++ linux-2.6.32-rc8-modify/arch/arm/mach-w90x900/Makefile      2010-11-20
> 00:02:07.000000000 +0800
> @@ -5,7 +5,7 @@
>  # Object file lists.
> 
>  obj-y                          := irq.o time.o mfp.o gpio.o clock.o
> -obj-y                          += clksel.o dev.o cpu.o
> +obj-y                          += clksel.o dev.o cpu.o dma.o
>  # W90X900 CPU support files
> 
>  obj-$(CONFIG_CPU_W90P910)      += nuc910.o
> ----
> 
