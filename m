From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:33:59 -0600
Subject: [PATCH] clk: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
Message-ID: <1374014039-22469-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
This will reduce the number of configurations that need to be supported
by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

The Tegra clock driver contains a fairly large amount of SoC-specific
code and data. Introduce explicit config options so that the user can
trim the set of supported SoCs if they wish. Default these to on, since
most people will probably want to enable support for all SoCs. This also
avoids the need to change any defconfig files.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/Kconfig         |  2 ++
 drivers/clk/Makefile        |  2 +-
 drivers/clk/tegra/Kconfig   | 24 ++++++++++++++++++++++++
 drivers/clk/tegra/Makefile  |  6 +++---
 drivers/clk/tegra/clk-pll.c |  4 ++--
 5 files changed, 32 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/tegra/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 51380d6..8efaf3e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -87,6 +87,8 @@ config CLK_PPC_CORENET
 	  This adds the clock driver support for Freescale PowerPC corenet
 	  platforms using common clock framework.
 
+source "drivers/clk/tegra/Kconfig"
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4038c2b..3368f03 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= zynq/
-obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
+obj-$(CONFIG_CLK_TEGRA)		+= tegra/
 obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 
 obj-$(CONFIG_X86)		+= x86/
diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
new file mode 100644
index 0000000..abe609b
--- /dev/null
+++ b/drivers/clk/tegra/Kconfig
@@ -0,0 +1,24 @@
+config CLK_TEGRA
+	bool "Clock driver for NVIDIA Tegra SoCs"
+	depends on ARCH_TEGRA
+	default y
+	help
+	  Say y here to enable clock driver support for NVIDIA Tegra SoCs.
+
+	  This option provides core functionality; enable support for specific
+	  individual SoCs using the options below.
+
+config CLK_TEGRA20
+	bool "Tegra20 clock support"
+	depends on CLK_TEGRA
+	default y
+
+config CLK_TEGRA30
+	bool "Tegra30 clock support"
+	depends on CLK_TEGRA
+	default y
+
+config CLK_TEGRA114
+	bool "Tegra114 clock support"
+	depends on CLK_TEGRA
+	default y
diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index f49fac2..7b1a929 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -7,6 +7,6 @@ obj-y					+= clk-pll.o
 obj-y					+= clk-pll-out.o
 obj-y					+= clk-super.o
 
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
+obj-$(CONFIG_CLK_TEGRA20)		+= clk-tegra20.o
+obj-$(CONFIG_CLK_TEGRA30)		+= clk-tegra30.o
+obj-$(CONFIG_CLK_TEGRA114)		+= clk-tegra114.o
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 197074a..87520c6 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -744,7 +744,7 @@ const struct clk_ops tegra_clk_plle_ops = {
 	.enable = clk_plle_enable,
 };
 
-#ifdef CONFIG_ARCH_TEGRA_114_SOC
+#ifdef CONFIG_CLK_TEGRA114
 
 static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
 			   unsigned long parent_rate)
@@ -1339,7 +1339,7 @@ struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
 	return clk;
 }
 
-#ifdef CONFIG_ARCH_TEGRA_114_SOC
+#ifdef CONFIG_CLK_TEGRA114
 const struct clk_ops tegra_clk_pllxc_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_iddq_enable,
-- 
1.8.1.5
