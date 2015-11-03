From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Nov 2015 22:28:37 +0800
Subject: [PATCH v2 3/3] clocksource/drivers/dw_apb_timer_of: Implement ARM
 delay timer
In-Reply-To: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
References: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
Message-ID: <1446560917-6318-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement an ARM delay timer to be used for udelay(). This allows us to
skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
platforms. And after this patch, udelay() will be unaffected by CPU
frequency changes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/dw_apb_timer_of.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index a19a3f6..7a6c3bf 100644
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
@@ -130,6 +131,18 @@ static void __init init_sched_clock(void)
 	sched_clock_register(read_sched_clock, 32, sched_rate);
 }
 
+#ifdef CONFIG_ARM
+static unsigned long dw_apb_delay_timer_read(void)
+{
+	return ~readl_relaxed(sched_io_base);
+}
+
+static struct delay_timer dw_apb_delay_timer = {
+	.read_current_timer	= dw_apb_delay_timer_read,
+	.rating			= 300,
+};
+#endif
+
 static int num_called;
 static void __init dw_apb_timer_init(struct device_node *timer)
 {
@@ -142,6 +155,10 @@ static void __init dw_apb_timer_init(struct device_node *timer)
 		pr_debug("%s: found clocksource timer\n", __func__);
 		add_clocksource(timer);
 		init_sched_clock();
+#ifdef CONFIG_ARM
+		dw_apb_delay_timer.freq = sched_rate;
+		register_current_timer_delay(&dw_apb_delay_timer);
+#endif
 		break;
 	default:
 		break;
-- 
2.6.2
