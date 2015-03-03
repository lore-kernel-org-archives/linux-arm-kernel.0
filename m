From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:11 +0100
Subject: [PATCH v3 16/20] ARM: mvebu: add core support for Armada 39x
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the core support for Armada 39x, which is quite
simple:

 - a new Kconfig option which selects the appropriate clock and
   pinctrl drivers as well as other common features (GIC, L2 cache,
   SMP, etc.)

 - a new DT_MACHINE_START which references the top-level compatible
   strings supported for the Marvell Armada 39x.

 - a new SMP enable-method. The mechanism to enable CPUs for Armada
   39x appears to be the same as Armada 38x. However, we do not want
   to use marvell,armada-380-smp in the Device Tree, in the case of
   the discovery of a subtle difference in the future, which would
   require changing the Device Tree. And the enable-method isn't a
   compatible string: you can't specify several values and expect a
   fallback on the second string if the first one isn't
   supported. Therefore, we simply declare the SMP enable method
   "marvell,armada-390-smp" as doing the same thing as the
   "marvell,armada-380-smp" one.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig      | 14 ++++++++++++++
 arch/arm/mach-mvebu/board-v7.c   | 14 ++++++++++++++
 arch/arm/mach-mvebu/platsmp-a9.c |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index c1e4567..9747316 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -64,6 +64,20 @@ config MACH_ARMADA_38X
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 380/385 SoC with device tree.
 
+config MACH_ARMADA_39X
+	bool "Marvell Armada 39x boards" if ARCH_MULTI_V7
+	select ARM_GIC
+	select ARMADA_39X_CLK
+	select CACHE_L2X0
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	select HAVE_SMP
+	select MACH_MVEBU_V7
+	select PINCTRL_ARMADA_39X
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada 39x SoC with device tree.
+
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards" if ARCH_MULTI_V7
 	select ARMADA_XP_CLK
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 31b66f2..afee908 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -232,3 +232,17 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_38x_dt_compat,
 MACHINE_END
+
+static const char * const armada_39x_dt_compat[] __initconst = {
+	"marvell,armada390",
+	"marvell,armada398",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_39X_DT, "Marvell Armada 39x (Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.init_irq       = mvebu_init_irq,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_39x_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 2ec1a42..df0a9cc 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -110,3 +110,5 @@ CPU_METHOD_OF_DECLARE(mvebu_armada_375_smp, "marvell,armada-375-smp",
 		      &mvebu_cortex_a9_smp_ops);
 CPU_METHOD_OF_DECLARE(mvebu_armada_380_smp, "marvell,armada-380-smp",
 		      &armada_38x_smp_ops);
+CPU_METHOD_OF_DECLARE(mvebu_armada_390_smp, "marvell,armada-390-smp",
+		      &armada_38x_smp_ops);
-- 
2.1.0
