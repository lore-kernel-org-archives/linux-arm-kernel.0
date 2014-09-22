From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:28 +0200
Subject: [PATCH 7/9] ARM: imx: src: Support vf610 system reset controller
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <0ca4daed3e71bf1eb20e3667ed66536c60b35007.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Vybrid SoC's system reset controller (SRC). Currently we
don't register a reset controller but only support the imx_cpu_jump
and imx_cpu_arg functions.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig      |  1 +
 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/mach-vf610.c |  1 +
 arch/arm/mach-imx/src.c        | 11 +++++++++++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 70e6d56..f393775 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -634,6 +634,7 @@ config SOC_VF610
 	select ARM_GIC
 	select PINCTRL_VF610
 	select HAVE_IMX_GPC
+	select HAVE_IMX_SRC
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	select PL310_ERRATA_769419 if CACHE_L2X0
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4b753f5..ca7a0d9 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -103,6 +103,7 @@ static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
 #endif
 void imx_src_init(void);
+void vf610_src_init(void);
 void imx6_gpc_init(void);
 void vf610_gpc_init(void);
 void imx_gpc_pre_suspend(bool arm_power_off);
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 532f18f..eef3496 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -16,6 +16,7 @@
 
 static void __init vf610_init_irq(void)
 {
+	vf610_src_init();
 	vf610_gpc_init();
 	irqchip_init();
 }
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 45f7f4e..a1f5160 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -140,3 +140,14 @@ void __init imx_src_init(void)
 	writel_relaxed(val, src_base + SRC_SCR);
 	spin_unlock(&scr_lock);
 }
+
+void __init vf610_src_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-src");
+	if (!np)
+		return;
+	src_base = of_iomap(np, 0);
+	WARN_ON(!src_base);
+}
-- 
2.1.0
