From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:39 -0700
Subject: [PATCH 35/46] davinci: DA850/OMAP-L138: add voltage regulation support
In-Reply-To: <1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
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
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds support for regulating the CVDD voltage for the
DA850/OMAP-L138 platform.

The CVDD min and max values for each OPP have been obtained from
section 5.2 "Recommended Operating Conditions" of SPRS586

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da850.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 49dcc71..0e1027e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/mach/map.h>
 
@@ -844,6 +845,8 @@ struct da850_opp {
 	unsigned int	prediv;
 	unsigned int	mult;
 	unsigned int	postdiv;
+	unsigned int	cvdd_min; /* in uV */
+	unsigned int	cvdd_max; /* in uV */
 };
 
 static const struct da850_opp da850_opp_300 = {
@@ -851,6 +854,8 @@ static const struct da850_opp da850_opp_300 = {
 	.prediv		= 1,
 	.mult		= 25,
 	.postdiv	= 2,
+	.cvdd_min	= 1140000,
+	.cvdd_max	= 1320000,
 };
 
 static const struct da850_opp da850_opp_200 = {
@@ -858,6 +863,8 @@ static const struct da850_opp da850_opp_200 = {
 	.prediv		= 1,
 	.mult		= 25,
 	.postdiv	= 3,
+	.cvdd_min	= 1050000,
+	.cvdd_max	= 1160000,
 };
 
 static const struct da850_opp da850_opp_96 = {
@@ -865,6 +872,8 @@ static const struct da850_opp da850_opp_96 = {
 	.prediv		= 1,
 	.mult		= 20,
 	.postdiv	= 5,
+	.cvdd_min	= 950000,
+	.cvdd_max	= 1050000,
 };
 
 #define OPP(freq) 		\
@@ -973,6 +982,40 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 }
 #endif
 
+#ifdef CONFIG_REGULATOR
+static struct regulator *cvdd;
+
+static int da850_set_voltage(unsigned int index)
+{
+	struct da850_opp *opp;
+
+	if (!cvdd)
+		return -ENODEV;
+
+	opp = (struct da850_opp *) da850_freq_table[index].index;
+
+	return regulator_set_voltage(cvdd, opp->cvdd_min, opp->cvdd_max);
+}
+
+static int __init da850_regulator_init(void)
+{
+	int ret = 0;
+
+	cvdd = regulator_get(NULL, "cvdd");
+	if (WARN(IS_ERR(cvdd), "Unable to obtain voltage regulator for CVDD;"
+					" voltage scaling unsupported\n")) {
+		ret = PTR_ERR(cvdd);
+		goto out;
+	}
+
+	cpufreq_info.set_voltage = da850_set_voltage;
+
+out:
+	return ret;
+}
+device_initcall(da850_regulator_init);
+#endif
+
 static struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
-- 
1.6.4.3
