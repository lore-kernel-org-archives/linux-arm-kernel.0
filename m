From: loic.pallardy-ext@stericsson.com (Loic Pallardy)
Date: Wed, 5 Sep 2012 11:59:01 +0200
Subject: [PATCH 05/17] mfd: dbx500-prcmu: Handle TCDM mapping
In-Reply-To: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <1346839153-6465-6-git-send-email-loic.pallardy-ext@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c        | 2 +-
 drivers/mfd/db8500-prcmu.c       | 2 +-
 include/linux/mfd/db8500-prcmu.h | 4 ++--
 include/linux/mfd/dbx500-prcmu.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 4a5177b..08672be 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -9,7 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/mfd/db8500-prcmu.h>
+#include <linux/mfd/dbx500-prcmu.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index de09113..1d2fb45 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2668,7 +2668,7 @@ static int db8500_irq_init(struct device_node *np)
 	return 0;
 }
 
-void __init db8500_prcmu_early_init(void)
+void __init db8500_prcmu_early_init(struct prcmu_tcdm_map *map)
 {
 	if (cpu_is_u8500v2()) {
 		void *tcpm_base = ioremap_nocache(U8500_PRCMU_TCPM_BASE, SZ_4K);
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index b82f6ee..f932a56 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -509,7 +509,7 @@ struct prcmu_fw_version {
 
 #ifdef CONFIG_MFD_DB8500_PRCMU
 
-void db8500_prcmu_early_init(void);
+void db8500_prcmu_early_init(struct prcmu_tcdm_map *map);
 int prcmu_set_rc_a2p(enum romcode_write);
 enum romcode_read prcmu_get_rc_p2a(void);
 enum ap_pwrst prcmu_get_xp70_current_state(void);
@@ -573,7 +573,7 @@ void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value);
 
 #else /* !CONFIG_MFD_DB8500_PRCMU */
 
-static inline void db8500_prcmu_early_init(void) {}
+static inline void db8500_prcmu_early_init(struct prcmu_tcdm_map *map) {}
 
 static inline int prcmu_set_rc_a2p(enum romcode_write code)
 {
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 55025ba..aab183d 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -226,7 +226,7 @@ struct prcmu_tcdm_map {
 
 static inline void __init prcmu_early_init(struct prcmu_tcdm_map *map)
 {
-	return db8500_prcmu_early_init();
+	return db8500_prcmu_early_init(map);
 }
 
 static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
-- 
1.7.11.1
