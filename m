From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 13 Apr 2016 19:28:20 +0530
Subject: [PATCH v2 1/5] phy: Rename phy-brcmstb-sata driver to
 phy-brcm-sata driver
In-Reply-To: <1459140510-5317-2-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <570E507C.4040306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 28 March 2016 10:18 AM, Anup Patel wrote:
> Currently, we have a common SATA3 PHY driver for all Broadcom
> STB SoCs. This driver can be extended and re-used for Broadcom
> iProc SoCs having same SATA3 PHY.
> 
> This patch renames existing Broadcom STB SATA3 PHY driver to
> common Broadcom SATA3 PHY driver to share this PHY driver across
> Broadcom SoCs.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/phy/Kconfig                                 | 18 +++++++++---------
>  drivers/phy/Makefile                                |  2 +-
>  drivers/phy/{phy-brcmstb-sata.c => phy-brcm-sata.c} |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>  rename drivers/phy/{phy-brcmstb-sata.c => phy-brcm-sata.c} (97%)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..c0187a7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -403,15 +403,6 @@ config PHY_TUSB1210
>  	help
>  	  Support for TI TUSB1210 USB ULPI PHY.
>  
> -config PHY_BRCMSTB_SATA
> -	tristate "Broadcom STB SATA PHY driver"
> -	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> -	depends on OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
> -	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
> -
>  config PHY_CYGNUS_PCIE
>  	tristate "Broadcom Cygnus PCIe PHY driver"
>  	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
> @@ -421,4 +412,13 @@ config PHY_CYGNUS_PCIE
>  	  Enable this to support the Broadcom Cygnus PCIe PHY.
>  	  If unsure, say N.
>  
> +config PHY_BRCM_SATA

changing config name should be done with utmost care as it might break
oldconfig users.
Has this been fixed in all the defconfigs where it is included?

Thanks
Kishon

> +	tristate "Broadcom SATA PHY driver"
> +	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
> +	depends on OF
> +	select GENERIC_PHY
> +	default ARCH_BCM_IPROC
> +	help
> +	  Enable this to support the Broadcom SATA PHY.
> +	  If unsure, say N.
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 24596a9..596fae9 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -49,6 +49,6 @@ obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
>  obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
>  obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
>  obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
> -obj-$(CONFIG_PHY_BRCMSTB_SATA)		+= phy-brcmstb-sata.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
>  obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
> +obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcm-sata.c
> similarity index 97%
> rename from drivers/phy/phy-brcmstb-sata.c
> rename to drivers/phy/phy-brcm-sata.c
> index a23172f..c97b9d6 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcm-sata.c
> @@ -1,7 +1,7 @@
>  /*
>   * Broadcom SATA3 AHCI Controller PHY Driver
>   *
> - * Copyright ? 2009-2015 Broadcom Corporation
> + * Copyright (C) 2016 Broadcom
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -238,13 +238,13 @@ static struct platform_driver brcm_sata_phy_driver = {
>  	.probe	= brcm_sata_phy_probe,
>  	.driver	= {
>  		.of_match_table	= brcm_sata_phy_of_match,
> -		.name		= "brcmstb-sata-phy",
> +		.name		= "brcm-sata-phy",
>  	}
>  };
>  module_platform_driver(brcm_sata_phy_driver);
>  
> -MODULE_DESCRIPTION("Broadcom STB SATA PHY driver");
> +MODULE_DESCRIPTION("Broadcom SATA PHY driver");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Marc Carino");
>  MODULE_AUTHOR("Brian Norris");
> -MODULE_ALIAS("platform:phy-brcmstb-sata");
> +MODULE_ALIAS("platform:phy-brcm-sata");
> 
