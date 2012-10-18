From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 18 Oct 2012 12:20:04 +0300
Subject: [PATCHv9 2/8] ARM: OMAP4: PM: add errata support
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Message-ID: <1350552010-28760-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added similar PM errata flag support as omap3 has. This should be used
in similar manner, set the flags during init time, and check the flag
values during runtime.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    7 +++++++
 arch/arm/mach-omap2/pm44xx.c |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 707e9cb..f26f2d7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -100,6 +100,13 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
 static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
 
+#if defined(CONFIG_ARCH_OMAP4)
+extern u16 pm44xx_errata;
+#define IS_PM44XX_ERRATUM(id)		(pm44xx_errata & (id))
+#else
+#define IS_PM44XX_ERRATUM(id)		0
+#endif
+
 #ifdef CONFIG_POWER_AVS_OMAP
 extern int omap_devinit_smartreflex(void);
 extern void omap_enable_smartreflex_on_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index ba06300..07e7ef2 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -33,6 +33,7 @@ struct power_state {
 };
 
 static LIST_HEAD(pwrst_list);
+u16 pm44xx_errata;
 
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
-- 
1.7.4.1
