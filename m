From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 10 Aug 2015 13:35:29 +0530
Subject: [PATCHv7 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1436922022-17564-3-git-send-email-moritz.fischer@ettus.com>
References: <1436922022-17564-1-git-send-email-moritz.fischer@ettus.com>
 <1436922022-17564-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <CABb+yY3tpepdO=s9nb9kAE241sYVTTXB-ci_4ihuthHTekedNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 6:30 AM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:

> +
> +static void xilinx_mbox_rx_data(struct mbox_chan *chan)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +       u32 data;
> +
> +       if (xilinx_mbox_pending(mbox)) {
> +               data = readl_relaxed(mbox->mbox_base + MAILBOX_REG_RDDATA);
> +               mbox_chan_received_data(chan, (void *)data);
>
If RDDATA is a FIFO, then above seems wrong - you are assuming
messages are always going to be exactly 32-bits for every protocol.
Ideally you should empty the fifo fully, at least when RX has an
interrupt.

> +
> +static int xilinx_mbox_irq_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +       u32 *udata = data;
> +
> +       if (xilinx_mbox_full(mbox))
> +               return -EBUSY;
>
This check is redundant. last_tx_done already makes sure this is always true.

> +       /* enable interrupt before send */
> +       xilinx_mbox_tx_intmask(mbox, true);
> +
> +       writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
> +
>From status EMPTY and FULL, it seems WRDATA is a FIFO. So here also
you should expect messages to be <= fifo depth. And not assume exactly
32bit messages always.

> +
> +static bool xilinx_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +       /* return false if mailbox is full */
> +       return !xilinx_mbox_full(mbox);
>
Instead of FULL, I think it should check for stricter EMPTY status ...
mbox api submits only 1 message at a time.

> +
> +static bool xilinx_mbox_peek_data(struct mbox_chan *chan)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +       return xilinx_mbox_pending(mbox);
> +}
> +
> +static void xilinx_mbox_irq_shutdown(struct mbox_chan *chan)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +       /* mask all interrupts */
> +       writel_relaxed(0, mbox->mbox_base + MAILBOX_REG_IE);
> +
> +       clk_disable_unprepare(mbox->clk);
> +
> +       free_irq(mbox->irq, chan);
> +}
> +
> +static void xilinx_mbox_poll_shutdown(struct mbox_chan *chan)
> +{
> +       struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +       del_timer_sync(&mbox->rxpoll_timer);
> +
> +       clk_disable_unprepare(mbox->clk);
> +}
> +
> +static const struct mbox_chan_ops xilinx_mbox_irq_ops = {
> +       .send_data = xilinx_mbox_irq_send_data,
> +       .startup = xilinx_mbox_irq_startup,
> +       .shutdown = xilinx_mbox_irq_shutdown,
> +       .last_tx_done = xilinx_mbox_last_tx_done,
> +       .peek_data = xilinx_mbox_peek_data,
> +};
> +
> +static const struct mbox_chan_ops xilinx_mbox_poll_ops = {
> +       .send_data = xilinx_mbox_poll_send_data,
> +       .startup = xilinx_mbox_poll_startup,
> +       .shutdown = xilinx_mbox_poll_shutdown,
> +       .last_tx_done = xilinx_mbox_last_tx_done,
> +       .peek_data = xilinx_mbox_peek_data,
> +};
> +
> +static int xilinx_mbox_probe(struct platform_device *pdev)
> +{
> +       struct xilinx_mbox *mbox;
> +       struct resource *regs;
> +       int ret;
> +
> +       mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +       if (!mbox)
> +               return -ENOMEM;
> +
> +       /* get clk and enable */
> +       mbox->clk = devm_clk_get(&pdev->dev, "mbox");
> +       if (IS_ERR(mbox->clk)) {
> +               dev_err(&pdev->dev, "Couldn't get clk.\n");
> +               return PTR_ERR(mbox->clk);
> +       }
> +
> +       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       mbox->mbox_base = devm_ioremap_resource(&pdev->dev, regs);
> +       if (IS_ERR(mbox->mbox_base))
> +               return PTR_ERR(mbox->mbox_base);
> +
> +       mbox->irq = platform_get_irq(pdev, 0);
> +       /* if irq is present, we can use it, otherwise, poll */
> +       if (mbox->irq > 0) {
> +               mbox->controller.txdone_irq = true;
> +               mbox->controller.ops = &xilinx_mbox_irq_ops;
> +       } else {
> +               dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
> +               mbox->controller.txdone_poll = true;
> +               mbox->controller.txpoll_period = MBOX_POLLING_MS;
> +               mbox->controller.ops = &xilinx_mbox_poll_ops;
> +
> +               setup_timer(&mbox->rxpoll_timer, xilinx_mbox_poll_rx,
> +                           (unsigned long)&mbox->chan);
>
I believe there is indeed some platform that doesn't have RX-Interrupt?
 If no, please remove this.
 If yes, you may want to get some hint from platform about the size of
messages and do mbox_chan_received_data() only upon reading those many
bytes.

Cheers.
