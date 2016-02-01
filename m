From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  1 Feb 2016 21:35:58 +0100
Subject: [PATCH 4/4] ARM: davinci: make I2C support optional
In-Reply-To: <1454358962-640598-1-git-send-email-arnd@arndb.de>
References: <1454358962-640598-1-git-send-email-arnd@arndb.de>
Message-ID: <1454358962-640598-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci platform has tried to get support for the EEPROM right,
but failed to get a clean build so far. At the moment, we get
a warning whenever CONFIG_SYSFS is disabled, as that is needed by
EEPROM_AT24:

warning: (MACH_DAVINCI_EVM && MACH_SFFSDR && MACH_DAVINCI_DM6467_EVM && MACH_DAVINCI_DM365_EVM && MACH_DAVINCI_DA830_EVM && MACH_MITYOMAPL138 && MACH_MINI2440) selects EEPROM_AT24 which has unmet direct dependencies (I2C && SYSFS)

Kevin Hilman initially added the 'select' to ensure that EEPROM_AT24
is always enabled in machines that really want it for normal operation
(i.e. for reading the MAC address). This broke when I2C was disabled,
and Russell King followed up with another patch to select that as
well.

I now see that the SYSFS dependency is still missing, which leaves
us with three options:

a) add 'select SYSFS' in addition to the others
b) change AT24_EEPPROM to work without sysfs (should be possible)
c) remove all those selects again and get the files to build when
   I2C is disabled.

I would really hate to do a) because adding select statements that
hardwire user-selectable symbols is generally a bad idea. I first
tried b) but then ended up redoing the patch from scratch to approach
c), so we can also remove the other selects.

I checked that CONFIG_I2C is still enabled with davinci_all_defconfig,
so that does not have to change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 45b146d746ea ("ARM: Davinci: Fix I2C build errors")
Fixes: 22ca466847ad ("davinci: kconfig: select at24 eeprom for selected boards")
---
 arch/arm/mach-davinci/Kconfig            | 14 +-------------
 arch/arm/mach-davinci/board-dm644x-evm.c |  8 ++++++--
 arch/arm/mach-davinci/board-dm646x-evm.c |  7 +++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 8f54be83ec15..c1d2cb4ec04f 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -76,8 +76,6 @@ config MACH_DAVINCI_EVM
 	bool "TI DM644x EVM"
 	default ARCH_DAVINCI_DM644x
 	depends on ARCH_DAVINCI_DM644x
-	select EEPROM_AT24
-	select I2C
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM644x EVM
@@ -85,8 +83,6 @@ config MACH_DAVINCI_EVM
 config MACH_SFFSDR
 	bool "Lyrtech SFFSDR"
 	depends on ARCH_DAVINCI_DM644x
-	select EEPROM_AT24
-	select I2C
 	help
 	  Say Y here to select the Lyrtech Small Form Factor
 	  Software Defined Radio (SFFSDR) board.
@@ -117,8 +113,6 @@ config MACH_DAVINCI_DM6467_EVM
 	bool "TI DM6467 EVM"
 	default ARCH_DAVINCI_DM646x
 	depends on ARCH_DAVINCI_DM646x
-	select EEPROM_AT24
-	select I2C
 	select MACH_DAVINCI_DM6467TEVM
 	help
 	  Configure this option to specify the whether the board used
@@ -131,8 +125,6 @@ config MACH_DAVINCI_DM365_EVM
 	bool "TI DM365 EVM"
 	default ARCH_DAVINCI_DM365
 	depends on ARCH_DAVINCI_DM365
-	select EEPROM_AT24
-	select I2C
 	help
 	  Configure this option to specify whether the board used
 	  for development is a DM365 EVM
@@ -141,9 +133,7 @@ config MACH_DAVINCI_DA830_EVM
 	bool "TI DA830/OMAP-L137/AM17x Reference Platform"
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
-	select EEPROM_AT24
-	select GPIO_PCF857X
-	select I2C
+	select GPIO_PCF857X if I2C
 	help
 	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
 
@@ -212,8 +202,6 @@ endchoice
 config MACH_MITYOMAPL138
 	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
 	depends on ARCH_DAVINCI_DA850
-	select EEPROM_AT24
-	select I2C
 	help
 	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
 	  System on Module.  Information on this SoM may be found at
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 7a20507a3eef..68cc09907828 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -267,7 +267,7 @@ static struct platform_device rtc_dev = {
 static struct snd_platform_data dm644x_evm_snd_data;
 
 /*----------------------------------------------------------------------*/
-
+#ifdef CONFIG_I2C
 /*
  * I2C GPIO expanders
  */
@@ -612,6 +612,7 @@ static void __init evm_init_i2c(void)
 	i2c_add_driver(&dm6446evm_msp_driver);
 	i2c_register_board_info(1, i2c_info, ARRAY_SIZE(i2c_info));
 }
+#endif
 
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
@@ -780,7 +781,9 @@ static __init void davinci_evm_init(void)
 				pr_warn("%s: Cannot configure AEMIF\n",
 					__func__);
 
+#ifdef CONFIG_I2C
 			evm_leds[7].default_trigger = "nand-disk";
+#endif
 			if (HAS_NOR)
 				pr_warn("WARNING: both NAND and NOR flash are enabled; disable one of them.\n");
 		} else if (HAS_NOR)
@@ -789,9 +792,10 @@ static __init void davinci_evm_init(void)
 
 	platform_add_devices(davinci_evm_devices,
 			     ARRAY_SIZE(davinci_evm_devices));
+#ifdef CONFIG_I2C
 	evm_init_i2c();
-
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
+#endif
 	dm644x_init_video(&dm644xevm_capture_cfg, &dm644xevm_display_cfg);
 
 	davinci_serial_init(dm644x_serial_device);
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ee6ab7e8d3b0..f702d4fc8eb8 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -121,6 +121,7 @@ static struct platform_device davinci_nand_device = {
 
 #define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
 
+#ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
 #define DM646X_EVM_ATA_RST		BIT(0)
 #define DM646X_EVM_ATA_PWD		BIT(1)
@@ -316,6 +317,7 @@ static struct at24_platform_data eeprom_info = {
 	.setup          = davinci_get_mac_addr,
 	.context	= (void *)0x7f00,
 };
+#endif
 
 static u8 dm646x_iis_serializer_direction[] = {
        TX_MODE, RX_MODE, INACTIVE_MODE, INACTIVE_MODE,
@@ -346,6 +348,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 	},
 };
 
+#ifdef CONFIG_I2C
 static struct i2c_client *cpld_client;
 
 static int cpld_video_probe(struct i2c_client *client,
@@ -710,6 +713,7 @@ static void __init evm_init_i2c(void)
 	evm_init_cpld();
 	evm_init_video();
 }
+#endif
 
 #define DM6467T_EVM_REF_FREQ		33000000
 
@@ -764,7 +768,10 @@ static __init void evm_init(void)
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
 
+#ifdef CONFIG_I2C
 	evm_init_i2c();
+#endif
+
 	davinci_serial_init(dm646x_serial_device);
 	dm646x_init_mcasp0(&dm646x_evm_snd_data[0]);
 	dm646x_init_mcasp1(&dm646x_evm_snd_data[1]);
-- 
2.7.0
