From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 18 Feb 2015 10:37:43 +0000
Subject: [PATCH v6 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1423188528-17134-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1423188007-17047-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1423188528-17134-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <54E46B77.4060803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/02/15 02:08, Vincent Yang wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Add driver for the ARM Primecell Message-Handling-Unit(MHU) controller.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
> ---
>   .../devicetree/bindings/mailbox/arm-mhu.txt        |  35 ++++
>   drivers/mailbox/Kconfig                            |   7 +
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/arm_mhu.c                          | 196 +++++++++++++++++++++
>   4 files changed, 240 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>   create mode 100644 drivers/mailbox/arm_mhu.c
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> new file mode 100644
> index 0000000..986a205
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> @@ -0,0 +1,35 @@
> +ARM MHU Mailbox Driver
> +======================
> +
> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
> +3 independent channels/links to communicate with remote processor(s).
> + MHU links are hardwired on a platform. A link raises interrupt for any
> +received data. However, there is no specified way of knowing if the sent

IIUC the IP as such doesn't have this restriction, it's just the way
currently integrated in the SoCs. So we need to provide a way for future
expansion.

> +data has been read by the remote. This driver assumes the sender polls
> +STAT register and the remote clears it after having read the data.
> +

I would rather drop any specifics about what driver does. Bindings 
should try to confine to the underlying hardware only if possible.

> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,mhu" & "arm,primecell"
> +- reg:			Contains the mailbox register address range (base
> +			address and length)
> +- #mbox-cells		Shall be 1

Need to explain what that one cell must represent.

> +- interrupts:		Contains the interrupt information corresponding to
> +			each of the 3 links of MHU.
> +

How do we handle if the middle link has no interrupt ?
Also please that the last channel is secure only and must not be used in 
non-secure execution.

> +Example:
> +--------
> +
> +	mhu: mailbox at 2b1f0000 {
> +		#mbox-cells = <1>;
> +		compatible = "arm,mhu", "arm,primecell";
> +		reg = <0 0x2b1f0000 0x1000>;
> +		interrupts = <0 36 4>,
> +			     <0 35 4>,
> +			     <0 37 4>;
> +		clocks = <&clock 0 2 1>;
> +		clock-names = "apb_pclk";
> +	};
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c04fed9..9238440 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -6,6 +6,13 @@ menuconfig MAILBOX
>   	  signals. Say Y if your platform supports hardware mailboxes.
>
>   if MAILBOX
> +
> +config ARM_MHU
> +	tristate "ARM MHU Mailbox"
> +	depends on ARM
> +	help
> +	  Say Y here if you want to build the ARM MHU controller driver
> +

May be a brief one/2-liners on what IP does might be useful ?

>   config PL320_MBOX
>   	bool "ARM PL320 Mailbox"
>   	depends on ARM_AMBA
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index dd412c2..c83791d 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -2,6 +2,8 @@
>
>   obj-$(CONFIG_MAILBOX)		+= mailbox.o
>
> +obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
> +
>   obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
>
>   obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
> diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
> new file mode 100644
> index 0000000..d6fd1cd
> --- /dev/null
> +++ b/drivers/mailbox/arm_mhu.c
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/amba/bus.h>
> +#include <linux/mailbox_controller.h>
> +
> +#define INTR_STAT_OFS	0x0
> +#define INTR_SET_OFS	0x8
> +#define INTR_CLR_OFS	0x10
> +
> +struct mhu_link {
> +	unsigned irq;
> +	void __iomem *tx_reg;
> +	void __iomem *rx_reg;
> +};
> +
> +struct arm_mhu {
> +	void __iomem *base;
> +	struct mhu_link mlink[3];

Replace "3" with some macro throughout the file.

> +	struct mbox_chan chan[3];
> +	struct mbox_controller mbox;
> +};
> +
> +static irqreturn_t mhu_rx_interrupt(int irq, void *p)
> +{
> +	struct mbox_chan *chan = p;
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 val;
> +
> +	val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	mbox_chan_received_data(chan, (void *)&val);
> +
> +	writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool mhu_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
> +
> +	return (val == 0);

[Nit] How about just
	return readl_relaxed(mlink->tx_reg + INTR_STAT_OFS) == 0;

> +}
> +
> +static int mhu_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 *arg = data;
> +
> +	if (!mhu_last_tx_done(chan)) {
> +		dev_err(chan->mbox->dev, "Last TX(%d) pending!\n", mlink->irq);
> +		return -EBUSY;
> +	}
> +

Why do you need the above check when the core handles that already ?

> +	writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
> +
> +	return 0;
> +}
> +
> +static int mhu_startup(struct mbox_chan *chan)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
> +	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
> +
> +	ret = request_irq(mlink->irq, mhu_rx_interrupt, 0, "mhu_link", chan);
> +	if (ret) {
> +		dev_err(chan->mbox->dev,
> +			"Unable to aquire IRQ %d\n", mlink->irq);
> +		return ret;
> +	}

