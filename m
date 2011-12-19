From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:35 -0500
Subject: [PATCH 06/20] ARM: mach-clps711x: move special idle code out of line
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and hook it to arm_pm_idle.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-clps711x/common.c              |   16 ++++++++++++++++
 arch/arm/mach-clps711x/include/mach/system.h |    5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index ab1711b9b4..8736c1acc1 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -225,3 +225,19 @@ void clps711x_restart(char mode, const char *cmd)
 {
 	soft_restart(0);
 }
+
+static void clps711x_idle(void)
+{
+	clps_writel(1, HALT);
+	__asm__ __volatile__(
+	"mov    r0, r0\n\
+	mov     r0, r0");
+}
+
+static int __init clps711x_idle_init(void)
+{
+	arm_pm_idle = clps711x_idle;
+	return 0;
+}
+
+arch_initcall(clps711x_idle_init);
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index 23d6ef8c84..0e74e1e9cc 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -26,10 +26,7 @@
 
 static inline void arch_idle(void)
 {
-	clps_writel(1, HALT);
-	__asm__ __volatile__(
-	"mov	r0, r0\n\
-	mov	r0, r0");
+	cpu_do_idle();
 }
 
 #endif
-- 
1.7.7.1.431.g10b2a
