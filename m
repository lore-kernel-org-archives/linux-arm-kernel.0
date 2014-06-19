From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 19 Jun 2014 19:26:35 +0400
Subject: [PATCH RESEND 3/5] ARM: clps711x: Switch CLPS711X subarch to use
 cpuidle driver
In-Reply-To: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
References: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
Message-ID: <1403191597-28460-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes old support for cpuidle and switches all current
users to use new cpuidle driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c |  1 -
 arch/arm/mach-clps711x/board-cdb89712.c |  1 -
 arch/arm/mach-clps711x/board-clep7312.c |  1 -
 arch/arm/mach-clps711x/board-edb7211.c  |  1 -
 arch/arm/mach-clps711x/board-p720t.c    |  1 -
 arch/arm/mach-clps711x/common.c         | 12 ------------
 arch/arm/mach-clps711x/common.h         |  1 -
 arch/arm/mach-clps711x/devices.c        | 10 ++++++++++
 8 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index d62ca16..45abf6b 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -266,7 +266,6 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= autcpu12_init,
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index e261a47..1ec378c 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -140,7 +140,6 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index 94a7add..b33ba21 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -37,7 +37,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.atag_offset	= 0x0100,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.restart	= clps711x_restart,
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index f9828f8..7ad94ff 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -178,7 +178,6 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 0cf0e51..b993767 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -365,7 +365,6 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.atag_offset	= 0x100,
 	.fixup		= fixup_p720t,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index aee81fa..2a6323b 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -193,15 +193,3 @@ void clps711x_restart(enum reboot_mode mode, const char *cmd)
 {
 	soft_restart(0);
 }
-
-static void clps711x_idle(void)
-{
-	clps_writel(1, HALT);
-	asm("mov r0, r0");
-	asm("mov r0, r0");
-}
-
-void __init clps711x_init_early(void)
-{
-	arm_pm_idle = clps711x_idle;
-}
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 7489139..f881899 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -13,7 +13,6 @@ extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
 extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
-extern void clps711x_init_early(void);
 
 /* drivers/irqchip/irq-clps711x.c */
 void clps711x_intc_init(phys_addr_t, resource_size_t);
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 2001488..0c689d3 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -14,6 +14,15 @@
 
 #include <mach/hardware.h>
 
+static const struct resource clps711x_cpuidle_res __initconst =
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + HALT, SZ_128);
+
+static void __init clps711x_add_cpuidle(void)
+{
+	platform_device_register_simple("clps711x-cpuidle", PLATFORM_DEVID_NONE,
+					&clps711x_cpuidle_res, 1);
+}
+
 static const phys_addr_t clps711x_gpios[][2] __initconst = {
 	{ PADR, PADDR },
 	{ PBDR, PBDDR },
@@ -83,6 +92,7 @@ static void __init clps711x_add_uart(void)
 
 void __init clps711x_devices_init(void)
 {
+	clps711x_add_cpuidle();
 	clps711x_add_gpio();
 	clps711x_add_syscon();
 	clps711x_add_uart();
-- 
1.8.5.5
