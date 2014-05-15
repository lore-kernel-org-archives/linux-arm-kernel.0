From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:02 +0900
Subject: [PATCH v6 07/17] ARM: shmobile: r8a7779: Move r8a7779_earlytimer_init
 to clock-r8a7779.c
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-8-git-send-email-horms+renesas@verge.net.au>
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

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 11 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index e9d3348..4c8add9 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <linux/sh_timer.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7779.h>
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
index 6d091bd..6c1aef0 100644
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
1.8.5.2
