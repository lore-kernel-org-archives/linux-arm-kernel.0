From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 17 Dec 2012 19:26:30 +0200
Subject: [PATCH 1/2] ARM: OMAP3: PRCM: Fix incorrect read of reset sources
Message-ID: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flag mask are incorrect, so fix it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 0f51e03..dc45156 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -48,9 +48,10 @@ void __iomem *prcm_mpu_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+	if (cpu_is_omap34xx())
+		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7ff;
 	if (cpu_is_omap44xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 
-- 
1.7.9.5
