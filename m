From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:34 -0700
Subject: [PATCH 10/47] davinci: cpufreq: add support for keeping an additional
	clock constant
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

On OMAP-L138 SoC, some of the sysclks need not be at a fixed ratio
to CPU clock and can be kept at a relatively constant rate by
adjusting the PLLDIVn ratio even as cpufreq goes ahead and changes
the CPU clock.

This feature can be used to keep the EMIFA (PLL0 SYSCLK3) clock at a
constant rate so that the EMIF timings need not be re-programmed
whenever the CPU frequency changes.

This patch adds the required suppport to cpufreq driver.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/cpufreq.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index bc80142..343de73 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -34,6 +34,8 @@
 struct davinci_cpufreq {
 	struct device *dev;
 	struct clk *armclk;
+	struct clk *asyncclk;
+	unsigned long asyncrate;
 };
 static struct davinci_cpufreq cpufreq;
 
@@ -114,6 +116,12 @@ static int davinci_target(struct cpufreq_policy *policy,
 	if (ret)
 		goto out;
 
+	if (cpufreq.asyncclk) {
+		ret = clk_set_rate(cpufreq.asyncclk, cpufreq.asyncrate);
+		if (ret)
+			goto out;
+	}
+
 	/* if moving to lower freq, lower the voltage after lowering freq */
 	if (pdata->set_voltage && freqs.new < freqs.old)
 		pdata->set_voltage(idx);
@@ -191,6 +199,7 @@ static struct cpufreq_driver davinci_driver = {
 static int __init davinci_cpufreq_probe(struct platform_device *pdev)
 {
 	struct davinci_cpufreq_config *pdata = pdev->dev.platform_data;
+	struct clk *asyncclk;
 
 	if (!pdata)
 		return -EINVAL;
@@ -205,6 +214,12 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
 		return PTR_ERR(cpufreq.armclk);
 	}
 
+	asyncclk = clk_get(cpufreq.dev, "async");
+	if (!IS_ERR(asyncclk)) {
+		cpufreq.asyncclk = asyncclk;
+		cpufreq.asyncrate = clk_get_rate(asyncclk);
+	}
+
 	return cpufreq_register_driver(&davinci_driver);
 }
 
@@ -212,6 +227,9 @@ static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
 {
 	clk_put(cpufreq.armclk);
 
+	if (cpufreq.asyncclk)
+		clk_put(cpufreq.asyncclk);
+
 	return cpufreq_unregister_driver(&davinci_driver);
 }
 
-- 
1.7.2.1
