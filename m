From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 14:49:44 +0200
Subject: [PATCH] ARM: shmobile: only select sound drivers that build
Message-ID: <5616798.tmraH8vpuI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of codec drivers are selected by shmobile platform code,
but depend on I2C, which results in a build error:

sound/soc/codecs/ak4642.c:638:1: warning: data definition has no type or storage class
 module_i2c_driver(ak4642_i2c_driver);
 ^
sound/soc/codecs/ak4642.c:638:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/ak4642.c:638:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/ak4642.c:627:26: warning: 'ak4642_i2c_driver' defined but not used [-Wunused-variable]

This ensures that we do not enable the respective drivers when I2C
is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If this patch looks good, please add it to the shmobile git

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 679b866399f2..ca2182078547 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -150,7 +150,7 @@ config MACH_ARMADILLO800EVA
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SMSC_PHY if SH_ETH
-	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C
 	select USE_OF
 
 config MACH_BOCKW
@@ -158,8 +158,8 @@ config MACH_BOCKW
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SND_SOC_AK4554 if SND_SIMPLE_CARD
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select SND_SOC_AK4554 if SND_SIMPLE_CARD && I2C
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C
 	select USE_OF
 
 config MACH_BOCKW_REFERENCE
