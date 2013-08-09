From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:49:48 +0900
Subject: [PATCH 11/14] ARM: shmobile: Rename to r8a7779_init_early(),
 use smp_set_ops()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094948.6530.299.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a7779_init_delay() into r8a7779_init_early()
to make the function name show that more than just
delay setup will happen.

Also, instead of specifying the smp ops in DT_MACHINE
convert the r8a7779 SoC code to install the smp ops
from r8a7779_init_early().

The r8a7779_add_early_devices() function also gets
updated to call r8a7779_init_early(). This way the
smp ops will be installed in both DT and C cases.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen-reference.c |    3 +--
 arch/arm/mach-shmobile/board-marzen.c           |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |   17 +++++++++++------
 4 files changed, 13 insertions(+), 10 deletions(-)

--- 0012/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2013-08-08 16:25:43.000000000 +0900
@@ -41,9 +41,8 @@ static const char *marzen_boards_compat_
 };
 
 DT_MACHINE_START(MARZEN, "marzen")
-	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_init_delay,
+	.init_early	= r8a7779_init_early,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.dt_compat	= marzen_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2013-08-08 16:25:53.000000000 +0900
@@ -263,7 +263,6 @@ static const char *marzen_boards_compat_
 };
 
 DT_MACHINE_START(MARZEN, "marzen")
-	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
 	.init_irq	= r8a7779_init_irq_dt,
--- 0004/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2013-08-08 16:26:58.000000000 +0900
@@ -23,7 +23,7 @@ static inline struct r8a7779_pm_ch *to_r
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
 
-extern void r8a7779_init_delay(void);
+extern void r8a7779_init_early(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
--- 0012/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-08-08 16:29:06.000000000 +0900
@@ -663,8 +663,18 @@ void __init r8a7779_earlytimer_init(void
 	r8a7779_register_twd();
 }
 
+void __init r8a7779_init_early(void)
+{
+	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
+#ifdef CONFIG_SMP
+	smp_set_ops(&r8a7779_smp_ops);
+#endif
+}
+
 void __init r8a7779_add_early_devices(void)
 {
+	r8a7779_init_early();
+
 	early_platform_add_devices(r8a7779_devices_dt,
 				   ARRAY_SIZE(r8a7779_devices_dt));
 
@@ -726,11 +736,6 @@ void __init r8a7779_init_irq_dt(void)
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
 }
 
-void __init r8a7779_init_delay(void)
-{
-	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
-}
-
 static const char *r8a7779_compat_dt[] __initdata = {
 	"renesas,r8a7779",
 	NULL,
@@ -738,7 +743,7 @@ static const char *r8a7779_compat_dt[] _
 
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_init_delay,
+	.init_early	= r8a7779_init_early,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
