From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jan 2012 23:27:09 +0800
Subject: [PATCH] net: fsl: fec: handle 10Mbps speed in RMII mode
In-Reply-To: <1326299376-22853-1-git-send-email-eric@eukrea.com>
References: <1326299376-22853-1-git-send-email-eric@eukrea.com>
Message-ID: <20120112152701.GC21802@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Though I do not have the 10 Mbps setup to test the patch, it looks
like the patch is fixing a real bug.

A few of nits below ...

On Wed, Jan 11, 2012 at 05:29:36PM +0100, Eric B?nard wrote:
> when the link is 10 Mbps and the mode is RMII, it's necessary
> to set FRCONT to 1 in MIIGSK_CFGR to divide the RMII source
> clock by 10 in order to support 10 Mbps operations.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  drivers/net/ethernet/freescale/fec.c |   10 ++++++++--
>  drivers/net/ethernet/freescale/fec.h |    4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index ddcbbb3..89532ab 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -476,6 +476,7 @@ fec_restart(struct net_device *ndev, int duplex)
>  	} else {
>  #ifdef FEC_MIIGSK_ENR
>  		if (id_entry->driver_data & FEC_QUIRK_USE_GASKET) {
> +			u32 miigsk;

I would prefer to name it as 'cfgr' or 'miigsk_cfgr'.

>  			/* disable the gasket and wait */
>  			writel(0, fep->hwp + FEC_MIIGSK_ENR);
>  			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
> @@ -486,8 +487,13 @@ fec_restart(struct net_device *ndev, int duplex)
>  			 *   RMII, 50 MHz, no loopback, no echo
>  			 *   MII, 25 MHz, no loopback, no echo
>  			 */
> -			writel((fep->phy_interface == PHY_INTERFACE_MODE_RMII) ?
> -					1 : 0, fep->hwp + FEC_MIIGSK_CFGR);
> +			miigsk = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
> +				? FEC_MIIGSK_RMII_MODE : FEC_MIIGSK_MII_MODE;
> +			if (fep->phy_dev) {
> +				if (fep->phy_dev->speed == SPEED_10)
> +					miigsk |= FEC_MIIGSK_FRCONT_10M;
> +			}

This can be as simple as below?

                        if (fep->phy_dev && fep->phy_dev->speed == SPEED_10)
                                        miigsk |= FEC_MIIGSK_FRCONT_10M;

> +			writel(miigsk, fep->hwp + FEC_MIIGSK_CFGR);
>  
>  
>  			/* re-enable the gasket */
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 8b2c6d7..6870d9e 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -47,6 +47,10 @@
>  #define FEC_MIIGSK_CFGR		0x300 /* MIIGSK Configuration reg */
>  #define FEC_MIIGSK_ENR		0x308 /* MIIGSK Enable reg */
>  
> +#define FEC_MIIGSK_MII_MODE		0x00
> +#define FEC_MIIGSK_RMII_MODE	0x01
> +#define FEC_MIIGSK_FRCONT_10M	0x40
> +

I would prefer to define them as BM_MIIGSK_CFGR_*, so that we can
explicitly know what they are from the names, and also keep FEC_*
consistently being register offset.

Other than these minor comments:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

>  #else
>  
>  #define FEC_ECNTRL		0x000 /* Ethernet control reg */
> -- 
> 1.7.7.5
> 
