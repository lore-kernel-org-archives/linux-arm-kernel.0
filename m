From: andrey.krieger.utkin@gmail.com (Andrey Utkin)
Date: Thu, 10 Jul 2014 15:47:30 +0300
Subject: [PATCH] arch/arm/mach-s3c24xx/mach-osiris-dvs.c: use "&&" (not "&")
 with bool operands
Message-ID: <1404996450-4617-1-git-send-email-andrey.krieger.utkin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue was discovered by static analysis. Bitwise AND ("&") was used
in logical expressions with operands having "bool" type. Replaced
bitwise AND operators with logical AND.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=79781
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 33afb91..b2d620d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -70,16 +70,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if (old_dvs && !new_dvs ||
+		    cur_dvs && !new_dvs) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if (!old_dvs && new_dvs ||
+		    !cur_dvs && new_dvs) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
-- 
1.8.3.2
