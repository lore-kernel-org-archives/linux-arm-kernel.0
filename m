From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Oct 2013 18:14:49 +0300
Subject: [PATCH v2 6/7] clk: tegra124: add wait_for_reset and disable_clock
 for tegra_cpu_car_ops
In-Reply-To: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1381850098-12357-7-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

Hook the functions for CPU hotplug support. After the CPU is hot
unplugged, the flow controller will handle to clock gate the CPU clock.
But still need to implement an empty function to avoid warning message.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 004a0c9..22fce42 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -114,6 +114,9 @@
 #define UTMIPLL_HW_PWRDN_CFG0_IDDQ_OVERRIDE	BIT(1)
 #define UTMIPLL_HW_PWRDN_CFG0_IDDQ_SWCTL	BIT(0)
 
+/* Tegra CPU clock and reset control regs */
+#define CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
+
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
@@ -1289,6 +1292,27 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
 
 }
 
+/* Tegra124 CPU clock and reset control functions */
+static void tegra124_wait_cpu_in_reset(u32 cpu)
+{
+	unsigned int reg;
+
+	do {
+		reg = readl(clk_base + CLK_RST_CONTROLLER_CPU_CMPLX_STATUS);
+		cpu_relax();
+	} while (!(reg & (1 << cpu)));  /* check CPU been reset or not */
+}
+
+static void tegra124_disable_cpu_clock(u32 cpu)
+{
+	/* flow controller would take care in the power sequence. */
+}
+
+static struct tegra_cpu_car_ops tegra124_cpu_car_ops = {
+	.wait_for_reset	= tegra124_wait_cpu_in_reset,
+	.disable_clock	= tegra124_disable_cpu_clock,
+};
+
 static const struct of_device_id pmc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra124-pmc" },
 	{},
@@ -1373,5 +1397,7 @@ static void __init tegra124_clock_init(struct device_node *np)
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra124_clock_apply_init_table;
+
+	tegra_cpu_car_ops = &tegra124_cpu_car_ops;
 }
 CLK_OF_DECLARE(tegra124, "nvidia,tegra124-car", tegra124_clock_init);
-- 
1.7.7.rc0.72.g4b5ea.dirty
