From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 17:41:48 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: preserve
 MII/RMII setting in fec_stop()
In-Reply-To: <d6f4de9e4cfb393754b42815a2ef1a59c96eab83.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <d6f4de9e4cfb393754b42815a2ef1a59c96eab83.1323163127.git.LW@KARO-electronics.de>
Message-ID: <20111207094146.GG5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:27:14AM +0100, Lothar Wa?mann wrote:
> Additionally to setting the ETHER_EN bit in FEC_ECNTRL the MII/RMII
> setting in FEC_R_CNTRL needs to be preserved to keep the MII interface

s/MII/RMII?  From what I see from imx28 and imx6q RM, the reset state
for this setting is MII mode.

> functional.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/net/ethernet/freescale/fec.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

I assume this is fixing a problem you are seeing on imx28 only.
Do you see the problem on imx53/51?

> 
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index 11534b9..ab0afb5 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -515,6 +515,7 @@ fec_stop(struct net_device *ndev)
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	const struct platform_device_id *id_entry =
>  				platform_get_device_id(fep->pdev);
> +	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);

This bit is only available on ENET (imx28 and imx6q).  Do we want to
do the same thing for FEC (imx25/27/35/51/53)?

>  
>  	/* We cannot expect a graceful transmit stop without link !!! */
>  	if (fep->link) {
> @@ -531,8 +532,10 @@ fec_stop(struct net_device *ndev)
>  	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
>  
>  	/* We have to keep ENET enabled to have MII interrupt stay working */
> -	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
> +	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
>  		writel(2, fep->hwp + FEC_ECNTRL);
> +		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
> +	}
>  }

On imx6q, we have two bits, bit 6 and 8 of FEC_R_CNTRL, to select MII
interface among MII, RMII and RGMII modes.  I'm not sure if we will
run into the same problem for RGMII mode.  What's your test setup?
I would try to reproduce it here.

-- 
Regards,
Shawn
