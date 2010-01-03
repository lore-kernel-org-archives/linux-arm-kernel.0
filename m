From: joe@perches.com (Joe Perches)
Date: Sun, 03 Jan 2010 09:29:41 -0800
Subject: [PATCH] mach-osiris-dvs.c: Convert boolean bit tests to logical tests
Message-ID: <1262539781.1932.128.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit tests on booleans seem odd, logical tests more appropriate

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/arch/arm/mach-s3c2440/mach-osiris-dvs.c b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
index ad2792d..2367606 100644
--- a/arch/arm/mach-s3c2440/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
@@ -69,16 +69,14 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if ((old_dvs && !new_dvs) || (cur_dvs && !new_dvs)) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if ((!old_dvs && new_dvs) || (!cur_dvs && new_dvs)) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
