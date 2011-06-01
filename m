From: tim.sander@hbm.com (Tim Sander)
Date: Wed, 1 Jun 2011 15:29:37 +0200
Subject: [PATCH 1/1] fix epit sched clock plat-mxc 2.6.39
Message-ID: <201106011529.37958.tim.sander@hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

The attached patch fixes booting the 2.6.39 kernel with epit timer enabled.
2.6.39 introduces "HAVE_SCHED_CLOCK" for ARCH_MXC. This breaks using 
MXC_USE_EPIT and the system just hangs on boot with no message at all.

The patch below fixes this problem against 2.6.39. The new and shiny 3.0-rc1 has
also a problem with MXC_USE_EPIT on i.mx35 (which means it hangs on boot).
Any hints how to add the functionality of this patch to the more generic aproach 
are very welcome. The change introduced in 3.0-rc1 which conlicts with this patch is:
bfe45e0be88d8a2e408226d473bff60da4a97d1f

Signed-off-by: Tim Sander <tim.sander@hbm.com>
---
 arch/arm/plat-mxc/epit.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index d69d343..17a7c0d 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -53,6 +53,7 @@
 
 #include <mach/hardware.h>
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 #include <mach/common.h>
 
 static struct clock_event_device clockevent_epit;
@@ -88,18 +89,33 @@ static cycle_t epit_read(struct clocksource *cs)
        return 0 - __raw_readl(timer_base + EPITCNR);
 }
 
+static cycle_t dummy_get_cycles(struct clocksource *cs)
+{
+           return 0;
+}
+
 static struct clocksource clocksource_epit = {
        .name           = "epit",
        .rating         = 200,
-       .read           = epit_read,
+       .read           = dummy_get_cycles,
        .mask           = CLOCKSOURCE_MASK(32),
        .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static DEFINE_CLOCK_DATA(cd);
+
+static void notrace epit_update_sched_clock(void)
+{
+       cycle_t cyc = clocksource_epit.read(&clocksource_epit);
+       update_sched_clock(&cd, cyc, (u32)~0);
+}
+
 static int __init epit_clocksource_init(struct clk *timer_clk)
 {
        unsigned int c = clk_get_rate(timer_clk);
 
+       clocksource_epit.read = epit_read;
+       init_sched_clock(&cd,epit_update_sched_clock, 32, c);
        clocksource_register_hz(&clocksource_epit, c);
 
        return 0;
-- 
1.7.0.4

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
