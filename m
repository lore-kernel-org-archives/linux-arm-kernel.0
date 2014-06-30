From: balbi@ti.com (Felipe Balbi)
Date: Mon, 30 Jun 2014 11:52:52 -0500
Subject: [Patch v7 1/3] usb: dwc3: Add Qualcomm DWC3 glue layer driver
In-Reply-To: <1404144233-17222-2-git-send-email-agross@codeaurora.org>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <1404144233-17222-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140630165252.GC31442@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 30, 2014 at 11:03:51AM -0500, Andy Gross wrote:
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
> +	qdwc->gdsc = devm_regulator_get(qdwc->dev, "gdsc");
> +
> +	qdwc->core_clk = devm_clk_get(qdwc->dev, "core");
> +	if (IS_ERR(qdwc->core_clk)) {
> +		dev_dbg(qdwc->dev, "failed to get core clock\n");
> +		return PTR_ERR(qdwc->core_clk);
> +	}
> +
> +	qdwc->iface_clk = devm_clk_get(qdwc->dev, "iface");
> +	if (IS_ERR(qdwc->iface_clk)) {
> +		dev_dbg(qdwc->dev, "failed to get iface clock, skipping\n");
> +		qdwc->iface_clk = NULL;

so this clock and sleep_clk are optional, that's fine...

> +	}
> +
> +	qdwc->sleep_clk = devm_clk_get(qdwc->dev, "sleep");
> +	if (IS_ERR(qdwc->sleep_clk)) {
> +		dev_dbg(qdwc->dev, "failed to get sleep clock, skipping\n");
> +		qdwc->sleep_clk = NULL;
> +	}
> +
> +	if (!IS_ERR(qdwc->gdsc)) {
> +		ret = regulator_enable(qdwc->gdsc);
> +		if (ret)
> +			dev_err(qdwc->dev, "cannot enable gdsc\n");
> +	}
> +
> +	clk_prepare_enable(qdwc->core_clk);
> +
> +	if (qdwc->iface_clk)
> +		clk_prepare_enable(qdwc->iface_clk);

... right here you can drop the NULL check because clk_prepare_enable()
is safe against NULL pointers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/6fa2844b/attachment.sig>
