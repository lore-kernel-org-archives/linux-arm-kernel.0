From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 25 Oct 2016 14:47:38 -0700
Subject: [PATCH] ARM: davinci: enable PM for DT boot
Message-ID: <20161025214738.27744-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently system PM is only enabled for legacy (non-DT) boot.  Enable
for DT boot also.

Tested on da850-lcdk using "rtcwake -m mem -s5 -d rtc0".

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c9f7e9274aa8..a8089fa40d86 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -43,8 +43,26 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
+static struct davinci_pm_config da850_pm_pdata = {
+	.sleepcount = 128,
+};
+
+static struct platform_device da850_pm_device = {
+	.name           = "pm-davinci",
+	.dev = {
+		.platform_data	= &da850_pm_pdata,
+	},
+	.id             = -1,
+};
+
 static void __init da850_init_machine(void)
 {
+	int ret;
+
+	ret = da850_register_pm(&da850_pm_device);
+	if (ret)
+		pr_warn("%s: suspend registration failed: %d\n", __func__, ret);
+
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 }
 
-- 
2.9.3
