From: balbi@ti.com (Felipe Balbi)
Date: Wed, 19 Sep 2012 14:55:20 +0300
Subject: [PATCH 3/4] usb: phy: omap-usb3: Decrease the number of
 transitions to recovery
In-Reply-To: <1348054229-27362-4-git-send-email-kishon@ti.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-4-git-send-email-kishon@ti.com>
Message-ID: <20120919115518.GH3772@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 05:00:28PM +0530, Kishon Vijay Abraham I wrote:
> Power-cycling the PHY (partially) decreases the number of transitions to
> "Recovery" state. Hence changed the power up sequence to a partial
> power-up before a full power-up of the PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>

this can be amended to patch 1. Why would you introduce a driver with a
known problem ? ;-)

> ---
>  drivers/usb/phy/omap-usb3.c  |   43 ++++++++++++++++++++++++++++++++++++------
>  include/linux/usb/omap_usb.h |    1 +
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/phy/omap-usb3.c b/drivers/usb/phy/omap-usb3.c
> index 26402d5..fb3c5e6 100644
> --- a/drivers/usb/phy/omap-usb3.c
> +++ b/drivers/usb/phy/omap-usb3.c
> @@ -35,13 +35,15 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
>  };
>  
>  /**
> - * omap5_usb_phy_power - power on/off the serializer using control module
> + * omap5_usb_phy_partial_powerup - power on the serializer using control module
>   * @phy: struct omap_usb *
> - * @on: 0 to off and 1 to on based on powering on or off the PHY
>   *
> - * omap_usb3 can call this API to power on or off the PHY.
> + * After the dwc3 module is disabled and enabled again the synchronization
> + * between dwc3 and phy goes bad and the device does not get enumerated
> + * in superspeed mode. After some trials it was found powering up TX and
> + * part of RX PHY helped to solve the issue.
>   */
> -static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
> +static int omap5_usb_phy_partial_powerup(struct omap_usb *phy)
>  {
>  	u32 val;
>  	unsigned long rate;
> @@ -58,10 +60,32 @@ static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
>  
>  	val = readl(phy->control_dev);
>  
> +	val &= ~(USB_PWRCTL_CLK_CMD_MASK | USB_PWRCTL_CLK_FREQ_MASK);
> +	val |= (USB3_PHY_PARTIAL_RX_POWERON | USB3_PHY_TX_RX_POWERON)
> +		<< USB_PWRCTL_CLK_CMD_SHIFT;
> +	val |= rate << USB_PWRCTL_CLK_FREQ_SHIFT;
> +
> +	writel(val, phy->control_dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * omap5_usb_phy_power - power on/off the serializer using control module
> + * @phy: struct omap_usb *
> + * @on: 0 to off and 1 to on based on powering on or off the PHY
> + *
> + * omap_usb3 can call this API to power on or off the PHY.
> + */
> +static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
> +{
> +	u32 val;
> +
> +	val = readl(phy->control_dev);
> +
>  	if (on) {
> -		val &= ~(USB_PWRCTL_CLK_CMD_MASK | USB_PWRCTL_CLK_FREQ_MASK);
> +		val &= ~USB_PWRCTL_CLK_CMD_MASK;
>  		val |= USB3_PHY_TX_RX_POWERON << USB_PWRCTL_CLK_CMD_SHIFT;
> -		val |= rate << USB_PWRCTL_CLK_FREQ_SHIFT;
>  	} else {
>  		val &= ~USB_PWRCTL_CLK_CMD_MASK;
>  		val |= USB3_PHY_TX_RX_POWEROFF << USB_PWRCTL_CLK_CMD_SHIFT;
> @@ -207,6 +231,13 @@ static int omap_usb3_init(struct usb_phy *x)
>  	struct omap_usb	*phy = phy_to_omapusb(x);
>  
>  	omap_usb_dpll_lock(phy);
> +	omap5_usb_phy_partial_powerup(phy);
> +	/*
> +	 * Give enough time for the PHY to partially power-up before
> +	 * powering it up completely. delay value suggested by the HW
> +	 * team.
> +	 */
> +	mdelay(100);

why 100 ms ? Has this been measured ? Again, 100 ms is a loooooong time.
Soon enough user will be waiting for a bit over a second to see that
after connecting usb cable, there's activity. We don't want user to
notice that kind of thing ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/b1fb0e53/attachment-0001.sig>
