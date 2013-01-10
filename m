From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 10 Jan 2013 11:38:07 +0100
Subject: [PATCH] Fix phy_init for Marvell network eth driver
In-Reply-To: <1357812298-26399-2-git-send-email-konszert@marvell.com>
References: <1357812298-26399-1-git-send-email-konszert@marvell.com>
 <1357812298-26399-2-git-send-email-konszert@marvell.com>
Message-ID: <50EE9A0F.8050008@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/10/13 11:04, Kosta Zertsekel a ?crit :
> At least it fixes DNS323_REV_C1 board case (mach-orion5x/dsn323-setup.c file).

This looks right, but a bit more detail would be welcome, such as:

"The D-Link DNS323_REV_C1 board has a specific PHY device fixup using 
the flag MARVELL_PHY_M1118_DNS323_LEDS which is set by the architecture 
code in arch/arm/mach-orion5x/dns323-setup.c. This flag is unfortunately 
lost during the call to phy_attach() in mv643xx_eth and therefore, the 
underlying Marvell PHY driver cannot make use of this flag to fixup the 
PHY device LEDs. This patch ensures the phy->dev_flags value is passed 
to the phy_attach() function such that the PHY device driver can 
actually use it."

>
> Change-Id: I37d64795f79c358f66a211a150cec2263e40e295
> ---
>   drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 84c1326..7b8c1ac 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2789,7 +2789,7 @@ static void phy_init(struct mv643xx_eth_private *mp, int speed, int duplex)
>
>   	phy_reset(mp);
>
> -	phy_attach(mp->dev, dev_name(&phy->dev), 0, PHY_INTERFACE_MODE_GMII);
> +	phy_attach(mp->dev, dev_name(&phy->dev), phy->dev_flags, PHY_INTERFACE_MODE_GMII);
>
>   	if (speed == 0) {
>   		phy->autoneg = AUTONEG_ENABLE;
>
