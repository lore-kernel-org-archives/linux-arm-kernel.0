From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Nov 2014 10:32:53 +0100
Subject: [PATCH 1/4] ARM: integrator: move restart to the device tree
Message-ID: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the augmented reset driver for the Versatile family,
we can move the reset handling for the Integrator out of the
machine. We add a "syscon" attribute to the core module, and
access the syscon registers using this handle. We need to
select SYSCON, POWER, POWER_RESET and POWER_RESET_VERSATILE
in order for the restart functionality to always be
available on all systems (it should not be optional).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi        | 2 +-
 arch/arm/mach-integrator/Kconfig         | 4 ++++
 arch/arm/mach-integrator/cm.h            | 1 -
 arch/arm/mach-integrator/common.h        | 1 -
 arch/arm/mach-integrator/core.c          | 8 --------
 arch/arm/mach-integrator/integrator_ap.c | 1 -
 arch/arm/mach-integrator/integrator_cp.c | 1 -
 7 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 88e3d477bf16..5546630c4fd2 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	core-module at 10000000 {
-		compatible = "arm,core-module-integrator";
+		compatible = "arm,core-module-integrator", "syscon";
 		reg = <0x10000000 0x200>;
 	};
 
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index aa7eb272e602..62e6db4bd533 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -8,8 +8,12 @@ config ARCH_INTEGRATOR
 	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select ICST
+	select MFD_SYSCON
 	select MULTI_IRQ_HANDLER
 	select PLAT_VERSATILE
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
 	select SPARSE_IRQ
 	select USE_OF
 	select VERSATILE_FPGA_IRQ
diff --git a/arch/arm/mach-integrator/cm.h b/arch/arm/mach-integrator/cm.h
index 4ecff7bff482..5b8ba8247f45 100644
--- a/arch/arm/mach-integrator/cm.h
+++ b/arch/arm/mach-integrator/cm.h
@@ -11,7 +11,6 @@ void cm_clear_irqs(void);
 #define CM_CTRL_LED			(1 << 0)
 #define CM_CTRL_nMBDET			(1 << 1)
 #define CM_CTRL_REMAP			(1 << 2)
-#define CM_CTRL_RESET			(1 << 3)
 
 /*
  * Integrator/AP,PP2 specific
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index ad0ac5547b2c..27a627aa1e8f 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -4,5 +4,4 @@ extern struct amba_pl010_data ap_uart_data;
 void integrator_init_early(void);
 int integrator_init(bool is_cp);
 void integrator_reserve(void);
-void integrator_restart(enum reboot_mode, const char *);
 void integrator_init_sysfs(struct device *parent, u32 id);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index e3f3aca43efb..b06fd9f99a46 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -140,14 +140,6 @@ void __init integrator_reserve(void)
 	memblock_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 }
 
-/*
- * To reset, we hit the on-board reset register in the system FPGA
- */
-void integrator_restart(enum reboot_mode mode, const char *cmd)
-{
-	cm_control(CM_CTRL_RESET, CM_CTRL_RESET);
-}
-
 static u32 integrator_id;
 
 static ssize_t intcp_get_manf(struct device *dev,
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 8a879b654fde..e6854c3f854e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -365,6 +365,5 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.init_early	= ap_init_early,
 	.init_irq	= ap_init_irq_of,
 	.init_machine	= ap_init_of,
-	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index cca02eb75eb5..fa8475b4872d 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -324,6 +324,5 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq_of,
 	.init_machine	= intcp_init_of,
-	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
 MACHINE_END
-- 
1.9.3
