From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 18 Mar 2013 18:00:55 +0000
Subject: [PATCH v2 1/2] ARM: vexpress: Enable regulator framework when MMCI is
 in use
In-Reply-To: <20130315181614.GY4977@n2100.arm.linux.org.uk>
References: <20130315181614.GY4977@n2100.arm.linux.org.uk>
Message-ID: <1363629655-28917-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMCI driver, when used with a Device Tree described device, relies
on the "vmmc" voltage regulator supply to set the OCR register voltage bits,
using MMC core's mmc_regulator_get_supply() function.

Without the regulator framework present there are no valid operating
voltages reported and the device initialisation fails:

mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
mmc0: host doesn't support card's voltages
mmc0: error -22 whilst initialising MMC card

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 52d315b..46ab88d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -17,6 +17,7 @@ config ARCH_VEXPRESS
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
 	help
-- 
1.7.10.4
