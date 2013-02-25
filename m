From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Feb 2013 17:30:17 +0100
Subject: [PATCH 2/4] ARM: imx: Cleanup cpufreq i.MX5
In-Reply-To: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
References: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1361809819-24383-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build only if cpufreq driver is enabled.
Cleanup cpu_op files.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/Makefile      | 5 ++++-
 arch/arm/mach-imx/cpu_op-mx51.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3118ed4..288e748 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -15,7 +15,10 @@ obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
 
 imx5-pm-$(CONFIG_PM) += pm-imx5.o
-obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o $(imx5-pm-y) cpu_op-mx51.o
+obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clk-imx51-imx53.o ehci-imx5.o $(imx5-pm-y)
+ifdef CONFIG_SOC_IMX5
+obj-$(CONFIG_CPU_FREQ_IMX) += cpu_op-mx51.o
+endif
 
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
 			    clk-pfd.o clk-busy.o clk.o
diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
index b9ef692..a7f28fd 100644
--- a/arch/arm/mach-imx/cpu_op-mx51.c
+++ b/arch/arm/mach-imx/cpu_op-mx51.c
@@ -19,9 +19,11 @@
 
 static struct cpu_op mx51_cpu_op[] = {
 	{
-	.cpu_rate = 160000000,},
+		.cpu_rate = 160000000,
+	},
 	{
-	.cpu_rate = 800000000,},
+		.cpu_rate = 800000000,
+	},
 };
 
 struct cpu_op *mx51_get_cpu_op(int *op)
-- 
1.8.1.2
