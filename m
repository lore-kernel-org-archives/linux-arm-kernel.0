From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:46:05 +0000
Subject: [PATCH 01/11] ARM: integrator: use new init_early for clock tree init
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSAn-0003ot-Uc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the clock tree early.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/common.h        |    1 +
 arch/arm/mach-integrator/core.c          |    7 +++++--
 arch/arm/mach-integrator/integrator_ap.c |    3 ++-
 arch/arm/mach-integrator/integrator_cp.c |   11 +++++++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 5f96e15..a08f9b0 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1 +1,2 @@
+void integrator_init_early(void);
 void integrator_reserve(void);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index b8e884b..77315b9 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -144,12 +144,15 @@ static struct clk_lookup lookups[] = {
 	}
 };
 
+void __init integrator_init_early(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
+
 static int __init integrator_init(void)
 {
 	int i;
 
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index b666443..4f06b5d 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -499,8 +499,9 @@ static struct sys_timer ap_timer = {
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.boot_params	= 0x00000100,
-	.map_io		= ap_map_io,
 	.reserve	= integrator_reserve,
+	.map_io		= ap_map_io,
+	.init_early	= integrator_init_early,
 	.init_irq	= ap_init_irq,
 	.timer		= &ap_timer,
 	.init_machine	= ap_init,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 9c02037..e6700aa 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -520,11 +520,17 @@ static struct amba_device *amba_devs[] __initdata = {
 	&clcd_device,
 };
 
+static void __init intcp_init_early(void)
+{
+	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
+
+	integrator_init_early();
+}
+
 static void __init intcp_init(void)
 {
 	int i;
 
-	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
 	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
@@ -554,8 +560,9 @@ static struct sys_timer cp_timer = {
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.boot_params	= 0x00000100,
-	.map_io		= intcp_map_io,
 	.reserve	= integrator_reserve,
+	.map_io		= intcp_map_io,
+	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq,
 	.timer		= &cp_timer,
 	.init_machine	= intcp_init,
-- 
1.6.2.5
