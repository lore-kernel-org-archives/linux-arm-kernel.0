From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Dec 2013 23:17:58 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <87bo0clved.fsf@linaro.org>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org>
Message-ID: <20131219221758.GS14866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 19, 2013 at 07:20:42AM -0800, Kevin Hilman wrote:
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:
> 
> > Hello,
> >
> > the following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> >
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
> >
> > for you to fetch changes up to c24eb46490c8232c08c82cd591ba332284d257b2:
> >
> >   ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too (2013-12-07 23:31:28 +0100)
> >
> > I'd like to get these changes into 3.14-rc1, so it would be great if you
> > could take it into armsoc for some exposure into next.
> >
> > The kbuild test robot is happy with these changes, and I did several
> > build tests, too, so I don't expect any breakage.
> >
> > Merging this series will result in a few merge conflicts. I pushed a
> > branch dropmachtimexh-merged into my repository where you can see how I
> > resolved them merging in current next/master into my tag.
> 
> I pulled this into our arm-soc/to-build for build and boot testing and
> there was quite a few defconfigs that did not build (ignore the at91
> failures, those are my fault):
> 
>    http://lists.linaro.org/pipermail/kernel-build-reports/2013-December/001573.html
> 
> Looks like there are still several users of LATCH, which references CLOCK_TICK_RATE
> and is causing failures on lots of defconfigs.
darn, I missed these because my compile testing was done without
removing the dummy value of CLOCK_TICK_RATE in <asm/timex.h> and I then
relied on the 0day bot who obviously didn't build the critical configs.
:-\

The problems are fixed by:
 - "ARM: rpc: stop using <mach/timex.h>" which I just sent in this
   thread.
 - "ARM: u300: fix timekeeping when periodic mode is used", a patch I
   sent earlier and that Linus W. wanted to merge. It's not yet in
   -next. Maybe I can take it instead into this series? Linus?
 - The patch pasted below distributed on the respective commits.
   Apart from the netx patch these don't have any affected acks. Sascha,
   I assume I can keep your Ack?

I'll update my tree when I have feedback by Linus and Sascha.

Best regards
Uwe

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 967ddc2..20b62aa 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -45,6 +45,7 @@
 #include <asm/mach/time.h>
 
 #define IXP4XX_TIMER_FREQ 66666000
+#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, HZ)
 
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
@@ -521,7 +522,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		osrt = LATCH & ~IXP4XX_OST_RELOAD_MASK;
+		osrt = IXP4XX_LATCH & ~IXP4XX_OST_RELOAD_MASK;
  		opts = IXP4XX_OST_ENABLE;
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 0e29902..e234601 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -29,6 +29,7 @@
 #include <mach/netx-regs.h>
 
 #define NETX_CLOCK_FREQ 100000000
+#define NETX_LATCH DIV_ROUND_CLOSEST(NETX_CLOCK_FREQ, HZ)
 
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
@@ -43,7 +44,7 @@ static void netx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
+		writel(NETX_LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
 		tmode = NETX_GPIO_COUNTER_CTRL_RST_EN |
 			NETX_GPIO_COUNTER_CTRL_IRQ_EN |
 			NETX_GPIO_COUNTER_CTRL_RUN;
@@ -116,7 +117,7 @@ void __init netx_timer_init(void)
 	/* Reset the timer value to zero */
 	writel(0, NETX_GPIO_COUNTER_CURRENT(0));
 
-	writel(LATCH, NETX_GPIO_COUNTER_MAX(0));
+	writel(NETX_LATCH, NETX_GPIO_COUNTER_MAX(0));
 
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 83be0d6..b4e7f2d 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -21,6 +22,7 @@
 #include <mach/irqs.h>
 
 #define SA1100_CLOCK_FREQ 3686400
+#define SA1100_LATCH DIV_ROUND_CLOSEST(SA1100_CLOCK_FREQ, HZ)
 
 static u32 notrace sa1100_read_sched_clock(void)
 {
@@ -95,7 +97,7 @@ static void sa1100_timer_resume(struct clock_event_device *cedev)
 	/*
 	 * OSMR0 is the system timer: make sure OSCR is sufficiently behind
 	 */
-	writel_relaxed(OSMR0 - LATCH, OSCR);
+	writel_relaxed(OSMR0 - SA1100_LATCH, OSCR);
 }
 #else
 #define sa1100_timer_suspend NULL

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
