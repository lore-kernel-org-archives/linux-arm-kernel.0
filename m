From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 18 Mar 2015 09:57:03 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <55094BEF.9060006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

I see that this driver is queued but most of my earlier comments were
not addressed. *No ACK from DT binding maintainers too*.

On 04/03/15 11:01, Vincent Yang wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Add driver for the ARM Primecell Message-Handling-Unit(MHU) controller.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
> ---
>   .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 +++++
>   drivers/mailbox/Kconfig                            |   9 +
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/arm_mhu.c                          | 195 +++++++++++++++++++++
>   4 files changed, 249 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>   create mode 100644 drivers/mailbox/arm_mhu.c
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> new file mode 100644
> index 0000000..4971f03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> @@ -0,0 +1,43 @@
> +ARM MHU Mailbox Driver
> +======================
> +
> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
> +3 independent channels/links to communicate with remote processor(s).
> + MHU links are hardwired on a platform. A link raises interrupt for any

As I had mentioned before it's just one implementation, the IP had
provision bi-directional interrupts and the binding *has to consider*
that instead of having to workaround that later.

> +received data. However, there is no specified way of knowing if the sent

You can drop the above line or specify as you can still poll.

> +data has been read by the remote. This driver assumes the sender polls

Bindings not supposed have any details on how driver handle it. You can
just mention that in absence of interrupt, we can know the status of
transmission by polling STAT register.

> +STAT register and the remote clears it after having read the data.
> +The last channel is specified to be a 'Secure' resource, hence can't be
> +used by Linux running NS.
> +

Correct so drop the support for secure channel until the first user
comes up. I am worried it might generate abort if someone tries to
access it in ARM64 which always runs in non-secure.


> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,mhu" & "arm,primecell"
> +- reg:			Contains the mailbox register address range (base
> +			address and length)
> +- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- interrupts:		Contains the interrupt information corresponding to
> +			each of the 3 links of MHU.
> +

As mentioned multiple times before, please add interrupt-names to make
sure we can handle bi-directional interrupt.

> +Example:
> +--------
> +
> +	mhu: mailbox at 2b1f0000 {
> +		#mbox-cells = <1>;
> +		compatible = "arm,mhu", "arm,primecell";
> +		reg = <0 0x2b1f0000 0x1000>;
> +		interrupts = <0 36 4>, /* LP-NonSecure */
> +			     <0 35 4>, /* HP-NonSecure */
> +			     <0 37 4>; /* Secure */
> +		clocks = <&clock 0 2 1>;
> +		clock-names = "apb_pclk";
> +	};
> +
> +	mhu_client: scb at 2e000000 {
> +		compatible = "fujitsu,mb86s70-scb-1.0";
> +		reg = <0 0x2e000000 0x4000>;
> +		mboxes = <&mhu 1>; /* HP-NonSecure */
> +	};

[...]

> diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
> new file mode 100644
> index 0000000..ac693c6
> --- /dev/null
> +++ b/drivers/mailbox/arm_mhu.c
> @@ -0,0 +1,195 @@
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
> +#define MHU_LP_OFFSET	0x0
> +#define MHU_HP_OFFSET	0x20
> +#define MHU_SEC_OFFSET	0x200
> +#define TX_REG_OFFSET	0x100
> +
> +#define MHU_CHANS	3
> +

For now I prefer 2.

[...]
> +static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	int i, err;
> +	struct arm_mhu *mhu;
> +	struct device *dev = &adev->dev;
> +	int mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET};
> +
> +	/* Allocate memory for device */
> +	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> +	if (!mhu)
> +		return -ENOMEM;
> +
> +	mhu->base = devm_ioremap_resource(dev, &adev->res);
> +	if (IS_ERR(mhu->base)) {
> +		dev_err(dev, "ioremap failed\n");
> +		return PTR_ERR(mhu->base);
> +	}
> +
> +	for (i = 0; i < MHU_CHANS; i++) {
> +		mhu->chan[i].con_priv = &mhu->mlink[i];
> +		mhu->mlink[i].irq = adev->irq[i];
> +		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
> +		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
> +	}
> +
> +	mhu->mbox.dev = dev;
> +	mhu->mbox.chans = &mhu->chan[0];
> +	mhu->mbox.num_chans = MHU_CHANS;
> +	mhu->mbox.ops = &mhu_ops;
> +	mhu->mbox.txdone_irq = false;
> +	mhu->mbox.txdone_poll = true;
> +	mhu->mbox.txpoll_period = 10;

IMO too high value, as I mentioned you assume jiffy value. The kernel
will take care of conversion.

[...]
> +
> +static struct amba_id mhu_ids[] = {
> +	{
> +		.id	= 0x1bb098,

As I mentioned couple of times this is broken. Please refer my earlier 
mail for details. You are skipping a field to compare which incorrect.
You are just trying to get it working with existing AMBA driver without 
any changes matching the IDs partially.

Regards,
Sudeep
