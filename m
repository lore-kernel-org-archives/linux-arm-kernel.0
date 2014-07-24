From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 24 Jul 2014 16:28:11 +1000
Subject: linux-next: manual merge of the usb tree with the arm-soc tree
Message-ID: <20140724162811.5e12107a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the usb tree got a conflict in
drivers/phy/Kconfig between commit 64562e99477f ("phy: Add drivers for
PCIe and SATA phy on SPEAr13xx") from the arm-soc tree and commit
1de990d8a169 ("phy: qcom: Add driver for QCOM APQ8064 SATA PHY") from
the usb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/phy/Kconfig
index 86c22e26a243,cc97c897945a..000000000000
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@@ -124,53 -149,30 +149,40 @@@ config PHY_SUN4I_US
  config PHY_SAMSUNG_USB2
  	tristate "Samsung USB 2.0 PHY driver"
  	depends on HAS_IOMEM
+ 	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
  	select GENERIC_PHY
  	select MFD_SYSCON
+ 	default ARCH_EXYNOS
  	help
  	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
- 	  SoCs. This driver provides the interface for USB 2.0 PHY. Support for
- 	  particular SoCs has to be enabled in addition to this driver. Number
- 	  and type of supported phys depends on the SoC.
+ 	  SoCs. This driver provides the interface for USB 2.0 PHY. Support
+ 	  for particular PHYs will be enabled based on the SoC type in addition
+ 	  to this driver.
  
 +config PHY_S5PV210_USB2
 +	bool "Support for S5PV210"
 +	depends on PHY_SAMSUNG_USB2
 +	depends on ARCH_S5PV210
 +	help
 +	  Enable USB PHY support for S5PV210. This option requires that Samsung
 +	  USB 2.0 PHY driver is enabled and means that support for this
 +	  particular SoC is compiled in the driver. In case of S5PV210 two phys
 +	  are available - device and host.
 +
  config PHY_EXYNOS4210_USB2
- 	bool "Support for Exynos 4210"
+ 	bool
  	depends on PHY_SAMSUNG_USB2
- 	depends on CPU_EXYNOS4210
- 	help
- 	  Enable USB PHY support for Exynos 4210. This option requires that
- 	  Samsung USB 2.0 PHY driver is enabled and means that support for this
- 	  particular SoC is compiled in the driver. In case of Exynos 4210 four
- 	  phys are available - device, host, HSIC0 and HSIC1.
+ 	default CPU_EXYNOS4210
  
  config PHY_EXYNOS4X12_USB2
- 	bool "Support for Exynos 4x12"
+ 	bool
  	depends on PHY_SAMSUNG_USB2
- 	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)
- 	help
- 	  Enable USB PHY support for Exynos 4x12. This option requires that
- 	  Samsung USB 2.0 PHY driver is enabled and means that support for this
- 	  particular SoC is compiled in the driver. In case of Exynos 4x12 four
- 	  phys are available - device, host, HSIC0 and HSIC1.
+ 	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
  
  config PHY_EXYNOS5250_USB2
- 	bool "Support for Exynos 5250"
+ 	bool
  	depends on PHY_SAMSUNG_USB2
- 	depends on SOC_EXYNOS5250
- 	help
- 	  Enable USB PHY support for Exynos 5250. This option requires that
- 	  Samsung USB 2.0 PHY driver is enabled and means that support for this
- 	  particular SoC is compiled in the driver. In case of Exynos 5250 four
- 	  phys are available - device, host, HSIC0 and HSIC.
+ 	default SOC_EXYNOS5250 || SOC_EXYNOS5420
  
  config PHY_EXYNOS5_USBDRD
  	tristate "Exynos5 SoC series USB DRD PHY driver"
@@@ -190,16 -194,18 +204,30 @@@ config PHY_XGEN
  	help
  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
  
 +config PHY_ST_SPEAR1310_MIPHY
 +	tristate "ST SPEAR1310-MIPHY driver"
 +	select GENERIC_PHY
 +	help
 +	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
 +
 +config PHY_ST_SPEAR1340_MIPHY
 +	tristate "ST SPEAR1340-MIPHY driver"
 +	select GENERIC_PHY
 +	help
 +	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
 +
+ config PHY_QCOM_APQ8064_SATA
+ 	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
+ 	depends on ARCH_QCOM
+ 	depends on HAS_IOMEM
+ 	depends on OF
+ 	select GENERIC_PHY
+ 
+ config PHY_QCOM_IPQ806X_SATA
+ 	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
+ 	depends on ARCH_QCOM
+ 	depends on HAS_IOMEM
+ 	depends on OF
+ 	select GENERIC_PHY
+ 
  endmenu
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/a6029320/attachment.sig>
