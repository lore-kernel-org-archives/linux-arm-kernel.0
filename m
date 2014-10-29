From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 29 Oct 2014 12:34:18 +0100
Subject: [PATCH RESEND V4 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox
 driver
In-Reply-To: <1414535277-15645-3-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-3-git-send-email-abrestic@chromium.org>
Message-ID: <20141029113415.GD28356@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:27:49PM -0700, Andrew Bresticker wrote:
[...]
> diff --git a/drivers/mailbox/tegra-xusb-mailbox.c b/drivers/mailbox/tegra-xusb-mailbox.c
[...]
> +struct tegra_xusb_mbox {
> +	struct mbox_controller mbox;
> +	int irq;

It seems like this is unused outside of tegra_xusb_mbox_probe()

> +static int tegra_xusb_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct tegra_xusb_mbox *mbox = dev_get_drvdata(chan->mbox->dev);

In my opinion, container_of(chan->mbox, struct tegra_xusb_mbox, mbox)
would be a slightly more idiomatic way to do this.

> +	struct tegra_xusb_mbox_msg *msg = data;
> +	unsigned long flags;
> +	u32 reg, owner;
> +
> +	dev_dbg(mbox->mbox.dev, "TX message 0x%x:0x%x\n", msg->cmd, msg->data);

%#x saves you a character in the format string above.

> +static int tegra_xusb_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct tegra_xusb_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
> +	int idx = chan - mbox->mbox.chans;

unsigned?

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mbox->lock, flags);
> +	mbox->vchan_allocated[idx] = true;
> +	spin_unlock_irqrestore(&mbox->lock, flags);

The struct mbox_chan has a con_priv field, perhaps that can be used to
store virtual channel private data instead of keeping the extra
vchan_allocated field in the controller private context? That way you
don't wouldn't have to compute an index and use it to index the field
in the controller private context.

In this particular case I don't think you even need that field, since a
channel is requested when the mbox_chan.cl field in non-NULL.

> +static struct mbox_chan_ops tegra_xusb_mbox_chan_ops = {

I think this really ought to be static const. That would currently still
throw a warning because the core doesn't mark the mbox_controller.ops
field const, but I think it really should. Now also seems like a good
time to make that change because there don't seem to be any users yet.

> +static irqreturn_t tegra_xusb_mbox_irq(int irq, void *p)
> +{
> +	struct tegra_xusb_mbox *mbox = (struct tegra_xusb_mbox *)p;

There's no need for the explicit cast here.

> +	struct tegra_xusb_mbox_msg msg;
> +	int i;

unsigned?

> +	u32 reg;
> +
> +	spin_lock(&mbox->lock);
> +
> +	/* Clear mbox interrupts */
> +	reg = mbox_readl(mbox, XUSB_CFG_ARU_SMI_INTR);
> +	if (reg & MBOX_SMI_INTR_FW_HANG)
> +		dev_err(mbox->mbox.dev, "Controller firmware hang\n");
> +	mbox_writel(mbox, reg, XUSB_CFG_ARU_SMI_INTR);
> +
> +	reg = mbox_readl(mbox, XUSB_CFG_ARU_MBOX_DATA_OUT);
> +	mbox_unpack_msg(reg, &msg);
> +
> +	/*
> +	 * Set the mailbox back to idle.  The recipient of the message is
> +	 * responsible for sending an ACK/NAK, if necessary.
> +	 */
> +	reg = mbox_readl(mbox, XUSB_CFG_ARU_MBOX_CMD);
> +	reg &= ~MBOX_DEST_SMI;
> +	mbox_writel(mbox, reg, XUSB_CFG_ARU_MBOX_CMD);
> +	mbox_writel(mbox, MBOX_OWNER_NONE, XUSB_CFG_ARU_MBOX_OWNER);
> +
> +	dev_dbg(mbox->mbox.dev, "RX message 0x%x:0x%x\n", msg.cmd, msg.data);

Again 0x%x -> %#x to save characters.

> +	for (i = 0; i < ARRAY_SIZE(mbox->vchan_allocated); i++) {
> +		if (mbox->vchan_allocated[i])
> +			mbox_chan_received_data(&mbox->mbox.chans[i], &msg);
> +	}

It seems like the only reason why you need to explicitly check for an
allocated channel is that mbox_chan_received_data() would otherwise
crash. Are mailbox drivers really supposed to keep track of whether a
channel has been requested by a client? Isn't that something that should
be done in the core?

> +static struct mbox_chan *tegra_xusb_mbox_of_xlate(struct mbox_controller *ctlr,
> +					const struct of_phandle_args *sp)
> +{
> +	struct tegra_xusb_mbox *mbox = dev_get_drvdata(ctlr->dev);

container_of()?

> +	struct mbox_chan *chan = NULL;
> +	unsigned long flags;
> +	int i;

unsigned?

> +static struct of_device_id tegra_xusb_mbox_of_match[] = {

static const, please.

> +static int tegra_xusb_mbox_probe(struct platform_device *pdev)
> +{
> +	struct tegra_xusb_mbox *mbox;
> +	struct resource *res;
> +	int ret;
> +
> +	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, mbox);
> +	spin_lock_init(&mbox->lock);
> +
> +	mbox->mbox.dev = &pdev->dev;
> +	mbox->mbox.chans = devm_kcalloc(&pdev->dev, TEGRA_XUSB_MBOX_NUM_CHANS,
> +					sizeof(*mbox->mbox.chans), GFP_KERNEL);
> +	if (!mbox->mbox.chans)
> +		return -ENOMEM;
> +	mbox->mbox.num_chans = TEGRA_XUSB_MBOX_NUM_CHANS;
> +	mbox->mbox.ops = &tegra_xusb_mbox_chan_ops;
> +	mbox->mbox.txdone_poll = true;
> +	mbox->mbox.txpoll_period = 0; /* no need to actually poll */

Does the core perhaps need special handling for this? It seems like
poll_txdone() will always rearm the timer used to do the polling,
irrespective of whether the transfer is actually done or not. Maybe
something like this patch would be more correct in handling this:

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index afcb430508ec..85691a7d8ca6 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -117,10 +117,11 @@ static void poll_txdone(unsigned long data)
 		struct mbox_chan *chan = &mbox->chans[i];
 
 		if (chan->active_req && chan->cl) {
-			resched = true;
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
+			else
+				resched = true;
 		}
 	}
 

The comment "no need to actually poll" isn't really appropriate in the
context of txpoll_period = 0.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	mbox->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!mbox->regs)
> +		return -ENOMEM;

This doesn't look right. Upon closer inspection, the reason why you
don't use devm_request_resource() is because these registers are shared
with the XHCI controller.

Perhaps a better design would be for the XHCI driver to expose the
mailbox rather than split it off into a separate driver.

> +static struct platform_driver tegra_xusb_mbox_driver = {
> +	.probe	= tegra_xusb_mbox_probe,
> +	.remove	= tegra_xusb_mbox_remove,
> +	.driver	= {
> +		.name = "tegra-xusb-mbox",
> +		.of_match_table = of_match_ptr(tegra_xusb_mbox_of_match),
> +	},

This uses tabs and spaces inconsistently for padding. I prefer a single
space on either side of the '=' like you've done for the fields of
.driver above.

> diff --git a/include/soc/tegra/xusb.h b/include/soc/tegra/xusb.h
> new file mode 100644
> index 0000000..cfe211d
> --- /dev/null
> +++ b/include/soc/tegra/xusb.h

Perhaps this should really be named xusb-mbox.h?

> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2014 NVIDIA Corporation
> + * Copyright (C) 2014 Google, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_TEGRA_XUSB_H__
> +#define __SOC_TEGRA_XUSB_H__
> +
> +/* Two virtual channels: host + phy */
> +#define TEGRA_XUSB_MBOX_NUM_CHANS 2

I don't think this belongs in this public header. Who is going to need
this besides the XUSB mailbox driver?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/e8742287/attachment.sig>
