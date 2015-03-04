From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 4 Mar 2015 18:57:55 +0530
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_Zhc1uLf_grsbzOs3ahJHJXXZ+BF__702mEPPL=SWPU5nzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2015 at 16:11, Lee Jones <lee.jones@linaro.org> wrote:

> ---
>  drivers/mailbox/Kconfig       |   7 +
>  drivers/mailbox/Makefile      |   2 +
>  drivers/mailbox/mailbox-sti.c | 664 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mailbox_sti.h   | 128 ++++++++
>
How about the header in include/linux/soc/sti/  away from the limelight?

> + */
> +#define MBOX_HW_MAX            5
> +#define MBOX_NO_RX             0xff
> +
> +static struct sti_mbox_device mdev_rxs[MBOX_HW_MAX];
> +
> +static DEFINE_SPINLOCK(sti_mbox_irqs_lock);
> +
> +/* Mailbox H/W preparations */
> +static struct irq_chip sti_mbox_irq_chip;
> +
> +static inline bool sti_mbox_chan_is_rx(struct sti_mbox_dev_data *mbox)
> +{
> +       return ((mbox->rx_id != MBOX_NO_RX) && (mbox->rx_inst != MBOX_NO_RX));
> +}
> +
> +static inline bool sti_mbox_chan_is_tx(struct sti_mbox_dev_data *mbox)
> +{
> +       return ((mbox->tx_id != MBOX_NO_RX) && (mbox->tx_inst != MBOX_NO_RX));
>
  nit:  something neutral like MBOX_ABSENT or anything without RX?

> +/* Message management */
> +static void sti_mbox_read(struct sti_mbox_dev_data *mbox,
> +                         struct sti_mbox_msg *msg)
> +{
> +       struct sti_mbox_data *md = &mbox->mdata;
> +       void __iomem *hdr = md->rx_addr;
> +
> +       /* Read data payload */
> +       msg->dsize = readb(hdr);
> +       msg->pdata = (u8*)++hdr;
> +}
> +
> +static void sti_mbox_write(struct sti_mbox_dev_data *mbox, void *data)
> +{
> +       struct sti_mbox_data *md = &mbox->mdata;
> +       struct sti_mbox_msg *msg = (struct sti_mbox_msg *)data;
> +       u32 len = msg->dsize;
> +       void __iomem *hdr;
> +       u8 *wrb;
> +       unsigned int j;
> +
> +       hdr = md->tx_addr;
> +
> +       /* Payload size */
> +       writeb((u8)len, hdr);
>
So the first 1byte bitfield is the 'size' of the packset. could you
please get rid of sti_mbox_msg.dsize?

> +
> +       wrb = msg->pdata;
> +       if (!wrb)
> +               return;
> +
> +       /* Payload data */
> +       for (j = 0, hdr++; j < len; j++, wrb++, hdr++)
> +               writeb(*wrb, hdr);
> +}
> +
> +/* Mailbox IRQ handle functions */
> +static void sti_mbox_enable_irq(struct sti_mbox_instance *mbinst, u32 msk)
> +{
> +       struct sti_mbox_device *mdev = mbinst->parent;
> +       struct sti_mbox_attribute *p = mdev->cfg;
> +       void __iomem *base;
> +       unsigned long flags;
> +
> +       base = mdev->mdev_rx->mbox_reg_base + (mbinst->id * p->num_inst);
> +       spin_lock_irqsave(&sti_mbox_irqs_lock, flags);
> +       mbinst->irq_msk |= msk;
> +
> +       writel_relaxed(msk, base + p->reg_ena_set);
> +
> +       spin_unlock_irqrestore(&sti_mbox_irqs_lock, flags);
> +}
> +
> +static void sti_mbox_disable_irq(struct sti_mbox_instance *mbinst, u32 msk)
> +{
> +       struct sti_mbox_device *mdev = mbinst->parent;
> +       struct sti_mbox_attribute *p = mdev->cfg;
> +       void __iomem *base;
> +       unsigned long flags;
> +
> +       base = mdev->mdev_rx->mbox_reg_base + (mbinst->id * p->num_inst);
> +       spin_lock_irqsave(&sti_mbox_irqs_lock, flags);
> +       mbinst->irq_msk &= ~msk;
> +       writel_relaxed(msk, base + p->reg_ena_clr);
> +       spin_unlock_irqrestore(&sti_mbox_irqs_lock, flags);
> +}
> +
> +static void sti_mbox_clr_irq(struct sti_mbox_instance *mbinst, u32 msk)
> +{
> +       struct sti_mbox_device *mdev = mbinst->parent;
> +       struct sti_mbox_attribute *p = mdev->cfg;
> +       void __iomem *base;
> +
> +       base = mdev->mdev_rx->mbox_reg_base + (mbinst->id * p->num_inst);
> +       writel_relaxed(msk, base + p->reg_clr);
> +}
> +
> +static irqreturn_t sti_mbox_thread_interrupt(int irq, void *data)
> +{
> +       struct mbox_chan *chan = data;
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_device *mdev_rx = mbox->parent->mdev_rx;
> +
> +       mbox_chan_received_data(chan, (void *)mbox->msg);
> +       sti_mbox_enable_irq(mdev_rx->mbinst[mbox->rx_inst], BIT(mbox->rx_id));
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t sti_mbox_interrupt(int irq, void *data)
> +{
> +       struct mbox_chan *chan = data;
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_data *md = &mbox->mdata;
> +       struct sti_mbox_device *mdev_rx = mbox->parent->mdev_rx;
> +
> +       sti_mbox_disable_irq(mdev_rx->mbinst[mbox->rx_inst], BIT(mbox->rx_id));
> +
> +       if (md->rx_addr != NULL)
> +               sti_mbox_read(mbox, mbox->msg);
> +
> +       return IRQ_WAKE_THREAD;
> +}
> +
> +
> +static irqreturn_t sti_mbox_irq_handler(int irq, void *data)
> +{
> +       struct sti_mbox_device *mdev_rx = data;
> +       struct sti_mbox_attribute *p = mdev_rx->cfg;
> +       struct irq_domain *mbox_irq_domain;
> +       void __iomem *base;
> +       u32 irq_chan;
> +       unsigned long bits = 0;
> +       u8 n;
> +       int i;
> +
> +       base = mdev_rx->mbox_reg_base + mdev_rx->cfg->reg_val;
> +
> +       for (i = 0; i < p->num_inst; i++) {
> +               bits = readl_relaxed(base + (i * p->num_inst));
> +               if (bits)
> +                       break;
> +       }
> +
> +       if (unlikely(!bits))
> +               return IRQ_NONE;
> +
> +       mbox_irq_domain = mdev_rx->mbinst[i]->irq_domain;
> +
> +       for (n = 0; bits; n++) {
> +               if (test_and_clear_bit(n, &bits)) {
> +
> +                       irq_chan = irq_find_mapping(mbox_irq_domain, n);
> +                       if (mdev_rx->mbinst[i]->irq_msk & BIT(n)) {
> +                               generic_handle_irq(irq_chan);
> +                               sti_mbox_clr_irq(mdev_rx->mbinst[i], BIT(n));
> +
> +                       } else
> +                               dev_warn(mdev_rx->dev,
> +                                        "Unexpected mailbox interrupt\n"
> +                                        "mask: %x\n",
> +                                        mdev_rx->mbinst[i]->irq_msk);
> +               }
> +       }
> +       return IRQ_HANDLED;
> +}
> +
> +/* Channel management */
> +static int sti_mbox_startup(struct mbox_chan *chan)
> +{
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_device *mdev = mbox->parent;
> +       char name[32];
> +       int ret = 0;
> +
> +       /* Allocate Rx msg per channel */
> +       mbox->msg = devm_kzalloc(mdev->dev, sizeof(struct sti_mbox_device),
> +                                 GFP_KERNEL);
> +       if (!mbox->msg)
> +               return -ENOMEM;
> +
> +       if (sti_mbox_chan_is_rx(mbox)) {
> +               snprintf(name, sizeof(name), "%s-%d", mdev->name,
> +                        mbox->chan_id);
> +               /* IRQ automatically enabled */
> +               ret = request_threaded_irq(mbox->irq, sti_mbox_interrupt,
> +                                          sti_mbox_thread_interrupt,
> +                                          IRQF_SHARED, name, chan);
> +               if (ret)
> +                       dev_err(mdev->dev,
> +                               "failed to register mailbox interrupt:%d\n",
> +                               ret);
> +       }
> +
> +       return ret;
> +}
> +
> +static void sti_mbox_shutdown(struct mbox_chan *chan)
> +{
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_device *mdev = mbox->parent;
> +
> +       /* IRQ automatically disabled */
> +       free_irq(mbox->irq, chan);
> +
> +       /* Free Rx msg */
> +       devm_kfree(mdev->dev, mbox->msg);
> +}
> +
> +static bool sti_mbox_tx_is_ready(struct mbox_chan *chan)
> +{
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_device *mdev = mbox->parent;
> +       struct sti_mbox_attribute *p = mdev->cfg;
> +       void __iomem *base;
> +
> +       /*
> +        *  Check if tx mbox has got a pending interrupt, and if it is enabled
> +        *  before sending a new message
> +        */
> +       base = mdev->mbox_reg_base + (p->num_inst * mbox->tx_inst);
> +
> +       if (!(readl_relaxed(base + p->reg_ena_val) & BIT(mbox->tx_id))) {
> +               dev_warn(mdev->dev, "Mbox: %d, inst: %x, chan: %x disabled\n",
> +                       mdev->id, mbox->tx_inst, mbox->tx_id);
> +               return false;
> +       }
> +
> +       if (readl_relaxed(base + p->reg_val) & BIT(mbox->tx_id)) {
> +               dev_warn(mdev->dev, "Mbox: %d, inst: %x, chan: %x not ready\n",
> +                       mdev->id, mbox->tx_inst, mbox->tx_id);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool sti_mbox_tx_is_done(struct mbox_chan *chan)
> +{
> +       return sti_mbox_tx_is_ready(chan);
> +}
Why not simply move sti_mbox_tx_is_ready -> sti_mbox_tx_is_done ?

> +
> +static int sti_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct sti_mbox_dev_data *mbox = chan->con_priv;
> +       struct sti_mbox_data *md = &mbox->mdata;
> +       struct sti_mbox_device *mdev = mbox->parent;
> +       struct sti_mbox_attribute *p = mdev->cfg;
> +       void __iomem *base;
> +
> +       dev_info(mdev->dev, "Using Mbox (%x) %s: channel (%d)\n",
> +                mdev->id, mdev->name, mbox->chan_id);
> +
> +       base = mdev->mbox_reg_base + (p->num_inst * mbox->tx_inst);
> +
> +       if ((!data) || (!sti_mbox_chan_is_tx(mbox)))
>
nit: too much protection.

> +               return -EINVAL;
> +
> +       if (sti_mbox_tx_is_ready(chan)) {
.send_data() isn't called, unless last_tx_done(). So you may drop the check


> +
> +       mbox_chans = of_get_property(np, "st,mbox-chans", &data_len);
> +       if (!mbox_chans) {
> +               dev_err(&pdev->dev, "no mbox device data found\n");
> +               return -ENODEV;
> +       }
> +
> +       for (i = 0; i < mb_count; i++) {
> +               tmp = mbox_chans + i;
> +               mbox->rx_id = (u32)of_read_number(tmp, 1);
> +               mbox->rx_inst = (u32)of_read_number(tmp+1, 1);
> +               mbox->tx_id = (u32)of_read_number(tmp+2, 1);
> +               mbox->tx_inst = (u32)of_read_number(tmp+3, 1);
nit:   some spaces and
  of_property_read_u32_index(np, "st,mbox-chans", 0, &mbox->rx_id)
  of_property_read_u32_index(np, "st,mbox-chans", 1, &mbox->rx_inst)
  of_property_read_u32_index(np, "st,mbox-chans", 2, &mbox->tx_id)
  of_property_read_u32_index(np, "st,mbox-chans", 3, &mbox->tx_inst)  ?


> +
> +               /* Affect Rx configuration to the channel if needed */
> +               if (sti_mbox_chan_is_rx(mbox)) {
> +                       if (mdev->rx_id == MBOX_NO_RX) {
> +                               dev_err(&pdev->dev, "Mbox Rx id not defined for Mailbox: %s\n"
> +                                       , mdev->name);
> +                               return -EINVAL;
> +                       }
> +
> +                       mbinst = mdev->mdev_rx->mbinst[mbox->rx_inst];
> +
> +                       if (!mbinst)
> +                               return -EINVAL;
> +
> +                       if (!mbinst->irq_domain)
> +                               return -EINVAL;
> +
> +                       mbox->irq = irq_create_mapping(mbinst->irq_domain,
> +                                                      mbox->rx_id);
>
simply assigning same IRQ to all controller DT nodes and using
IRQF_SHARED for the common handler, wouldn't work?


> +                       sti_mbox_disable_irq(mbinst, BIT(mbox->rx_id));
> +                       sti_mbox_clr_irq(mbinst, BIT(mbox->rx_id));
> +               }
> +               /*
> +                * read here rx_id and fill mbox->instance accordly to what
> +                * we have registered.
> +                */
> +               mbox->parent = mdev;
> +               mbox->chan_id = i;
> +               chans[i].con_priv = (struct sti_mbox_dev_data *)mbox;
>
isn't mbox already a struct sti_mbox_dev_data *


> +       }
> +       mdev->dev = &pdev->dev;
> +
> +       /* sti mailbox does not have a Tx-Done or Tx-Ready IRQ */
> +       mdev->controller.txdone_irq = false;
> +       mdev->controller.txdone_poll = true;
> +       mdev->controller.txpoll_period = 1000;
>
does your remote really take ~1sec to respond?


> +++ b/include/linux/mailbox_sti.h
> @@ -0,0 +1,128 @@
> +/*
> + * mailbox-sti.h
> + *
> + * Copyright (C) 2014 ST Microelectronics
> + *
> + * Author:  <olivier.lebreton@st.com> for ST Microelectronics
> + * Author:  <alexandre.torgue@st.com> for ST Microelectronics
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/mailbox_controller.h>
> +
> +/* Max instance per HW mailbox */
> +#define MBOX_INST_MAX          4
> +
> +/*
> + * struct sti_mbox_msg - sti mailbox message description
> + * @dsize:             data payload size
> + * @pdata:             message data payload
> + */
> +struct sti_mbox_msg {
> +       u32             dsize;
> +       u8              *pdata;
> +};
> +
> +/*
> + * struct sti_mbox_attribute - sti mailbox device attribute info
> + * @num_inst:          maximum number of instance in one HW mailbox
> + * @num_mbox:          maximum number of channel per instance
> + * @reg_set:           register offset to generate mailbox interrupt
> + * @reg_clr:           register offset to clear pending interrupt
> + * @reg_val:           register offset to read interrupt status
> + * @reg_ena_set:       register offset to enable mailbox
> + * @reg_ena_val:       register offset to read enable status
> + * @reg_ena_clr:       register offset to disable mailbox
> + */
> +struct sti_mbox_attribute {
> +       int             num_inst;
> +       int             num_mbox;
> +       int             reg_set;
> +       int             reg_clr;
> +       int             reg_val;
> +       int             reg_ena_val;
> +       int             reg_ena_set;
> +       int             reg_ena_clr;
> +};
> +
> +/*
> + * struct sti_mbox_data - sti mailbox buffer attribute info
> + * @rx_offset:         rx mailbox addr in shared memory
> + * @tx_offset:         tx mailbox addr in shared memory
> + */
> +struct sti_mbox_data {
> +       void __iomem    *rx_addr;
> +       void __iomem    *tx_addr;
> +};
> +
> +/*
> + * struct sti_mbox_dev_data - sti channel info
> + * An IP mailbox is composed by 4 instances.
> + * Each instance is composed by 32 channels (also named mbox)
> + * This means that we have potentially 128 channels (128 sw interrupts).
> + * A channel an be used for TX way, RX way or both.
> + *
> + * @mdata:             mailbox buffer info
> + * @parent:            mailbox device to which it is attached
> + * @msg:               rx message
> + * @chan_id:           channel id in an instance
> + * @irq:               irq number (virtual) assigned to the channel
> + * @rx_inst:           instance for the channel used in RX way
> + * @rx_id:             id in an instance for the channel used in RX way
> + * @tx_inst:           instance for the channel used in TX way
> + * @tx_id:             id in an instance for the channel used in TX way
> + */
> +struct sti_mbox_dev_data {
> +       struct sti_mbox_data            mdata;
> +       struct sti_mbox_device          *parent;
> +       struct sti_mbox_msg             *msg;
> +       u32                             chan_id;
> +       u32                             irq;
> +       u32                             rx_inst;
> +       u32                             rx_id;
> +       u32                             tx_inst;
> +       u32                             tx_id;
> +};
> +
> +struct sti_mbox_instance {
> +       struct irq_domain       *irq_domain;
> +       struct sti_mbox_device  *parent;
> +       u32                     irq_msk;
> +       int                     id;
> +};
> +
> +/*
> + * struct sti_mbox_device - sti mailbox device data
> + * An IP mailbox is composed by 4 instances.
> + * Each instance is composed by 32 channels (also named mbox)
> + * This means that we have potentially 128 channels (128 sw interrupts).
> + * A channel an be used for TX way, RX way or both.
> + *
> + * @id:                        Id of the mailbox
> + * @irq:               Interrupt number assigned to mailbox Rx
> + * @cfg:               mailbox attribute data
> + * @dev:               device to which it is attached
> + * @mbox_reg_base:     base address of the register mapping region
> + * @controller:                representation of a communication channel controller
> + * @type:              type of mailbox (tx, rx or rx_tx)
> + * @name:              name of the mailbox
> + * @mbox_inst          data for several instances in the mailbox
> + */
> +struct sti_mbox_device {
> +       int                             id;
> +       int                             irq;
> +       struct sti_mbox_attribute       *cfg;
> +       struct device                   *dev;
> +       void __iomem                    *mbox_reg_base;
> +       struct mbox_controller          controller;
> +       const char                      *type;
> +       struct sti_mbox_device          *mdev_rx;
> +       u32                             rx_id;
> +       char                            name[64];
> +       struct sti_mbox_instance        *mbinst[MBOX_INST_MAX];
> +};
>
There isn't any client driver in this patchset to tell exactly, but it
seems the header could be split into one shared between mailbox
clients and provider and another internal to client/provider ?
