From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Sep 2014 12:47:04 -0500
Subject: [PATCH v8 2/3] usb: dwc3: Add Qualcomm DWC3 glue layer driver
In-Reply-To: <1410542986-24419-3-git-send-email-agross@codeaurora.org>
References: <1410542986-24419-1-git-send-email-agross@codeaurora.org>
 <1410542986-24419-3-git-send-email-agross@codeaurora.org>
Message-ID: <20140912174704.GG8567@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 12, 2014 at 12:29:45PM -0500, Andy Gross wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> DWC3 glue layer is hardware layer around Synopsys DesignWare
> USB3 core. Its purpose is to supply Synopsys IP with required
> clocks, voltages and interface it with the rest of the SoC.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/usb/dwc3/Kconfig     |    9 +++
>  drivers/usb/dwc3/Makefile    |    1 +
>  drivers/usb/dwc3/dwc3-qcom.c |  133 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-qcom.c
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 785510a..e9f258e 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -80,6 +80,15 @@ config USB_DWC3_KEYSTONE
>  	  Support of USB2/3 functionality in TI Keystone2 platforms.
>  	  Say 'Y' or 'M' here if you have one such device
>  
> +config USB_DWC3_QCOM
> +	tristate "Qualcomm Platforms"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	default USB_DWC3
> +	select PHY_QCOM_DWC3

I would rather steer away from selecting the PHY as it prevents having
PHYs as modules. Also, this will add a Kconfig warning for selecting a
symbol that doesn't exist (yet).

If it's all the same with you, I can clean this up when applying.

> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> new file mode 100644
> index 0000000..2067c04
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -0,0 +1,133 @@
> +/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/phy.h>

doesn't look like you need regulator/consumer.h and usb/phy.h. I can
clean it up when applying.

> +struct dwc3_qcom {
> +	struct device		*dev;
> +
> +	struct clk		*core_clk;
> +	struct clk		*iface_clk;
> +	struct clk		*sleep_clk;
> +};
> +
> +static int dwc3_qcom_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct dwc3_qcom *qdwc;
> +	int ret = 0;
> +
> +	qdwc = devm_kzalloc(&pdev->dev, sizeof(*qdwc), GFP_KERNEL);
> +	if (!qdwc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, qdwc);
> +
> +	qdwc->dev = &pdev->dev;
> +
> +	qdwc->core_clk = devm_clk_get(qdwc->dev, "core");
> +	if (IS_ERR(qdwc->core_clk)) {
> +		dev_dbg(qdwc->dev, "failed to get core clock\n");

this one would be a dev_err() since core can't work without its clock. I
can fix when applying.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/360a34a9/attachment.sig>
