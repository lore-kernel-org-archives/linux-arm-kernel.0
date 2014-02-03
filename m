From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  3 Feb 2014 11:31:19 +0100
Subject: [PATCH] [RFC] ARM: ixp4xx: fix timer latch calculation
In-Reply-To: <20140113194259.GG29475@pengutronix.de>
References: <20140113194259.GG29475@pengutronix.de>
Message-ID: <1391423479-10007-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit f0402f9b4711 ("ARM: ixp4xx: stop using <mach/timex.h>")
I didn't intend to implement a functional change, but as Olof noticed I
failed---at least a bit. Before this commit the following was used to
determine the latch value used:

	#define IXP4XX_TIMER_FREQ 66666000
	#define CLOCK_TICK_RATE \
		(((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
	#define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)

The complicated calculation was done "b/c the timer register ignores the
bottom 2 bits of the LATCH value." With HZ=100 CLOCK_TICK_RATE used to
calculate to 66666100 and so LATCH to 666661. In ixp4xx_set_mode the
term

	LATCH & ~IXP4XX_OST_RELOAD_MASK

was used to write to the relevant register (with IXP4XX_OST_RELOAD_MASK
being 3) and so effectively 666660 was used.

In commit f0402f9b4711 I translated that to:

	#define IXP4XX_TIMER_FREQ 66666000
	#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, HZ)

which results in the same register writes, but still doesn't bear in
mind that the two least significant bits cannot be specified (which is
relevant only when HZ or IXP4XX_TIMER_FREQ are changed).

Instead of reverting back to the old approach use a more obvious and
also more correct way to calculate LATCH. (Regarding the more
correct claim: With IXP4XX_TIMER_FREQ == 66665999, the old code resulted
in LATCH = 666657 corresponding to a cycle time of 0.009999940149400597
seconds (error: -6.0e-8 s) while the new approach results in LATCH =
666660 and so a cycle time of 0.010000000150001503 seconds
(error: 1.5e-10 s).)

Fixes: f0402f9b4711 ("ARM: ixp4xx: stop using <mach/timex.h>")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't hear anything back from the ixp4xx maintainers, I didn't find a
reference manual and I don't have an ixp4xx machine to test this patch.
Still I'm confident it works as expected and results in a more exact
clock calculation than both before and after my patch.

Olof requested this to be a seperate patch to not need to reverify the
rest of the series. Does this make the series ready to be merged for
3.15 now? If so, should I send a new pull request with this patch
applied on top of the old request or do you handle that yourself?

Best regards
Uwe

 arch/arm/mach-ixp4xx/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 20b62aa30086..37e6cdac1642 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -45,7 +45,15 @@
 #include <asm/mach/time.h>
 
 #define IXP4XX_TIMER_FREQ 66666000
-#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, HZ)
+
+/*
+ * The timer register doesn't allow to specify the two least significant bits of
+ * the timeout value and assumes them being zero. So make sure IXP4XX_LATCH is
+ * the best value with the two least significant bits unset.
+ */
+#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, \
+				       (IXP4XX_OST_RELOAD_MASK + 1) * HZ) * \
+			(IXP4XX_OST_RELOAD_MASK + 1)
 
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
-- 
1.8.5.3
