From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Mar 2016 15:38:57 +0300
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <1458181615-27782-7-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
Message-ID: <56EAA561.8010408@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 5:26 AM, David Lechner wrote:

> This is a new phy driver for the SoC USB controllers on the TI DA8XX

    DA8xx, please.

> family of microcontrollers. The USB 1.1 PHY is just a simple on/off.
> The USB 2.0 PHY also allows overriding the VBUS and ID pins.
>
> Signed-off-by: David Lechner <david@lechnology.com>
[...]

> diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> new file mode 100644
> index 0000000..93a5f4d
> --- /dev/null
> +++ b/drivers/phy/phy-da8xx-usb.c
> @@ -0,0 +1,295 @@
[...]
> +static inline u32 da8xx_usbphy_readl(void __iomem *base)
> +{
> +	return readl(base);
> +}
> +
> +static inline void da8xx_usbphy_writel(void __iomem *base, u32 value)
> +{
> +	writel(value, base);

    Why wrap them at all?

> +}
> +
> +static int da8xx_usb11_phy_init(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	int ret;
> +	u32 val;
> +
> +	ret = clk_prepare_enable(d_phy->usb11_clk);
> +	if (ret)
> +		return ret;
> +
> +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> +	val |= USB1SUSPENDM;
> +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);

    Hum, I'd think this needs to be done in the power_on() method...

> +
> +	return 0;
> +}
> +
> +static int da8xx_usb11_phy_shutdown(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	u32 val;
> +
> +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> +	val &= ~USB1SUSPENDM;
> +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);

    And this in power_off()...

> +
> +	clk_disable_unprepare(d_phy->usb11_clk);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops da8xx_usb11_phy_ops = {
> +	.power_on	= da8xx_usb11_phy_init,
> +	.power_off	= da8xx_usb11_phy_shutdown,

    Aha, it's just that the names don't match...
    Please call the implementations da8xx_usb11_phy_power_{on|off}().
The same with USB 2.0 PHY.

[...]

    Looks good otherwise on my superficial review. :-)

MBR, Sergei
