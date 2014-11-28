From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 28 Nov 2014 16:44:31 +0000
Subject: [PATCH RESEND] ARM: vexpress: Enable regulator framework when MMCI is
 in use
In-Reply-To: <1417192440.4371.15.camel@arm.com>
References: <1417192440.4371.15.camel@arm.com>
Message-ID: <1417193071-801-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMCI driver, when used with a Device Tree described device, relies
on the "vmmc" voltage regulator supply to set the OCR register voltage bits,
using MMC core's mmc_regulator_get_supply() function.

Without the regulator framework present there are no valid operating
voltages reported and the device initialisation fails:

mmci-pl18x 10005000.mmci: No vmmc regulator found
mmci-pl18x 10005000.mmci: no support for card's volts
mmc0: error -22 whilst initialising SD card

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9a96bab..d6b16d9 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -16,6 +16,7 @@ menuconfig ARCH_VEXPRESS
 	select POWER_RESET
 	select POWER_RESET_VEXPRESS
 	select POWER_SUPPLY
+	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
 	select VEXPRESS_SYSCFG
-- 
2.1.0
