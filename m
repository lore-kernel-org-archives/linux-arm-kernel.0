From: joe@perches.com (Joe Perches)
Date: Fri, 12 Nov 2010 08:34:34 -0800
Subject: [PATCH V2] arch/arm/kernel/smp_twd.c: Correct local timer printk
	decimal output
In-Reply-To: <1289244455.29216.348.camel@Joe-Laptop>
References: <1289244455.29216.348.camel@Joe-Laptop>
Message-ID: <1289579674.6519.76.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer decimal place is shown incorrectly.
The %100 divisor needs to have 1 fewer 0.

Convert to unprefixed pr_<level>/pr_cont while at it.

Uncompiled/untested.

Signed-off-by: Joe Perches <joe@perches.com>
---
V2:

On Fri, 2010-11-12 at 16:12 +0000, Russell King - ARM Linux wrote:
> I'd rather avoid core code having KBUILD_MODNAME prefix it.
> The message is unique enough as is.

Use a local #define pr_fmt(fmt) fmt so if ever
a global change for pr_fmt is made, this won't
need to be changed.

 arch/arm/kernel/smp_twd.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 35882fb..4f90183 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -8,6 +8,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -89,7 +92,7 @@ static void __cpuinit twd_calibrate_rate(void)
 	 * the timer ticks
 	 */
 	if (twd_timer_rate == 0) {
-		printk(KERN_INFO "Calibrating local timer... ");
+		pr_info("Calibrating local timer... ");
 
 		/* Wait for a tick to start */
 		waitjiffies = get_jiffies_64() + 1;
@@ -113,8 +116,9 @@ static void __cpuinit twd_calibrate_rate(void)
 
 		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
 
-		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
-			(twd_timer_rate / 100000) % 100);
+		pr_cont("%lu.%02luMHz\n",
+			twd_timer_rate / 1000000,
+			(twd_timer_rate / 10000) % 100);
 	}
 
 	load = twd_timer_rate / HZ;
