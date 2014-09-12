From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Sep 2014 12:03:44 -0700
Subject: [PATCH v8 3/3] phy: Add Qualcomm DWC3 HS/SS PHY driver
In-Reply-To: <1410542986-24419-4-git-send-email-agross@codeaurora.org>
References: <1410542986-24419-1-git-send-email-agross@codeaurora.org>
 <1410542986-24419-4-git-send-email-agross@codeaurora.org>
Message-ID: <54134390.5030206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yay nitpicks!

On 09/12/14 10:29, Andy Gross wrote:
> +
> +struct qcom_dwc3_usb_phy {
> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct phy *phy;

Align with other members?

>
> +
> +static int wait_for_latch(void __iomem *addr)
> +{
> +	u32 retry = 10;

Why not just int?

> +
> +	while (true) {
> +		if (!readl(addr))
> +			break;
> +
> +		if (--retry == 0)
> +			return -ETIMEDOUT;
> +
> +		usleep_range(10, 20);
> +	}
> +
> +	return 0;
> +}
[...]
> +
> +static int qcom_dwc3_ss_phy_init(struct qcom_dwc3_usb_phy *phy_dwc3)
> +{
> +	u32 data = 0;
> +

Unnecessary initialization.

>
>
> +
> +static struct phy_ops qcom_dwc3_phy_ops = {

Can this be const?

> +	.init		= qcom_dwc3_phy_init,
> +	.exit		= qcom_dwc3_phy_exit,
> +	.power_on	= qcom_dwc3_phy_power_on,
> +	.power_off	= qcom_dwc3_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
[...]
> +
> +static int qcom_dwc3_phy_probe(struct platform_device *pdev)
> +{
> +	struct qcom_dwc3_usb_phy	*phy_dwc3;
> +	struct phy_provider		*phy_provider;
> +	struct resource			*res;
> +	const struct of_device_id	*match;
> +
> +

Weird two newlines here.

> +	phy_dwc3 = devm_kzalloc(&pdev->dev, sizeof(*phy_dwc3), GFP_KERNEL);
> +	if (!phy_dwc3)
> +		return -ENOMEM;
> +
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
