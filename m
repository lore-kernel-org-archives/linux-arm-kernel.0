From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 5 Nov 2015 10:32:06 +0800
Subject: [PATCH v3] clocksource/drivers/dw_apb_timer_of: Implement ARM delay
 timer
Message-ID: <1446690726-2024-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement an ARM delay timer to be used for udelay(). This allows us to
skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
platforms. And after this patch, udelay() will be unaffected by CPU
frequency changes.

Note: Although in case there are several possible delay timers, we may
not select the "best" delay timer. Take one Marvell Berlin platform for
example: we have arch timer and dw-apb timer. The arch timer freq is
25MHZ while the dw-apb timer freq is 100MHZ, current selection would
choose the dw-apb timer. But the dw apb timer is on the APB bus while
arch timer sits in CPU, the cost of accessing the apb timer is higher
than the arch timer. We could introduce "rating" concept to delay
timer, but this approach "brings a lot of complexity and workarounds
in the code for a small benefit" as pointed out by Daniel. 

Later, Arnd pointed out "However, we could argue that this actually
doesn't matter at all, because the entire point of the ndelay()/
udelay()/mdelay() functions is to waste CPU cycles doing not much at
all, so we can just as well waste them reading the timer register
than spinning on the CPU reading the arch timer more often.", so we
just simply register the dw apb base delay timer.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v2:
 - remove the patch to add rating support for register_current_timer_delay()
 - remove the patch to set arch_delay_timer rating
 - remove "rating" in dw apb timer

Since v1:
 - add one patch to let register_current_timer_delay() to choose the the
   highest rating delay timer
 - add one patch to set arch_delay_timer rating as 400
 - remove CONFIG_DW_APB_TIMER_BASED_DELAY option, use CONFIG_ARM instead.
 - change the commit msg as "clocksource/drivers/abc: Foo...."

 drivers/clocksource/dw_apb_timer_of.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index a19a3f6..860843c 100644
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
 
+#ifdef CONFIG_ARM
+static unsigned long dw_apb_delay_timer_read(void)
+{
+	return ~readl_relaxed(sched_io_base);
+}
+
+static struct delay_timer dw_apb_delay_timer = {
+	.read_current_timer	= dw_apb_delay_timer_read,
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
+#ifdef CONFIG_ARM
+		dw_apb_delay_timer.freq = sched_rate;
+		register_current_timer_delay(&dw_apb_delay_timer);
+#endif
 		break;
 	default:
 		break;
-- 
2.6.2
