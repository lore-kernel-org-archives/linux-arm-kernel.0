From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 17 Jul 2014 11:55:44 +0530
Subject: [PATCH 7/8] mailbox: f_mhu: add driver for Fujitsu MHU controller
In-Reply-To: <53C6B83D.80602@arm.com>
References: <1405233128-4799-1-git-send-email-mollie.wu@linaro.org>
 <53C6B83D.80602@arm.com>
Message-ID: <CAJe_Zhe_kqmeeu9vF3CZwu3WR=P-nj13Bx+VOBCE7NfGzGPx=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2014 23:07, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Mollie,
>
>
> On 13/07/14 07:32, Mollie Wu wrote:
>>
>> Add driver for the proprietary Mailbox controller (f_mhu) in MB86S7x.
>
>
> And it looks like this is not Fujitsu proprietary MHU, it's exactly same IP
> on JUNO(ARM64 development platform from ARM [1]). I was not sure it's
> standard
> IP used on other SoCs too, I too wrote similar driver :(.
>
Same here :)

> Can you please confirm this by reading Peripheral ID(PID: 0xFD0, 0xFE0 -
> 0xFEC) and Component ID(COMPID: 0xFF0 - 0xFFC). Are they
>
> PID  - 0x04 0x98 0xB0 0x1B 0x00
> COMPID - 0x0D 0xF0 0x05 0xB1
>
> If so we have do s/f_mhu/arm_mhu/g :)
>
Yup, we have to.

>
>> It has three channels - LowPri-NonSecure, HighPri-NonSecure and Secure.
>> The MB86S7x communicates over the HighPri-NonSecure channel.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
>> Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
>> ---
>>   drivers/mailbox/Kconfig  |   7 ++
>>   drivers/mailbox/Makefile |   2 +
>>   drivers/mailbox/f_mhu.c  | 227
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 236 insertions(+)
>>   create mode 100644 drivers/mailbox/f_mhu.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index c8b5c13..681aac2 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -6,6 +6,13 @@ menuconfig MAILBOX
>>           signals. Say Y if your platform supports hardware mailboxes.
>>
>>   if MAILBOX
>> +
>> +config MBOX_F_MHU
>> +       bool
>
>
> On Juno, there's nothing that prevents me from compiling this as module.
>
On S7x, even built-in is not early enough for our purposes. But yes,
now that we have company it should be made tristate.

>> +       depends on ARCH_MB86S7X
>
>
> Definitely not a requirement
>
It was, until we found each other ;)

>
>> +       help
>> +         Say Y here if you want to use the F_MHU IPCM support.
>> +
>
>
> Also it needs some description.
>
OK


>> +#define INTR_STAT_OFS  0x0
>> +#define INTR_SET_OFS   0x8
>> +#define INTR_CLR_OFS   0x10
>> +
>> +#define MHU_SCFG       0x400
>> +
>
>
> Remove this.(secure access only register)
>
See later.

