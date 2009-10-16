From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:38 -0700
Subject: [PATCH 34/46] davinci: DA850/OMAP-L138: add frequency scaling support
In-Reply-To: <1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Adds basic frequency scaling support for DA850/OMAP-L138.

Currently, frequency scaling only on PLL0 is supported. No scaling of PLL1
as yet.

Peripherals like MMC/SD which have a clock input synchronous with
ARM clock will not work well since the clock will change behind their backs.
Support for notification to such devices to adjust themselves to the
new frequency will be added in later patches. Current defconfigs keep
CPUFreq disabled so it will not affect normal operation.

The OPP defintions assume clock input of 24MHz to the SoC. This is inline
with hardcoding of input frequency in the <soc>.c files. At some point
this will need to move into board dependent code as new boards appear with
a different reference clock.

Tested on OMAP-L138 EVM with ondemand governer and a shell script to
vary processor load.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c              |  153 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 2 files changed, 155 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index a62863c..49dcc71 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/cpufreq.h>
 
 #include <asm/mach/map.h>
 
@@ -26,6 +27,7 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
+#include <mach/cpufreq.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -40,6 +42,11 @@
 #define DA850_REF_FREQ		24000000
 
 #define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
+#define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
+
+static int da850_set_armrate(struct clk *clk, unsigned long rate);
+static int da850_round_armrate(struct clk *clk, unsigned long rate);
+static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
 
 static struct pll_data pll0_data = {
 	.num		= 1,
@@ -57,6 +64,7 @@ static struct clk pll0_clk = {
 	.parent		= &ref_clk,
 	.pll_data	= &pll0_data,
 	.flags		= CLK_PLL,
+	.set_rate	= da850_set_pll0rate,
 };
 
 static struct clk pll0_aux_clk = {
@@ -283,6 +291,8 @@ static struct clk arm_clk = {
 	.parent		= &pll0_sysclk6,
 	.lpsc		= DA8XX_LPSC0_ARM,
 	.flags		= ALWAYS_ENABLED,
+	.set_rate	= da850_set_armrate,
+	.round_rate	= da850_round_armrate,
 };
 
 static struct clk rmii_clk = {
@@ -820,6 +830,149 @@ static void da850_set_async3_src(int pllnum)
 	__raw_writel(v, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG));
 }
 
+#ifdef CONFIG_CPU_FREQ
+/*
+ * Notes:
+ * According to the TRM, minimum PLLM results in maximum power savings.
+ * The OPP definitions below should keep the PLLM as low as possible.
+ *
+ * The output of the PLLM must be between 400 to 600 MHz.
+ * This rules out prediv of anything but divide-by-one for 24Mhz OSC input.
+ */
+struct da850_opp {
+	unsigned int	freq;	/* in KHz */
+	unsigned int	prediv;
+	unsigned int	mult;
+	unsigned int	postdiv;
+};
+
+static const struct da850_opp da850_opp_300 = {
+	.freq		= 300000,
+	.prediv		= 1,
+	.mult		= 25,
+	.postdiv	= 2,
+};
+
+static const struct da850_opp da850_opp_200 = {
+	.freq		= 200000,
+	.prediv		= 1,
+	.mult		= 25,
+	.postdiv	= 3,
+};
+
+static const struct da850_opp da850_opp_96 = {
+	.freq		= 96000,
+	.prediv		= 1,
+	.mult		= 20,
+	.postdiv	= 5,
+};
+
+#define OPP(freq) 		\
+	{				\
+		.index = (unsigned int) &da850_opp_##freq,	\
+		.frequency = freq * 1000, \
+	}
+
+static struct cpufreq_frequency_table da850_freq_table[] = {
+	OPP(300),
+	OPP(200),
+	OPP(96),
+	{
+		.index		= 0,
+		.frequency	= CPUFREQ_TABLE_END,
+	},
+};
+
+static struct davinci_cpufreq_config cpufreq_info = {
+	.freq_table = &da850_freq_table[0],
+};
+
+static struct platform_device da850_cpufreq_device = {
+	.name			= "cpufreq-davinci",
+	.dev = {
+		.platform_data	= &cpufreq_info,
+	},
+};
+
+int __init da850_register_cpufreq(void)
+{
+	return platform_device_register(&da850_cpufreq_device);
+}
+
+static int da850_round_armrate(struct clk *clk, unsigned long rate)
+{
+	int i, ret = 0, diff;
+	unsigned int best = (unsigned int) -1;
+
+	rate /= 1000; /* convert to kHz */
+
+	for (i = 0; da850_freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		diff = da850_freq_table[i].frequency - rate;
+		if (diff < 0)
+			diff = -diff;
+
+		if (diff < best) {
+			best = diff;
+			ret = da850_freq_table[i].frequency;
+		}
+	}
+
+	return ret * 1000;
+}
+
+static int da850_set_armrate(struct clk *clk, unsigned long index)
+{
+	struct clk *pllclk = &pll0_clk;
+
+	return clk_set_rate(pllclk, index);
+}
+
+static int da850_set_pll0rate(struct clk *clk, unsigned long index)
+{
+	unsigned int prediv, mult, postdiv;
+	struct da850_opp *opp;
+	struct pll_data *pll = clk->pll_data;
+	unsigned int v;
+	int ret;
+
+	opp = (struct da850_opp *) da850_freq_table[index].index;
+	prediv = opp->prediv;
+	mult = opp->mult;
+	postdiv = opp->postdiv;
+
+	/* Unlock writing to PLL registers */
+	v = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP0_REG));
+	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
+	__raw_writel(v, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP0_REG));
+
+	ret = davinci_set_pllrate(pll, prediv, mult, postdiv);
+	if (WARN_ON(ret))
+		return ret;
+
+	return 0;
+}
+#else
+int __init da850_register_cpufreq(void)
+{
+	return 0;
+}
+
+static int da850_set_armrate(struct clk *clk, unsigned long rate)
+{
+	return -EINVAL;
+}
+
+static int da850_set_pll0rate(struct clk *clk, unsigned long armrate)
+{
+	return -EINVAL;
+}
+
+static int da850_round_armrate(struct clk *clk, unsigned long rate)
+{
+	return clk->rate;
+}
+#endif
+
 static struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 3b75273..401bf93 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -37,6 +37,7 @@ extern void __iomem *da8xx_syscfg_base;
 #define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
 #define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
 #define DA8XX_JTAG_ID_REG	0x18
+#define DA8XX_CFGCHIP0_REG	0x17c
 #define DA8XX_CFGCHIP2_REG	0x184
 #define DA8XX_CFGCHIP3_REG	0x188
 
@@ -85,6 +86,7 @@ int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
 int da8xx_register_rtc(void);
+int da850_register_cpufreq(void);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.6.4.3
