From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue,  8 Apr 2014 20:06:38 +0530
Subject: [PATCH V4 0/5] Add Exynos5 USB 3.0 phy driver based on generic PHY
 framework
Message-ID: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on 'next' branch of Kishon's phy tree (linux-phy).
Tested on 'usb-next' of Greg's usb tree.

Changes from V3:
1) Separated out the phy init sequences for utmi and pipe3 phys.
2) Changed the nomenclature across the phy to 'usbdrd-phy' to
   indicate USB 3.0 DRD PHY controller; and thereby changed the names                
   of functions correspondingly, including specific functions for
   utmi and pipe3 phys.                                                              
3) Modified the DT nodes for the updated nomenclature.
4) Using BIT macro for single bit definitions.                                       
5) Keeping track of reference clock after getting till the removal of                
   phy, and getting the ref clock using devm_clk_get() api.
6) Removed aliases for mutiple channel PHYs, and instead using
   'samsung,pmu-offset' property for PHY power control register offset.
7) Keeping the phy_init() and phy_power_on() separately in order to
   align with phy handling in the consumer (DWC3).

Changes from v2:
1) Added support for multiple PHYs (UTMI+ and PIPE3) and                   
   related changes in the driver structuring.
2) Added a xlate function to get the required phy out of
   number of PHYs in mutiple PHY scenerio.
3) Changed the names of few structures and variables to                
   have a clearer meaning. 
4) Added 'usb3phy_config' structure to take care of mutiple
   phys for a SoC having 'exynos5_usb3phy_drv_data' driver data.      
5) Not deleting support for old driver 'phy-samsung-usb3' until
   required support for generic phy is added to DWC3.  
 
Changes from RFC patch-set:
1) fixes in documentation file
 - added provision for syscon interface for using PMU register.
 - added clock names and description
 - modified description style for 'compatible property'                    
 - made usb30_sclk as additional clock rather then making it optional, since
   it is actually an additional clock for Exynos5420 Soc.
2) fixes in phy-exynos5-usb3 driver file
 - removed unnecessary #ifndef around KHZ and MHZ definitions            
 - removed 'samsung_cpu_type', 'usb3phy_state' enums; and merged necessary
   necessary from 'usb3phy_instance' structure to 'usb3phy_driver'.
 - changed name 'sclk_usbphy30' to 'usb30_sclk_100m' since this is the name
   indicated as input to the PHY block; and also added (!IS_ERR()) check for
   using usb30_sclk.
 - removed unnecessary 'state' check code.
 - moved 'of_device_id' structure definitions before 'probe()' to avoid
   unnecessary declaration.
 - added (pdev->dev.of_node == NULL) check at the starting of probe()
 - moved 'devm_of_phy_provider_register()' call to end of the probe().
 - removed 'label' for usb3drd phy.
 - corrected macros definition 'PHYCLKRST_MPLL_MULTIPLIER_50M_REF' from
   0x02 to 0x32 after confirming same from PHY's data sheet.
 - replaced pmu register handling, used for power-isolation, with syscon
   interface api's.
 - added '.init' and '.exit' callbacks and using them for one time
   PHY-initialization and deinitialization.
 - Filtering out the PHY 'power-on' and 'power-off' sequence to '.power_on"
   and ".power_off" callbacks.
 - Removed drivers/usb/phy/phy-samsung-usb3.c driver and related code.
3) fixes in dt files
 - added reference for 'samsung,syscon-phandle' to used for PMU register.
 - removed second register field which was earlier used for PMU.

Vivek Gautam (5):
  phy: Add new Exynos5 USB 3.0 PHY driver
  dt: exynos5420: Enable support for USB 3.0 PHY controller
  dt: exynos5420: Enable support for DWC3 controller
  dt: exynos5250: Enable support for generic USB DRD phy
  usb-phy: samsung-usb3: Remove older phy-samsung-usb3 driver

 .../devicetree/bindings/phy/samsung-phy.txt        |   42 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |   21 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   54 ++
 drivers/phy/Kconfig                                |   11 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-exynos5-usbdrd.c                   |  668 ++++++++++++++++++++
 drivers/usb/phy/phy-samsung-usb.h                  |   83 ---
 drivers/usb/phy/phy-samsung-usb3.c                 |  350 ----------
 8 files changed, 785 insertions(+), 445 deletions(-)
 create mode 100644 drivers/phy/phy-exynos5-usbdrd.c
 delete mode 100644 drivers/usb/phy/phy-samsung-usb3.c

-- 
1.7.10.4
