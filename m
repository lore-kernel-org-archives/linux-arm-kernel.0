From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:19 +0900
Subject: [PATCH 06/24] ARM: shmobile: r8a7779: Move r8a7779_earlytimer_init to
 clock-r8a7779.c
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <f48039a3da40f0c193122c83ad582913f2daf29d.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a7779_earlytimer_init() calls r8a7779_clock_init() and
r8a7779_clock_init() is defined in clock-r8a7779.c.

If both CONFIG_COMMON_CLK and CONFIG_ARCH_R8A7779 are enabled,
as will be the case when marzen-reference moves to use
the common clock framework, then setup-r8a7779.c is compiled
but clock-r8a7779.c is not.

As r8a7779_earlytimer_init() is not used by marzen-reference
simply move it to clock-r8a7779.c.

[horms+renesas at verge.net.au: rebase]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 11 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 5dd66a2..e690927 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <linux/sh_timer.h>
 #include <mach/r8a7779.h>
 #include "clock.h"
 #include "common.h"
@@ -261,3 +262,13 @@ void __init r8a7779_clock_init(void)
 	else
 		panic("failed to setup r8a7779 clocks\n");
 }
+
+/* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
+void __init __weak r8a7779_register_twd(void) { }
+
+void __init r8a7779_earlytimer_init(void)
+{
+	r8a7779_clock_init();
+	r8a7779_register_twd();
+	shmobile_earlytimer_init();
+}
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 25e1d0b..23122f6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -674,16 +674,6 @@ void __init r8a7779_add_standard_devices(void)
 	r8a7779_register_hpb_dmae();
 }
 
-/* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
-void __init __weak r8a7779_register_twd(void) { }
-
-void __init r8a7779_earlytimer_init(void)
-{
-	r8a7779_clock_init();
-	r8a7779_register_twd();
-	shmobile_earlytimer_init();
-}
-
 void __init r8a7779_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7779_devices_dt,
-- 
2.0.0.rc2
