From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:38 -0500
Subject: [PATCH 09/20] ARM: mach-h720x: move special idle code out of line
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-10-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and hook it to arm_pm_idle.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-h720x/common.c              |   18 ++++++++++++++++++
 arch/arm/mach-h720x/include/mach/system.h |    7 +------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index f8a2f6bb54..e756d1ac00 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -247,3 +247,21 @@ void h720x_restart(char mode, const char *cmd)
 {
 	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
 }
+
+static void h720x__idle(void)
+{
+	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_IDLE;
+	nop();
+	nop();
+	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_RUN;
+	nop();
+	nop();
+}
+
+static int __init h720x_idle_init(void)
+{
+	arm_pm_idle = h720x__idle;
+	return 0;
+}
+
+arch_initcall(h720x_idle_init);
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index 16ac46e239..008ed164b2 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -16,12 +16,7 @@
 
 static void arch_idle(void)
 {
-	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_IDLE;
-	nop();
-	nop();
-	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_RUN;
-	nop();
-	nop();
+	cpu_do_idle();
 }
 
 #endif
-- 
1.7.7.1.431.g10b2a