This proved costly(in terms of time) on Juno board in my testing,
requesting and setting up irq for every small packets you need to send.
I would prefer it to be moved to probe.

> +
> +	return 0;
> +}
> +
> +static void mhu_shutdown(struct mbox_chan *chan)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +
> +	free_irq(mlink->irq, chan);
> +}
> +
> +static struct mbox_chan_ops mhu_ops = {
> +	.send_data = mhu_send_data,
> +	.startup = mhu_startup,
> +	.shutdown = mhu_shutdown,
> +	.last_tx_done = mhu_last_tx_done,
> +};
> +
> +static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	int i, err;
> +	struct arm_mhu *mhu;
> +	struct device *dev = &adev->dev;
> +	int mhu_reg[3] = {0x0, 0x20, 0x200};
> +
> +	err = amba_request_regions(adev, NULL);
> +	if (err)
> +		return err;
> +
> +	/* Allocate memory for device */
> +	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> +	if (!mhu)
> +		return -ENOMEM;
> +
> +	mhu->base = devm_ioremap_resource(dev, &adev->res);

This will either explode or warn as you have already requested the
regions. Have you run this code after converting to amba bus device ?

> +	if (IS_ERR(mhu->base)) {
> +		dev_err(dev, "ioremap failed\n");
> +		return PTR_ERR(mhu->base);
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		mhu->chan[i].con_priv = &mhu->mlink[i];
> +		mhu->mlink[i].irq = adev->irq[i];
> +		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
> +		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;

Again a macro for 0x100 ?

> +	}
> +
> +	mhu->mbox.dev = dev;
> +	mhu->mbox.chans = &mhu->chan[0];
> +	mhu->mbox.num_chans = 3;
> +	mhu->mbox.ops = &mhu_ops;
> +	mhu->mbox.txdone_irq = false;
> +	mhu->mbox.txdone_poll = true;
> +	mhu->mbox.txpoll_period = 10;

10ms seems to high, but if that's a derived value then I am fine.
On Juno, typically we get response within a millisecond, so we need not
get blocked on Tx even after getting Rx for 10ms. I prefer it to be set
to 1 ms.

> +
> +	amba_set_drvdata(adev, mhu);
> +
> +	err = mbox_controller_register(&mhu->mbox);
> +	if (err) {
> +		dev_err(dev, "Failed to register mailboxes %d\n", err);
> +		return err;
> +	}
> +
> +	dev_info(dev, "ARM MHU Mailbox registered\n");
> +	return 0;
> +}
> +
> +static int mhu_remove(struct amba_device *adev)
> +{
> +	struct arm_mhu *mhu = amba_get_drvdata(adev);
> +
> +	mbox_controller_unregister(&mhu->mbox);
> +
> +	return 0;
> +}
> +
> +static struct amba_id mhu_ids[] = {
> +	{
> +		.id	= 0x1bb098,

This is the problem. This IP has PID(0x98 0xB0 0x1B 0x00 0x04)
it's 5 bytes[1] . Even I had thought of AMBA initially, it doesn't fit
as is, may need changes to the amba core to consider this.

Regards,
Sudeep

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515b/CHDCHJEH.html
