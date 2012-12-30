From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:07 -0600
Subject: [PATCH 6/6] ARM: highbank: save and restore L2 cache and GIC on
 suspend
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This fixes suspend to RAM adding necessary save and restore of L2 and GIC.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/pm.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 0f4ffd6..04eddb4 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -14,10 +14,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/suspend.h>
 
+#include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 
@@ -26,16 +28,31 @@
 
 static int highbank_suspend_finish(unsigned long val)
 {
+	outer_flush_all();
+	outer_disable();
+
+	highbank_set_pwr_suspend();
+
 	cpu_do_idle();
+
+	highbank_clear_pwr_request();
 	return 0;
 }
 
 static int highbank_pm_enter(suspend_state_t state)
 {
-	highbank_set_pwr_suspend();
+	cpu_pm_enter();
+	cpu_cluster_pm_enter();
+
 	highbank_set_cpu_jump(0, cpu_resume);
 	cpu_suspend(0, highbank_suspend_finish);
 
+	cpu_cluster_pm_exit();
+	cpu_pm_exit();
+
+	highbank_smc1(0x102, 0x1);
+	if (scu_base_addr)
+		scu_enable(scu_base_addr);
 	return 0;
 }
 
-- 
1.7.10.4
