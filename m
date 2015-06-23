From: joshc@ni.com (Josh Cartwright)
Date: Tue, 23 Jun 2015 13:51:10 -0500
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20150623185110.GB9591@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Moritz-

Just a couple more nits, nothing big.  Looks pretty clean!

On Tue, Jun 23, 2015 at 11:00:02AM -0700, Moritz Fischer wrote:
> The Xilinx LogiCORE IP mailbox is a FPGA core that allows for
> interprocessor communication via AXI4 memory mapped / AXI4 stream
> interfaces.
> 
> It is single channel per core and allows for transmit and receive.
> 
> Changes from v4:
> - Have separate mbox_ops structs for polling / irq mode
> - Moved clk handling to startup / shutdown
> - Embedded struct mbox_chan in struct xilinx_mbox
> - Misc stylistic issues
> 
> Changes from v3:
> - Stylistic
> 
> Changes from v2:
> - Fixed error handling for IRQ from >= 0 to > 0
> - Fixed error handling for clock enabling
> - Addressed Michal's stylistic comments
> 
> Changes from v1:
> - Added common clock framework support
> - Deal with IRQs that happend before driver load,
>   since HW will not let us know about them when we enable IRQs
> 
> Changes from v0:
> - Several stylistic issues
> - Dropped superfluous intr_mode member
> - Really masking the IRQs on mailbox_shutdown
> - No longer using polling by accident in non-IRQ mode
> - Swapped doc and driver commits
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> mailbox: Address some feedback, make ops const.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> 
> mailbox: xilinx-mailbox: Addressed more of Josh's feedback.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>

Did you intend for this intermediate history to exist?  Seems verbose,
doesn't provide any meaningful detail?

[..]
> +++ b/drivers/mailbox/mailbox-xilinx.c
[..]
> +static int xilinx_mbox_poll_startup(struct mbox_chan *chan)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +	/* prep and enable the clock */

Nit: Is this comment conveying anything useful?

> +	clk_prepare_enable(mbox->clk);
> +
> +	/* setup polling timer */

Nit: Same here.

> +	setup_timer(&mbox->rxpoll_timer, xilinx_mbox_poll_rx,
> +		    (unsigned long)chan);

setup_timer() could conceivably be done in probe().

[..]
> +static int xilinx_mbox_poll_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +	u32 *udata = data;
> +
> +	if (!mbox || !data)

Nit: How could this happen?

> +		return -EINVAL;
> +
> +	if (xilinx_mbox_full(mbox))
> +		return -EBUSY;
> +
> +	writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
> +
> +	return 0;
> +}
[..]
> +static struct mbox_chan_ops xilinx_mbox_irq_ops = {

const?

> +	.send_data = xilinx_mbox_irq_send_data,
> +	.startup = xilinx_mbox_irq_startup,
> +	.shutdown = xilinx_mbox_irq_shutdown,
> +	.last_tx_done = xilinx_mbox_last_tx_done,
> +	.peek_data = xilinx_mbox_peek_data,
> +};
> +
> +static struct mbox_chan_ops xilinx_mbox_poll_ops = {

const?

> +	.send_data = xilinx_mbox_poll_send_data,
> +	.startup = xilinx_mbox_poll_startup,
> +	.shutdown = xilinx_mbox_poll_shutdown,
> +	.last_tx_done = xilinx_mbox_last_tx_done,
> +	.peek_data = xilinx_mbox_peek_data,
> +};

Splitting up the ops seemed to clean things up quite a bit!

> +
> +static int xilinx_mbox_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_mbox *mbox;
> +	struct resource	*regs;
> +	int ret;
> +
> +	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	/* get clk and enable */
> +	mbox->clk = devm_clk_get(&pdev->dev, "mbox");
> +	if (IS_ERR(mbox->clk)) {
> +		dev_err(&pdev->dev, "Couldn't get clk.\n");
> +		return PTR_ERR(mbox->clk);
> +	}
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	mbox->mbox_base = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(mbox->mbox_base))
> +		return PTR_ERR(mbox->mbox_base);
> +
> +	mbox->irq = platform_get_irq(pdev, 0);
> +	/* if irq is present, we can use it, otherwise, poll */
> +	if (mbox->irq > 0) {
> +		mbox->controller.txdone_irq = true;
> +	} else {
> +		dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
> +		mbox->controller.txdone_poll = true;
> +		mbox->controller.txpoll_period = MBOX_POLLING_MS;
> +	}
> +
> +	mbox->dev = &pdev->dev;
> +
> +	/* hardware supports only one channel. */
> +	mbox->controller.dev = mbox->dev;
> +	mbox->controller.num_chans = 1;
> +	mbox->controller.chans = &mbox->chan;
> +
> +	if (mbox->irq > 0)
> +		mbox->controller.ops = &xilinx_mbox_irq_ops;
> +	else
> +		mbox->controller.ops = &xilinx_mbox_poll_ops;

Nit: you're already checking this above, seems like you can just move
the .ops assignment there.

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150623/003bd8b8/attachment.sig>
