From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 16:55:21 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <20120105162650.GY11810@n2100.arm.linux.org.uk>
References: <20120104214748.GH11810@n2100.arm.linux.org.uk>
 <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
 <4F0584B5.60908@arm.com>
 <CAMQu2gxuBNRWYKyKRdzvv_m49DyLoODVbC=rKDHDAMTnxe+6+A@mail.gmail.com>
 <4F058744.4030503@arm.com> <20120105112602.GQ11810@n2100.arm.linux.org.uk>
 <4F058B1C.2070109@arm.com> <20120105121026.GS11810@n2100.arm.linux.org.uk>
 <4F05CC0D.6090101@arm.com> <20120105162650.GY11810@n2100.arm.linux.org.uk>
Message-ID: <20120105165521.GB11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 04:26:50PM +0000, Russell King - ARM Linux wrote:
> But... it's not quite that simple because platforms need to intercept the
> local_timer_setup() call to do platform specific things - such as finding
> the twd base, and setting the twd IRQ.  That can be solved by moving
> that out of platform code (why is it there in the first place?) into
> smp_twd.c, and providing twd_local_timer_dt.

And that's something we really should do anyway - we already have two
implementations which are virtually identical to each other for no real
reason other than people like to mess around in their own platform stuff
rather than solving problems at higher levels.

So, I'll queue this patch after the next merge window.

Note: there's no need for that WARN_ON and subsequent oops in each of
these setup functions - it can return an error, in which case we'll
fall back to a broadcasted tick for the CPU.

8<---------
From: Russell King <rmk+kernel@arm.linux.org.uk>
ARM: TWD: Move DT code into smp_twd.c

Rather than have each platform implement their own DT veneer to discover
the base address and IRQ for their TWD, move this code into the TWD
driver itself.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_twd.h      |    1 +
 arch/arm/kernel/smp_twd.c           |   21 +++++++++++++++++++++
 arch/arm/mach-highbank/localtimer.c |   14 +-------------
 arch/arm/mach-imx/localtimer.c      |   14 +-------------
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index ef9ffba9..855f58e 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -23,6 +23,7 @@ struct clock_event_device;
 extern void __iomem *twd_base;
 
 void twd_timer_setup(struct clock_event_device *);
+int twd_timer_setup_dt(struct clock_event_device *);
 void twd_timer_stop(struct clock_event_device *);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index c8e9385..f43f039 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -20,6 +20,9 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
@@ -266,3 +269,21 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 					0xf, 0xffffffff);
 	enable_percpu_irq(clk->irq, 0);
 }
+
+int __cpuinit twd_timer_setup_dt(struct clock_event_device *clk)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
+	if (np) {
+		if (!twd_base) {
+			twd_base = of_iomap(np, 0);
+			if (!twd_base)
+				return -ENOMEM;
+		}
+		evt->irq = irq_of_parse_and_map(np, 0);
+	}
+	twd_timer_setup(evt);
+
+	return 0;
+}
diff --git a/arch/arm/mach-highbank/localtimer.c b/arch/arm/mach-highbank/localtimer.c
index 5a00e79..1b6c0d1 100644
--- a/arch/arm/mach-highbank/localtimer.c
+++ b/arch/arm/mach-highbank/localtimer.c
@@ -16,9 +16,6 @@
  */
 #include <linux/init.h>
 #include <linux/clockchips.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 
 #include <asm/smp_twd.h>
 
@@ -27,14 +24,5 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
-	if (!twd_base) {
-		twd_base = of_iomap(np, 0);
-		WARN_ON(!twd_base);
-	}
-	evt->irq = irq_of_parse_and_map(np, 0);
-	twd_timer_setup(evt);
-	return 0;
+	return twd_timer_setup_dt(evt);
 }
diff --git a/arch/arm/mach-imx/localtimer.c b/arch/arm/mach-imx/localtimer.c
index 3a16351..1252c22 100644
--- a/arch/arm/mach-imx/localtimer.c
+++ b/arch/arm/mach-imx/localtimer.c
@@ -12,8 +12,6 @@
 
 #include <linux/init.h>
 #include <linux/clockchips.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <asm/smp_twd.h>
 
 /*
@@ -21,15 +19,5 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
-	if (!twd_base) {
-		twd_base = of_iomap(np, 0);
-		WARN_ON(!twd_base);
-	}
-	evt->irq = irq_of_parse_and_map(np, 0);
-	twd_timer_setup(evt);
-
-	return 0;
+	return twd_timer_setup_dt(evt);
 }