>
>> +struct mhu_link {
>> +       unsigned irq;
>> +       spinlock_t lock; /* channel regs */
>> +       void __iomem *tx_reg;
>> +       void __iomem *rx_reg;
>> +};
>> +
>> +struct f_mhu {
>> +       void __iomem *base;
>> +       struct clk *clk;
>> +       struct mhu_link mlink[3];
>> +       struct mbox_chan chan[3];
>> +       struct mbox_controller mbox;
>> +};
>> +
>> +static irqreturn_t mhu_rx_interrupt(int irq, void *p)
>> +{
>> +       struct mbox_chan *chan = (struct mbox_chan *)p;
>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>
>
> You don't need explicit cast from void pointers
>
Yup

>
>> +       u32 val;
>> +
>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>
>
> Please remove all these debug prints.
>
These are as good as absent unless DEBUG is defined.

>
>> +       /* See NOTE_RX_DONE */
>> +       val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
>> +       mbox_chan_received_data(chan, (void *)val);
>> +
>> +       /*
>> +        * It is agreed with the remote firmware that the receiver
>> +        * will clear the STAT register indicating it is ready to
>> +        * receive next data - NOTE_RX_DONE
>> +        */
>
> This note could be added as how this mailbox works in general and
> it's not just Rx right ? Even Tx done is based on this logic.
> Basically the logic is valid on both directions.
>
Yes that is a protocol level agreement. Different f/w may behave differently.


>
>> +       writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static bool mhu_last_tx_done(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>> +       spin_lock_irqsave(&mlink->lock, flags);
>
>
> Why do we need this extra locks here ? mailbox core maintains
> per channel lock and uses it for at-least send_data IIRC. And this
> function is just reading status do we really need the lock ?
>
> I must be missing something here else  IMO we can get rid of this
> extra locks in here.
>
Yeah, probably unnecessary.

>> +       /* See NOTE_RX_DONE */
>> +       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +       spin_unlock_irqrestore(&mlink->lock, flags);
>> +
>> +       return (val == 0);
>> +}
>> +
>> +static int mhu_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>> +       unsigned long flags;
>> +
>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>> +       if (!mhu_last_tx_done(chan)) {
>> +               pr_err("%s:%d Shouldn't have seen the day!\n",
>> +                      __func__, __LINE__);
>> +               return -EBUSY;
>> +       }
>> +
>> +       spin_lock_irqsave(&mlink->lock, flags);
>> +       writel_relaxed((u32)data, mlink->tx_reg + INTR_SET_OFS);
>> +       spin_unlock_irqrestore(&mlink->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static int mhu_startup(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>> +       unsigned long flags;
>> +       u32 val;
>> +       int ret;
>> +
>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>> +       spin_lock_irqsave(&mlink->lock, flags);
>> +       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
>> +       spin_unlock_irqrestore(&mlink->lock, flags);
>> +
>> +       ret = request_irq(mlink->irq, mhu_rx_interrupt,
>> +                         IRQF_SHARED, "mhu_link", chan);
>
>
> Just a thought: Can this be threaded_irq instead ?
> Can move request_irq to probe instead esp. if threaded_irq ?
> That provides some flexibility to client's rx_callback.
>
This is controller driver, and can not know which client want
rx_callback in hard-irq context and which in thread_fn context.
Otherwise, request_irq() does evaluate to request_threaded_irq(), if
thats what you mean.
 There might be use-cases like (diagnostic or other) data transfer
over mailbox where we don't wanna increase latency, so we have to
provide a rx_callback in hard-irq context.

>
>> +       if (unlikely(ret)) {
>> +               pr_err("Unable to aquire IRQ\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void mhu_shutdown(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>> +
>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>> +       free_irq(mlink->irq, chan);
>> +}
>> +
>> +static struct mbox_chan_ops mhu_ops = {
>> +       .send_data = mhu_send_data,
>> +       .startup = mhu_startup,
>> +       .shutdown = mhu_shutdown,
>> +       .last_tx_done = mhu_last_tx_done,
>> +};
>> +
>> +static int f_mhu_probe(struct platform_device *pdev)
>> +{
>> +       int i, err;
>> +       struct f_mhu *mhu;
>> +       struct resource *res;
>> +       int mhu_reg[3] = {0x0, 0x20, 0x200};
>
>
> Probably this gets simplified when you remove secure channel access ?
>
we don't remove secure channel :)

>
>> +
>> +       /* Allocate memory for device */
>> +       mhu = kzalloc(sizeof(*mhu), GFP_KERNEL);
>> +       if (!mhu) {
>> +               dev_err(&pdev->dev, "failed to allocate memory.\n");
>> +               return -EBUSY;
>> +       }
>> +
>> +       mhu->clk = clk_get(&pdev->dev, "clk");
>> +       if (unlikely(IS_ERR(mhu->clk))) {
>> +               dev_err(&pdev->dev, "unable to init clock\n");
>
>
> Don't bail out if there's no clock specified in DT. Clock might not
> be a hard requirement.
>
Hmm.. OK.

>
>> +               kfree(mhu);
>> +               return -EINVAL;
>> +       }
>> +       clk_prepare_enable(mhu->clk);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       mhu->base = ioremap(res->start, resource_size(res));
>> +       if (!mhu->base) {
>> +               dev_err(&pdev->dev, "ioremap failed.\n");
>> +               kfree(mhu);
>> +               return -EBUSY;
>> +       }
>> +
>> +       /* Let UnTrustedOS's access violations don't bother us */
>> +       writel_relaxed(0, mhu->base + MHU_SCFG);
>> +
>
>
> Please don't do this. It can't work in non-secure mode. The firmware running
> with secure access needs to configure this appropriately.
>
ok.. pls see below.

> I might be missing to see, is there a binding document for this mhu ?
>
Yeah we need one.

>
>> +       for (i = 0; i < 3; i++) {
>> +               mhu->chan[i].con_priv = &mhu->mlink[i];
>> +               spin_lock_init(&mhu->mlink[i].lock);
>> +               res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> +               mhu->mlink[i].irq = res->start;
>> +               mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
>> +               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
>> +       }
>> +
>> +       mhu->mbox.dev = &pdev->dev;
>> +       mhu->mbox.chans = &mhu->chan[0];
>> +       mhu->mbox.num_chans = 3;
>
>
> Change this to 2, we shouldn't expose secular channel here as Linux can't
> access that anyway.
>
On the contrary, I think the device driver code should be able to
manage every resource - secure or non-secure. If we remove secure
channel option, what do we do on some other platform that needs it?
And Linux may not always run in non-secure mode.
 So here we populate all channels and let the clients knows which
channel to use via platform specific details - DT. Please note the
driver doesn't touch any secure resource if client doesn't ask it to
(except SCFG for now, which I think should have some S vs NS DT
binding).

>
>> +       mhu->mbox.ops = &mhu_ops;
>> +       mhu->mbox.txdone_irq = false;
>> +       mhu->mbox.txdone_poll = true;
>> +       mhu->mbox.txpoll_period = 10;
>> +
>> +       platform_set_drvdata(pdev, mhu);
>> +
>> +       err = mbox_controller_register(&mhu->mbox);
>> +       if (err) {
>> +               dev_err(&pdev->dev, "Failed to register mailboxes %d\n",
>> err);
>> +               iounmap(mhu->base);
>> +               kfree(mhu);
>> +       } else {
>> +               dev_info(&pdev->dev, "Fujitsu MHU Mailbox registered\n");
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
>
> Also to be module you need add remove.
>
Yup, OK.

>
>> +static const struct of_device_id f_mhu_dt_ids[] = {
>> +       { .compatible = "fujitsu,mhu" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, f_mhu_dt_ids);
>> +
>> +static struct platform_driver f_mhu_driver = {
>> +       .driver         = {
>> +               .name   = "f_mhu",
>> +               .owner = THIS_MODULE,
>> +               .of_match_table = f_mhu_dt_ids,
>> +       },
>> +       .probe          = f_mhu_probe,
>> +};
>> +
>> +static int __init f_mhu_init(void)
>> +{
>> +       return platform_driver_register(&f_mhu_driver);
>> +}
>> +module_init(f_mhu_init);
>
>
> This can be module_platform_driver instead.
>
OK

Thanks
-Jassi
