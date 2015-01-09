From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 9 Jan 2015 18:49:12 +0530
Subject: [PATCH v3 2/8] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <20150109125102.GL12302@n2100.arm.linux.org.uk>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420802889-4041-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150109125102.GL12302@n2100.arm.linux.org.uk>
Message-ID: <CAJe_ZhdkF5o91HE8woAw0-DN5TuS_j6LM15NF0z6oHcQwPvnsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 18:21, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 09, 2015 at 07:28:09PM +0800, Vincent Yang wrote:
>> +static irqreturn_t mhu_rx_interrupt(int irq, void *p)
>> +{
>> +     struct mbox_chan *chan = p;
>> +     struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>> +     u32 val;
>> +
>> +     pr_debug("%s:%d\n", __func__, __LINE__);
>> +     val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
>> +     mbox_chan_received_data(chan, (void *)val);
>> +
>> +     writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
>> +
>> +     return IRQ_HANDLED;
>
> What if 'val' was zero - is the interrupt still "handled" ?
>
This irq shouldn't fire unless RX_STAT register has some non-zero value.

>> +static int mhu_startup(struct mbox_chan *chan)
>> +{
>> +     struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>
> Casts from void * are not necessary (repeated many times.)
>
>> +     u32 val;
>> +     int ret;
>> +
>> +     pr_debug("%s:%d\n", __func__, __LINE__);
>> +     val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +     writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
>> +
>> +     ret = request_irq(mlink->irq, mhu_rx_interrupt,
>> +                       IRQF_SHARED, "mhu_link", chan);
>> +     if (unlikely(ret)) {
>> +             pr_err("Unable to aquire IRQ\n");
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>
> Needlessly complicated, and doesn't need that unlikely().  Also doesn't
> print the reason for failure, and merely printing "Unable to aquire IRQ"
> into the kernel log with no indication what produced it is silly.  You
> have the device struct (via chan->mbox->dev), so using dev_err() is a
> definite possibility and improvement.
>
> I'm sure this can be cleaned up and simplified.
>
>> +static int arm_mhu_probe(struct platform_device *pdev)
>> +{
>> +     int i, err;
>> +     struct arm_mhu *mhu;
>> +     struct resource *res;
>> +     int mhu_reg[3] = {0x0, 0x20, 0x200};
>> +
>> +     /* Allocate memory for device */
>> +     mhu = kzalloc(sizeof(*mhu), GFP_KERNEL);
>> +     if (!mhu)
>> +             return -ENOMEM;
>
> Consider using dev_kzalloc().
>
>> +
>> +     mhu->clk = clk_get(&pdev->dev, "clk");
>
> devm_clk_get().
>
>> +     if (unlikely(IS_ERR(mhu->clk)))
>> +             dev_info(&pdev->dev, "unable to init clock\n");
>> +     else
>> +             clk_prepare_enable(mhu->clk);
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     mhu->base = ioremap(res->start, resource_size(res));
>
> That's an oops waiting to happen.  Consider using devm_ioremap_resource()
> which will check for !res.
>
>> +     if (!mhu->base) {
>> +             dev_err(&pdev->dev, "ioremap failed.\n");
>> +             kfree(mhu);
>> +             return -EBUSY;
>> +     }
>> +
>> +     for (i = 0; i < 3; i++) {
>> +             mhu->chan[i].con_priv = &mhu->mlink[i];
>> +             res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> +             mhu->mlink[i].irq = res->start;
>> +             mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
>> +             mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
>> +     }
>> +
>> +     mhu->mbox.dev = &pdev->dev;
>> +     mhu->mbox.chans = &mhu->chan[0];
>> +     mhu->mbox.num_chans = 3;
>> +     mhu->mbox.ops = &mhu_ops;
>> +     mhu->mbox.txdone_irq = false;
>> +     mhu->mbox.txdone_poll = true;
>> +     mhu->mbox.txpoll_period = 10;
>> +
>> +     platform_set_drvdata(pdev, mhu);
>> +
>> +     err = mbox_controller_register(&mhu->mbox);
>> +     if (err) {
>> +             dev_err(&pdev->dev, "Failed to register mailboxes %d\n", err);
>> +             iounmap(mhu->base);
>
> You don't clk_put() the clock here.  Using devm_* as suggested above
> means you wouldn't have made this mistake here...
>
>> +             kfree(mhu);
>> +     } else {
>> +             dev_info(&pdev->dev, "ARM MHU Mailbox registered\n");
>> +     }
>> +
>> +     return 0;
>
> Always returns success even if mbox_controller_register() fails?
>
>> +}
>> +
>> +static int arm_mhu_remove(struct platform_device *pdev)
>> +{
>> +     struct arm_mhu *mhu = platform_get_drvdata(pdev);
>> +
>> +     mbox_controller_unregister(&mhu->mbox);
>> +
>> +     iounmap(mhu->base);
>> +
>> +     if (!IS_ERR(mhu->clk))
>> +             clk_disable_unprepare(mhu->clk);
>
> No clk_put() ?  If you used devm_* stuff as suggested above, you wouldn't
> need to...
>
Yes, we should have implemented managed resource allocation. Will do.

Thanks,
Jassi
