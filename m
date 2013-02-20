From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 20:57:11 +0530
Subject: [PATCH 5/8] ARM: OMAP5: Update SAR RAM base address
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361374034-21831-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update SAR RAM base address for OMAP5 based devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   10 ++++++++--
 arch/arm/mach-omap2/omap54xx.h     |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6897ae2..59399f8 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -239,15 +239,21 @@ void __iomem *omap4_get_sar_ram_base(void)
  */
 static int __init omap4_sar_ram_init(void)
 {
+	unsigned long sar_base;
+
 	/*
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */
-	if (!cpu_is_omap44xx())
+	if (cpu_is_omap44xx())
+		sar_base = OMAP44XX_SAR_RAM_BASE;
+	else if (soc_is_omap54xx())
+		sar_base = OMAP54XX_SAR_RAM_BASE;
+	else
 		return -ENOMEM;
 
 	/* Static mapping, never released */
-	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
+	sar_ram_base = ioremap(sar_base, SZ_16K);
 	if (WARN_ON(!sar_ram_base))
 		return -ENOMEM;
 
diff --git a/arch/arm/mach-omap2/omap54xx.h b/arch/arm/mach-omap2/omap54xx.h
index a2582bb..a086ba1 100644
--- a/arch/arm/mach-omap2/omap54xx.h
+++ b/arch/arm/mach-omap2/omap54xx.h
@@ -28,5 +28,6 @@
 #define OMAP54XX_PRCM_MPU_BASE		0x48243000
 #define OMAP54XX_SCM_BASE		0x4a002000
 #define OMAP54XX_CTRL_BASE		0x4a002800
+#define OMAP54XX_SAR_RAM_BASE		0x4ae26000
 
 #endif /* __ASM_SOC_OMAP555554XX_H */
-- 
1.7.9.5
