From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Apr 2014 21:34 +0200
Subject: [PATCH v2 1/9] ARM: S3C24XX: cpufreq-utils: don't write raw values to
 MPLLCON when using ccf
In-Reply-To: <2104342.rkElQpXtvM@phil>
References: <2104342.rkElQpXtvM@phil>
Message-ID: <5855371.5GIoOu8EnE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx cpufreq driver needs to change the mpll speed and was doing
this by writing raw values from a translation table into the MPLLCON
register.

Change this to use a regular clk_set_rate call when using the common
clock framework and only write the raw value in the samsung_clock case.

To not needing to create additional infrastructure for this, the mpll clock
is requested at the first call to s3c2410_set_fvco().

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/cpufreq-utils.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
index 2a0aa56..d5e797b 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/cpufreq.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
@@ -60,5 +61,18 @@ void s3c2410_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
  */
 void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
 {
+#ifdef CONFIG_SAMSUNG_CLOCK
 	__raw_writel(cfg->pll.driver_data, S3C2410_MPLLCON);
+#endif
+
+#ifdef CONFIG_COMMON_CLK
+	static struct clk *mpll;
+
+	if (!mpll)
+		mpll = clk_get(NULL, "mpll")
+	if (IS_ERR(mpll))
+		return;
+
+	clk_set_rate(mpll, cfg->pll.frequency);
+#endif
 }
-- 
1.9.0
