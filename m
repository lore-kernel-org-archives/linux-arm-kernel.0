From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 15 Nov 2012 00:37:53 +0530
Subject: [PATCH V5 0/7] ARM: AM33XX: net: Add DT support to CPSW and MDIO
 driver
Message-ID: <1352920080-6179-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-series adds support for,

[1/7]: Typo mistake in CPSW driver while invoking runtime_pm api's

[2/7]: Adds parent<->child relation between CPSW & MDIO module inside cpsw
       driver, as in case of AM33XX, the resources are shared and common
       register bit-field is provided to control module/clock enable/disable,
       makes it difficult to handle common resource.

       So the solution here is, to create parent<->child relation between them.

[3/7]: cpsw: simplify the setup of the register pointers

[4/7]: cpsw: Kernel warn fix during suspend

[5/7]: Add hwmod entry for MDIO module, required for MDIO driver.

[6/7]: Enable CPSW support to omap2plus_defconfig

[7/7]: Add DT device nodes for both CPSW and MDIO modules in am33xx.dtsi,
       am335x-evm.dts and am335x-bone.dts file

This patch series has been created on top of net-next/master and tested
on BeagleBone platform for NFS boot and basic ping test cases.

Changes from V3:
* Removed unnecessary flags in Davinci MDIO Hwmod entry.

Changes from V4:
* Changed CPSW phy ID in DT to make it generic.
* Applied cosmetic changed in AM33XX dts file from Benoit Cousson

Mugunthan V N (4):
  net: cpsw: halt network stack before halting the device during
    suspend
  ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for davinci_mdio module
  ARM: OMAP2+: omap2plus_defconfig: Enable CPSW support
  arm/dts: am33xx: Add CPSW and MDIO module nodes for AM33XX

Richard Cochran (1):
  cpsw: simplify the setup of the register pointers

Vaibhav Hiremath (2):
  net: davinci_mdio: Fix typo mistake in calling runtime-pm api
  net: cpsw: Add parent<->child relation support between cpsw and mdio

 Documentation/devicetree/bindings/net/cpsw.txt |   42 +----
 arch/arm/boot/dts/am335x-bone.dts              |    8 +
 arch/arm/boot/dts/am335x-evm.dts               |    8 +
 arch/arm/boot/dts/am33xx.dtsi                  |   48 +++++
 arch/arm/configs/omap2plus_defconfig           |    3 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c     |   31 +++
 drivers/net/ethernet/ti/cpsw.c                 |  248 +++++++++++-------------
 drivers/net/ethernet/ti/davinci_mdio.c         |    2 +-
 include/linux/platform_data/cpsw.h             |   21 +--
 9 files changed, 216 insertions(+), 195 deletions(-)
