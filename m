From: mhei@heimpold.de (Michael Heimpold)
Date: Thu, 20 Jun 2013 19:13:41 +0200
Subject: [PATCH 2/3] ARM: i.MX6: add ethernet phy fixup for AR8031
In-Reply-To: <1371742473-28026-3-git-send-email-s.hauer@pengutronix.de>
References: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
 <1371742473-28026-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4263249.CSIcTzoYtY@kerker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 20. Juni 2013, 17:34:32 schrieb Sascha Hauer:
> The AR8031 is used on the i.MX6 based sabreSD, sabreauto and wandboard.
> All need the same fixup, so add it for all i.MX6.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index e5f4a5b..69fae87 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -113,6 +113,29 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int ar8031_phy_fixup(struct phy_device *dev)
> +{
> +	u16 val;
> +
> +	/* To enable AR8031 ouput a 125MHz clk from CLK_25M */

Typo? "ouput" -> "output"

> +	phy_write(dev, 0xd, 0x7);
> +	phy_write(dev, 0xe, 0x8016);
> +	phy_write(dev, 0xd, 0x4007);
> +
> +	val = phy_read(dev, 0xe);
> +	val &= 0xffe3;
> +	val |= 0x18;
> +	phy_write(dev, 0xe, val);
> +
> +	/* introduce tx clock delay */
> +	phy_write(dev, 0x1d, 0x5);
> +	val = phy_read(dev, 0x1e);
> +	val |= 0x0100;
> +	phy_write(dev, 0x1e, val);
> +
> +	return 0;
> +}
> +
>  static void __init imx6q_sabrelite_cko1_setup(void)
>  {
>  	struct clk *cko1_sel, *ahb, *cko1;
> @@ -137,11 +160,15 @@ put_clk:
>  		clk_put(cko1);
>  }
>  
> +#define PHY_ID_AR8031	0x004dd074
> +
>  static void __init imx6q_enet_phy_init(void)
>  {
>  	if (IS_BUILTIN(CONFIG_PHYLIB)) {
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  				ksz9021rn_phy_fixup);
> +		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
> +				ar8031_phy_fixup);
>  	}
>  }
>  
> 
