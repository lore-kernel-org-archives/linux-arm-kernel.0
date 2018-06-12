From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 15:24:10 -0500
Subject: [PATCH 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable
 invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <20180612202411.29798-1-nm@ti.com>
References: <20180612202411.29798-1-nm@ti.com>
Message-ID: <20180612202411.29798-4-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
function to setup the bits, we are able to override the settings.

Without this enabled, Linux kernel reports:
CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable

With this enabled, Linux kernel reports:
CPU0: Spectre v2: using ICIALLU workaround

NOTE: This by itself does not enable the workaround for CPU1 (on
OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3bb1ecb58de0..77820cc8d1e4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -53,6 +53,7 @@ config OMAP54XX
 	bool "OMAP54XX SoC"
 	select ARM_ERRATA_798870
 	select SYS_THUMB_BUILD
+	select ARM_CORTEX_A15_CVE_2017_5715
 	imply NAND_OMAP_ELM
 	imply NAND_OMAP_GPMC
 	imply SPL_DISPLAY_PRINT
-- 
2.15.1
