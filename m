From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 30 Oct 2015 16:27:39 +0800
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
Message-ID: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement an ARM delay timer to be used for udelay(). This allows us to
skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
platforms. And after this patch, udelay() will be unaffected by CPU
frequency changes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/Kconfig           | 10 ++++++++++
 drivers/clocksource/dw_apb_timer_of.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a7726db..7b081805 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -29,6 +29,16 @@ config DW_APB_TIMER_OF
 	select DW_APB_TIMER
 	select CLKSRC_OF
 
+config DW_APB_TIMER_BASED_DELAY
+	bool "DW APB timer based delay"
+	depends on ARM && DW_APB_TIMER_OF
+	default n
+	help
+	  This option enables support for using the DW APB timer to
+	  implement timer-based delay. It is useful for skiping the
+	  delay loop calibration at boot on some platforms. And the
+	  udelay() will be unaffected by CPU frequency changes.
+
 config ROCKCHIP_TIMER
 	bool
 	select CLKSRC_OF
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index a19a3f6..4bab048 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <linux/delay.h>
 #include <linux/dw_apb_timer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -130,6 +131,17 @@ static void __init init_sched_clock(void)
 	sched_clock_register(read_sched_clock, 32, sched_rate);
 }
 
+#ifdef CONFIG_DW_APB_TIMER_BASED_DELAY
+static unsigned long dw_apb_delay_timer_read(void)
+{
+	return ~readl_relaxed(sched_io_base);
+}
+
+static struct delay_timer dw_apb_delay_timer = {
+	.read_current_timer = dw_apb_delay_timer_read,
+};
+#endif
+
 static int num_called;
 static void __init dw_apb_timer_init(struct device_node *timer)
 {
@@ -142,6 +154,10 @@ static void __init dw_apb_timer_init(struct device_node *timer)
 		pr_debug("%s: found clocksource timer\n", __func__);
 		add_clocksource(timer);
 		init_sched_clock();
+#ifdef CONFIG_DW_APB_TIMER_BASED_DELAY
+		dw_apb_delay_timer.freq = sched_rate;
+		register_current_timer_delay(&dw_apb_delay_timer);
+#endif
 		break;
 	default:
 		break;
-- 
2.6.2
