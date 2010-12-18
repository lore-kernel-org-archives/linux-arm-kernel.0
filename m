From: nm@ti.com (Nishanth Menon)
Date: Sat, 18 Dec 2010 16:53:33 -0600
Subject: [PATCH v4 3/7] omap3: pm: introduce errata handling
In-Reply-To: <1292712817-24999-1-git-send-email-nm@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
Message-ID: <1292712817-24999-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce errata handling for omap3. This patch introduces
errata variable and and stub for initialization which will be
filled up by followon patches.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Splitting the errata introduction out into it's own separate patch

 arch/arm/mach-omap2/pm.h     |    7 +++++++
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..0348fd7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -85,4 +85,11 @@ extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
+extern u16 pm34xx_errata;
+#define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
+#else
+#define IS_PM34XX_ERRATUM(id)		0
+#endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
+
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 648b8c5..5702f41 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -68,6 +68,9 @@ static inline bool is_suspending(void)
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
+/* pm34xx errata defined in pm.h */
+u16 pm34xx_errata;
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -1002,6 +1005,10 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void __init pm_errata_configure(void)
+{
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -1011,6 +1018,8 @@ static int __init omap3_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	pm_errata_configure();
+
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
-- 
1.6.3.3
