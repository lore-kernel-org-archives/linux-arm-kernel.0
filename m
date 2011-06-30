From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 1 Jul 2011 00:19:36 +0800
Subject: [PATCH 1/1] net/fec: iMX53 needs gasket for both MII and RMII
In-Reply-To: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20110630161935.GA7977@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Wed, Jun 29, 2011 at 03:38:18PM -0700, Troy Kisky wrote:
> Currently, only RMII interfaces are using the gasket.
> But, the iMX53 needs to enable the gasket for MII
> mode as well. The iMX51 has no gasket registers. So,
> add a use_gasket field to fec_platform_data to not restrict
> same kernel for both iMX51/53 boards.
> 

Right, on those early SoCs with fec, like imx27/35/51, there is no
gasket, while on those recent ones, like imx25/50/53, there is gasket,
and the gasket should be enabled for not only MII mode but also  RMII
mode.  I guess you caught this problem when using a MII phy with
imx53?

Though I agree this is something we need to fix, I'm unsure using
platform_data is the best way.  IMO, this gasket is rather SoC
specific thing than platform (board).  If we are running fec on
imx25/50/53, we need to enable the gasket, no matter what boards
we are using and how the boards are designed.

Since platform_device_id is already being used to distinguish imx28
from other imx SoCs, maybe we can extend it to handle gasket too?

Regards,
Shawn

> iMX28 boards don't need use_gasket, as they have
> FEC_QUIRK_ENET_MAC.
> ---
>  arch/arm/mach-mx5/board-mx50_rdp.c  |    1 +
>  arch/arm/mach-mx5/board-mx53_evk.c  |    1 +
>  arch/arm/mach-mx5/board-mx53_loco.c |    1 +
>  arch/arm/mach-mx5/board-mx53_smd.c  |    1 +
>  drivers/net/fec.c                   |   11 ++++++++---
>  include/linux/fec.h                 |    1 +
>  6 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> index 11210e1..ed627f2 100644
> --- a/arch/arm/mach-mx5/board-mx50_rdp.c
> +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> @@ -171,6 +171,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
>  
>  static const struct fec_platform_data fec_data __initconst = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
> +	.use_gasket = 1,
>  };
>  
>  static inline void mx50_rdp_fec_reset(void)
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> index f87d571..b4b8df9 100644
> --- a/arch/arm/mach-mx5/board-mx53_evk.c
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -92,6 +92,7 @@ static inline void mx53_evk_fec_reset(void)
>  
>  static struct fec_platform_data mx53_evk_fec_pdata = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
> +	.use_gasket = 1,
>  };
>  
>  static struct spi_board_info mx53_evk_spi_board_info[] __initdata = {
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 1b947e8..4e49055 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -219,6 +219,7 @@ static inline void mx53_loco_fec_reset(void)
>  
>  static struct fec_platform_data mx53_loco_fec_data = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
> +	.use_gasket = 1,
>  };
>  
>  static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
> index 817c089..f392892 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -105,6 +105,7 @@ static inline void mx53_smd_fec_reset(void)
>  
>  static struct fec_platform_data mx53_smd_fec_data = {
>  	.phy = PHY_INTERFACE_MODE_RMII,
> +	.use_gasket = 1,
>  };
>  
>  static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 885d8ba..8df80f3 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -204,6 +204,7 @@ struct fec_enet_private {
>  	int	link;
>  	int	full_duplex;
>  	struct	completion mdio_done;
> +	unsigned use_gasket : 1;
>  };
>  
>  /* FEC MII MMFR bits definition */
> @@ -425,7 +426,7 @@ fec_restart(struct net_device *ndev, int duplex)
>  
>  	} else {
>  #ifdef FEC_MIIGSK_ENR
> -		if (fep->phy_interface == PHY_INTERFACE_MODE_RMII) {
> +		if (fep->use_gasket) {
>  			/* disable the gasket and wait */
>  			writel(0, fep->hwp + FEC_MIIGSK_ENR);
>  			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
> @@ -434,8 +435,10 @@ fec_restart(struct net_device *ndev, int duplex)
>  			/*
>  			 * configure the gasket:
>  			 *   RMII, 50 MHz, no loopback, no echo
> +			 *   MII, 25 Mhz, no loopback
>  			 */
> -			writel(1, fep->hwp + FEC_MIIGSK_CFGR);
> +			writel((fep->phy_interface == PHY_INTERFACE_MODE_RMII) ?
> +				          1 : 0, fep->hwp + FEC_MIIGSK_CFGR);
>  
>  			/* re-enable the gasket */
>  			writel(2, fep->hwp + FEC_MIIGSK_ENR);
> @@ -1395,8 +1398,10 @@ fec_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, ndev);
>  
>  	pdata = pdev->dev.platform_data;
> -	if (pdata)
> +	if (pdata) {
>  		fep->phy_interface = pdata->phy;
> +		fep->use_gasket = pdata->use_gasket;
> +	}
>  
>  	/* This device has up to three irqs on some platforms */
>  	for (i = 0; i < 3; i++) {
> diff --git a/include/linux/fec.h b/include/linux/fec.h
> index bcff455..c0a7ad8 100644
> --- a/include/linux/fec.h
> +++ b/include/linux/fec.h
> @@ -19,6 +19,7 @@
>  struct fec_platform_data {
>  	phy_interface_t phy;
>  	unsigned char mac[ETH_ALEN];
> +	unsigned use_gasket : 1;
>  };
>  
>  #endif
> -- 
> 1.7.0.4
> 
> 
