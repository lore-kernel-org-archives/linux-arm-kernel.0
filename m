From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 6 Jul 2016 15:17:59 +0200
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ@mail.gmail.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ@mail.gmail.com>
Message-ID: <CAA3gFWuY78ouBwiXfcArojbc5wOBq_5AfLQTKrr-+ELYyMcmhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-04 17:38 GMT+02:00 Jassi Brar <jassisinghbrar@gmail.com>:
> On Tue, Jun 21, 2016 at 3:32 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> Add Amlogic Meson SoCs Message-Handling-Unit as mailbox controller
>> with 2 independent channels/links to communicate with a remote processor.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mailbox/Makefile    |   2 +
>>  drivers/mailbox/meson_mhu.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
>>
> Can we call it pdev_mhu.c or similar so that some other platform using
> the MHU as a platform_device wouldn't have to embarrassingly call it
> 'Meson's MHU'?  And also the replace meson with that prefix in the
> code.

Yes, it may deserve a more generic naming, but pdev_mhu is not good
looking at all !
What about platform_mhu ?

>
>>  2 files changed, 201 insertions(+)
>>  create mode 100644 drivers/mailbox/meson_mhu.c
>>
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index 0be3e74..6aa9dbe 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>> @@ -25,3 +25,5 @@ obj-$(CONFIG_TI_MESSAGE_MANAGER) += ti-msgmgr.o
>>  obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>>
>>  obj-$(CONFIG_HI6220_MBOX)      += hi6220-mailbox.o
>> +
>> +obj-$(CONFIG_ARCH_MESON)       += meson_mhu.o
>> diff --git a/drivers/mailbox/meson_mhu.c b/drivers/mailbox/meson_mhu.c
>> new file mode 100644
>> index 0000000..0576b92
>> --- /dev/null
>> +++ b/drivers/mailbox/meson_mhu.c
>> @@ -0,0 +1,199 @@
>> +/*
>> + * Copyright (C) 2016 BayLibre SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + * Heavily based on meson_mhu.c from :
>> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mailbox_controller.h>
>> +
>> +#define INTR_SET_OFS   0x0
>> +#define INTR_STAT_OFS  0x4
>> +#define INTR_CLR_OFS   0x8
>> +
>> +#define MHU_LP_OFFSET  0x10
>> +#define MHU_HP_OFFSET  0x1c
>> +
>> +#define TX_REG_OFFSET  0x24
>> +
>> +#define MHU_CHANS      2
>> +
>> +struct meson_mhu_link {
>> +       unsigned int irq;
>> +       void __iomem *tx_reg;
>> +       void __iomem *rx_reg;
>> +};
>> +
>> +struct meson_mhu {
>> +       void __iomem *base;
>> +       struct meson_mhu_link mlink[MHU_CHANS];
>> +       struct mbox_chan chan[MHU_CHANS];
>> +       struct mbox_controller mbox;
>> +};
>> +
>> +static irqreturn_t meson_mhu_rx_interrupt(int irq, void *p)
>> +{
>> +       struct mbox_chan *chan = p;
>> +       struct meson_mhu_link *mlink = chan->con_priv;
>> +       u32 val;
>> +
>> +       val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
>> +       if (!val)
>> +               return IRQ_NONE;
>> +
>> +       mbox_chan_received_data(chan, (void *)&val);
>> +
>> +       writel_relaxed(~0, mlink->rx_reg + INTR_CLR_OFS);
>> +
> How about sync with arm_mhu.c by doing writel_relaxed(val,
> mlink->rx_reg + INTR_CLR_OFS) ?

The ~0 was taken from the vendor driver, but writing val should work,
I must test this change.

>
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static bool meson_mhu_last_tx_done(struct mbox_chan *chan)
>> +{
>> +       struct meson_mhu_link *mlink = chan->con_priv;
>> +       u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +
>> +       return (val == 0);
>> +}
>> +
>> +static int meson_mhu_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct meson_mhu_link *mlink = chan->con_priv;
>> +       u32 *arg = data;
>> +
>> +       writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
>> +
>> +       return 0;
>> +}
>> +
>> +static int meson_mhu_startup(struct mbox_chan *chan)
>> +{
>> +       struct meson_mhu_link *mlink = chan->con_priv;
>> +       int ret;
>> +
> arm_mhu.c clears any pending TX before taking over by doing ...
>        val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>        writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);

I dropped it not knowing it it was necessary because not pressent in
the vendor code, but yes it would clearly be good to get it back.

>> +       ret = request_irq(mlink->irq, meson_mhu_rx_interrupt,
>> +                         IRQF_ONESHOT, "meson_mhu_link", chan);
>> +       if (ret) {
>> +               dev_err(chan->mbox->dev,
>> +                       "Unable to acquire IRQ %d\n", mlink->irq);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void meson_mhu_shutdown(struct mbox_chan *chan)
>> +{
>> +       struct meson_mhu_link *mlink = chan->con_priv;
>> +
>> +       free_irq(mlink->irq, chan);
>> +}
>> +
>> +static const struct mbox_chan_ops meson_mhu_ops = {
>> +       .send_data = meson_mhu_send_data,
>> +       .startup = meson_mhu_startup,
>> +       .shutdown = meson_mhu_shutdown,
>> +       .last_tx_done = meson_mhu_last_tx_done,
>> +};
>>
> My two comments above may not be necessary for your platform, but I
> would suggest we keep the core (from the declaration of struct
> meson_mhu_link to this point) in sync with arm_mhu.c

Yes, I'll keep them as synced as possible.

>> +static int meson_mhu_probe(struct platform_device *pdev)
>> +{
>> +       int i, err;
>> +       struct meson_mhu *mhu;
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       int meson_mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET};
>> +
>> +       /* Allocate memory for device */
>> +       mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
>> +       if (!mhu)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       mhu->base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(mhu->base)) {
>> +               dev_err(dev, "ioremap failed\n");
>> +               return PTR_ERR(mhu->base);
>> +       }
>> +
>> +       for (i = 0; i < MHU_CHANS; i++) {
>> +               mhu->chan[i].con_priv = &mhu->mlink[i];
>> +               mhu->mlink[i].irq = platform_get_irq(pdev, i);
>> +               if (mhu->mlink[i].irq < 0) {
>> +                       dev_err(dev, "failed to get irq%d\n", i);
>> +                       return mhu->mlink[i].irq;
>> +               }
>> +               mhu->mlink[i].rx_reg = mhu->base + meson_mhu_reg[i];
>> +               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
>> +       }
>> +
>> +       mhu->mbox.dev = dev;
>> +       mhu->mbox.chans = &mhu->chan[0];
>> +       mhu->mbox.num_chans = MHU_CHANS;
>> +       mhu->mbox.ops = &meson_mhu_ops;
>> +       mhu->mbox.txdone_irq = false;
>> +       mhu->mbox.txdone_poll = true;
>> +       mhu->mbox.txpoll_period = 1;
>> +
>> +       platform_set_drvdata(pdev, mhu);
>> +
>> +       err = mbox_controller_register(&mhu->mbox);
>> +       if (err) {
>> +               dev_err(dev, "Failed to register mailboxes %d\n", err);
>> +               return err;
>> +       }
>> +
>> +       dev_info(dev, "Meson MHU Mailbox registered\n");
>> +       return 0;
>> +}
>> +
>> +static int meson_mhu_remove(struct platform_device *pdev)
>> +{
>> +       struct meson_mhu *mhu = platform_get_drvdata(pdev);
>> +
>> +       mbox_controller_unregister(&mhu->mbox);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id meson_mhu_dt_ids[] = {
>> +       { .compatible = "amlogic,meson-gxbb-mhu", },
>> +       { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, meson_mhu_ids);
>> +
>> +static struct platform_driver meson_wdt_driver = {
>> +       .probe  = meson_mhu_probe,
>> +       .remove = meson_mhu_remove,
>> +       .driver = {
>> +               .name = "meson-mhu",
>> +               .of_match_table = meson_mhu_dt_ids,
>> +       },
>> +};
>> +
>> +module_platform_driver(meson_wdt_driver);
>> +
> wdt as in watchdog-timer from drivers/watchdog/meson_wdt.c ? :)

Sorry, it was a leftover from another pdev driver, but the freshly
pushed meson_gxbb_wdt !

> Thanks.

Thanks for the feedback,
Neil
