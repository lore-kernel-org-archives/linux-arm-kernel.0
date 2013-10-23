From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 Oct 2013 14:35:23 +0800
Subject: [Patch v2 13/14] usb: phy-mxs: Add implementation of set_wakeup
In-Reply-To: <1382421528-17897-14-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
 <1382421528-17897-14-git-send-email-peter.chen@freescale.com>
Message-ID: <20131023063521.GH2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 01:58:47PM +0800, Peter Chen wrote:
> When we need the PHY can be waken up by external signals,
> we can call this API. Besides, we call mxs_phy_disconnect_line
> at this API to close the connection between USB PHY and
> controller, after that, the line state from controller is SE0.
> Once the PHY is out of power, without calling mxs_phy_disconnect_line,
> there are unknown wakeups due to dp/dm floating at device mode.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   84 ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 83 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index af2a9cf..5bd53ec 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -31,6 +31,9 @@
>  #define HW_USBPHY_CTRL_SET			0x34
>  #define HW_USBPHY_CTRL_CLR			0x38
>  
> +#define HW_USBPHY_DEBUG_SET			0x54
> +#define HW_USBPHY_DEBUG_CLR			0x58
> +
>  #define HW_USBPHY_IP				0x90
>  #define HW_USBPHY_IP_SET			0x94
>  #define HW_USBPHY_IP_CLR			0x98
> @@ -39,6 +42,9 @@
>  #define BM_USBPHY_CTRL_CLKGATE			BIT(30)
>  #define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS	BIT(26)
>  #define BM_USBPHY_CTRL_ENAUTOCLR_USBCLKGATE	BIT(25)
> +#define BM_USBPHY_CTRL_ENVBUSCHG_WKUP		BIT(23)
> +#define BM_USBPHY_CTRL_ENIDCHG_WKUP		BIT(22)
> +#define BM_USBPHY_CTRL_ENDPDMCHG_WKUP		BIT(21)
>  #define BM_USBPHY_CTRL_ENAUTOCLR_PHY_PWD	BIT(20)
>  #define BM_USBPHY_CTRL_ENAUTOCLR_CLKGATE	BIT(19)
>  #define BM_USBPHY_CTRL_ENAUTO_PWRON_PLL		BIT(18)
> @@ -46,7 +52,20 @@
>  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
>  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
>  
> -#define BM_USBPHY_IP_FIX                       (BIT(17) | BIT(18))
> +#define BM_USBPHY_IP_FIX			(BIT(17) | BIT(18))
> +
> +#define BM_USBPHY_DEBUG_CLKGATE			BIT(30)
> +
> +/* Anatop Registers */
> +#define ANADIG_USB1_VBUS_DET_STAT		0x1c0
> +
> +#define ANADIG_USB1_LOOPBACK_SET		0x1e4
> +#define ANADIG_USB1_LOOPBACK_CLR		0x1e8
> +
> +#define BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID	BIT(3)
> +
> +#define BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1	BIT(2)
> +#define BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN	BIT(5)
>  
>  #define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
>  
> @@ -61,6 +80,7 @@ struct mxs_phy {
>  	struct clk *clk;
>  	enum imx_phy_type devtype;
>  	struct regmap *regmap_anatop;
> +	bool disconnect_line_without_vbus_is_needed;
>  };
>  
>  static inline int is_mx6q_phy(struct mxs_phy *data)
> @@ -134,6 +154,44 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  	return 0;
>  }
>  
> +static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
> +{
> +	void __iomem *base = mxs_phy->phy.io_priv;
> +	bool vbus_is_on = false;
> +	static bool line_is_disconnected;
> +	unsigned int vbus_value = 0;
> +
> +	/* Only the SoCs have anatop need below operation */
> +	if (!mxs_phy->disconnect_line_without_vbus_is_needed)
> +		return;

As per the comment, shouldn't the if-clause be the following?  Or is the
comment incorrect?

	if (!mxs_phy->regmap_anatop)

Shawn

> +
> +	regmap_read(mxs_phy->regmap_anatop, ANADIG_USB1_VBUS_DET_STAT,
> +			&vbus_value);
> +	if (vbus_value & BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID)
> +		vbus_is_on = true;
> +
> +	if (on && !vbus_is_on) {
> +		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
> +			base + HW_USBPHY_DEBUG_CLR);
> +		regmap_write(mxs_phy->regmap_anatop, ANADIG_USB1_LOOPBACK_SET,
> +				BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
> +				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
> +		/* Delay some time, and let Linestate be SE0 for controller */
> +		usleep_range(500, 1000);
> +		line_is_disconnected = true;
> +	} else if (line_is_disconnected) {
> +		regmap_write(mxs_phy->regmap_anatop, ANADIG_USB1_LOOPBACK_CLR,
> +				BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
> +				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
> +		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
> +				base + HW_USBPHY_DEBUG_SET);
> +		line_is_disconnected = false;
> +	}
> +
> +	dev_dbg(mxs_phy->phy.dev, "line is %s\n", line_is_disconnected
> +			? "disconnected" : "connected");
> +}
> +
>  static int mxs_phy_init(struct usb_phy *phy)
>  {
>  	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
> @@ -171,6 +229,23 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
>  	return 0;
>  }
>  
> +static int mxs_phy_set_wakeup(struct usb_phy *x, bool enabled)
> +{
> +	struct mxs_phy *mxs_phy = to_mxs_phy(x);
> +	u32 value = BM_USBPHY_CTRL_ENVBUSCHG_WKUP |
> +			BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> +				BM_USBPHY_CTRL_ENIDCHG_WKUP;
> +	if (enabled) {
> +		mxs_phy_disconnect_line(mxs_phy, true);
> +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_SET);
> +	} else {
> +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_CLR);
> +		mxs_phy_disconnect_line(mxs_phy, false);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxs_phy_on_connect(struct usb_phy *phy,
>  		enum usb_device_speed speed)
>  {
> @@ -289,6 +364,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id =
>  			of_match_device(mxs_phy_dt_ids, &pdev->dev);
>  	struct device_node *np = pdev->dev.of_node;
> +	struct property *disconnect_property;
>  
>  	/* This driver is DT-only version now */
>  	if (!of_id || !np)
> @@ -325,6 +401,11 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	disconnect_property = of_find_property
> +		(np, "disconnect-line-without-vbus", NULL);
> +	if (disconnect_property && mxs_phy->regmap_anatop)
> +		mxs_phy->disconnect_line_without_vbus_is_needed = true;
> +
>  	mxs_phy->phy.io_priv		= base;
>  	mxs_phy->phy.dev		= &pdev->dev;
>  	mxs_phy->phy.label		= DRIVER_NAME;
> @@ -334,6 +415,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  	mxs_phy->phy.notify_connect	= mxs_phy_on_connect;
>  	mxs_phy->phy.notify_disconnect	= mxs_phy_on_disconnect;
>  	mxs_phy->phy.type		= USB_PHY_TYPE_USB2;
> +	mxs_phy->phy.set_wakeup		= mxs_phy_set_wakeup;
>  
>  	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
>  
> -- 
> 1.7.1
> 
> 
