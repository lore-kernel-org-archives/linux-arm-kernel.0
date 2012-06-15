From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Jun 2012 09:42:56 +0100
Subject: [PATCH 1/1] ARM: ux500: Fix build errors/warnings when MACH_UX500_DT
 is not set
Message-ID: <1339749776-9468-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When MACH_UX500_DT and all related Device Tree configurations are forced
off the warning and error below prevent the kernel from compiling. This
simple patch fixes both issues and allows for full build and boot of
ST-Ericsson's low-cost development board, Snowball.

Warnings fixed:
  arch/arm/mach-ux500/board-mop500.c:680:32: warning: ?snowball_of_platform_devs? defined but not used

Errors fixed:
  arch/arm/mach-ux500/timer.c: In function ?ux500_timer_init?:
  arch/arm/mach-ux500/timer.c:66:3: error: implicit declaration of function ?of_find_matching_node?
  arch/arm/mach-ux500/timer.c:66:6: warning: assignment makes pointer from integer without a cast

Cc: stable at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   10 +++++-----
 arch/arm/mach-ux500/timer.c        |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9c74ac5..73fb6e8 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -677,11 +677,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 	&ab8500_device,
 };
 
-static struct platform_device *snowball_of_platform_devs[] __initdata = {
-	&snowball_led_dev,
-	&snowball_key_dev,
-};
-
 static void __init mop500_init_machine(void)
 {
 	struct device *parent = NULL;
@@ -821,6 +816,11 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_UX500_DT
 
+static struct platform_device *snowball_of_platform_devs[] __initdata = {
+	&snowball_led_dev,
+	&snowball_key_dev,
+};
+
 struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires DMA and call-back bindings. */
 	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 741e71f..66e7f00 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -63,8 +63,10 @@ static void __init ux500_timer_init(void)
 
 	/* TODO: Once MTU has been DT:ed place code above into else. */
 	if (of_have_populated_dt()) {
+#ifdef CONFIG_OF
 		np = of_find_matching_node(NULL, prcmu_timer_of_match);
 		if (!np)
+#endif
 			goto dt_fail;
 
 		tmp_base = of_iomap(np, 0);
-- 
1.7.9.5
