From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 31 May 2017 08:14:53 +0200
Subject: [PATCH v2 2/6] ARM: imx6: register pm_power_off handler if "fsl,
 pmic_stby_poweroff" is set
In-Reply-To: <20170531061457.23744-1-o.rempel@pengutronix.de>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
Message-ID: <20170531061457.23744-3-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the Freescale recommended sequences for power off with external
PMIC is the following:
...
3.  SoC is programming PMIC for power off when standby is asserted.
4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.

See:
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
page 5083

This patch implements step 4. of this sequence.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-imx/pm-imx6.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index e61b1d1027e1..fd7b95f340e5 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -27,6 +27,8 @@
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/tlb.h>
+#include <linux/kallsyms.h>
+#include <linux/regulator/machine.h>
 
 #include "common.h"
 #include "hardware.h"
@@ -602,6 +604,31 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 				   IMX6Q_GPR1_GINT);
 }
 
+static void imx6_pm_poweroff(void)
+{
+	imx6_set_lpm(STOP_POWER_OFF);
+	cpu_suspend(0, imx6q_suspend_finish);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to poweroff system\n");
+}
+
+static int imx6_pm_poweroff_probe(void)
+{
+	char symname[KSYM_NAME_LEN];
+
+	if (pm_power_off) {
+		lookup_symbol_name((ulong)pm_power_off, symname);
+		pr_warn("%s: pm_power_off already claimed  %p %s!\n",
+			__func__, pm_power_off, symname);
+		return -EBUSY;
+	}
+
+	pm_power_off = imx6_pm_poweroff;
+	return 0;
+}
+
 void __init imx6_pm_ccm_init(const char *ccm_compat)
 {
 	struct device_node *np;
@@ -618,6 +645,9 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
 	val = readl_relaxed(ccm_base + CLPCR);
 	val &= ~BM_CLPCR_LPM;
 	writel_relaxed(val, ccm_base + CLPCR);
+
+	if (of_property_read_bool(np, "fsl,pmic_stby_poweroff"))
+		imx6_pm_poweroff_probe();
 }
 
 void __init imx6q_pm_init(void)
-- 
2.11.0
