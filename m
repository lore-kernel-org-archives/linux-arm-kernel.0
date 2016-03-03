From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:59:22 +0100
Subject: [RFC 10/15] net: ethernet: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-11-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-11-git-send-email-k.kozlowski@samsung.com>
Message-ID: <15882485.8qUKXzsQVL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:36 Krzysztof Kozlowski wrote:
> The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
> direct dependencies.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/net/ethernet/hisilicon/Kconfig      | 1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig | 6 ++++++
>  drivers/net/ethernet/ti/Kconfig             | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> index 74beb1867230..6a9c91781bf9 100644
> --- a/drivers/net/ethernet/hisilicon/Kconfig
> +++ b/drivers/net/ethernet/hisilicon/Kconfig
> @@ -26,6 +26,7 @@ config HIX5HD2_GMAC
>  config HIP04_ETH
>  	tristate "HISILICON P04 Ethernet support"
>  	select MARVELL_PHY
> +	depends on HAS_IOMEM	# For MFD_SYSCON
>  	select MFD_SYSCON
>  	select HNS_MDIO
>  	---help---

Geert added a HAS_DMA dependency in linux-next, which takes
care of this, although it's still technically correct as well.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index cec147d1d34f..d6902bf6e90f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -16,6 +16,7 @@ if STMMAC_ETH
>  config STMMAC_PLATFORM
>  	tristate "STMMAC Platform bus support"
>  	depends on STMMAC_ETH
> +	depends on HAS_IOMEM	# For MFD_SYSCON
>  	select MFD_SYSCON
>  	default y
>  	---help---

NET_VENDOR_STMICRO depends on HAS_IOMEM, so we are good here for the
entire directory.

> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index e7f0b7d95b65..ec56cebe929d 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -62,6 +62,7 @@ config TI_CPSW_ALE
>  config TI_CPSW
>  	tristate "TI CPSW Switch Support"
>  	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
> +	depends on HAS_IOMEM	# For MFD_SYSCON
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
>  	select TI_CPSW_PHY_SEL
> 


This again is platform specific, so the chagnge is not needed.

	Arnd
