From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Oct 2013 15:19:53 +0200
Subject: [PATCH] ARM: integrator: deactivate timer0 on the Integrator/CP
Message-ID: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a long-standing Integrator/CP regression from
commit 870e2928cf3368ca9b06bc925d0027b0a56bcd8e
"ARM: integrator-cp: convert use CLKSRC_OF for timer init"

When this code was introduced, the both aliases pointing the
system to use timer1 as primary (clocksource) and timer2
as secondary (clockevent) was ignored, and the system would
simply use the first two timers found as clocksource and
clockevent.

However this made the system timeline accelerate by a
factor x25, as it turns out that the way the clocking
actually works (totally undocumented and found after some
trial-and-error) is that timer0 runs @ 25MHz and timer1
and timer2 runs @ 1MHz. Presumably this divider setting
is a boot-on default and configurable albeit the way to
configure it is not documented.

So as a quick fix to the problem, let's mark timer0 as
disabled, so the code will chose timer1 and timer2 as it
used to.

This also deletes the two aliases for the primary and
secondary timer as they have been superceded by the
auto-selection

Cc: stable at vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: can you please apply this directly for fixes
if noone complains? Thanks.
---
 arch/arm/boot/dts/integratorcp.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index ff1aea0..72693a6 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -9,11 +9,6 @@
 	model = "ARM Integrator/CP";
 	compatible = "arm,integrator-cp";
 
-	aliases {
-		arm,timer-primary = &timer2;
-		arm,timer-secondary = &timer1;
-	};
-
 	chosen {
 		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
 	};
@@ -24,14 +19,18 @@
 	};
 
 	timer0: timer at 13000000 {
+		/* TIMER0 runs @ 25MHz */
 		compatible = "arm,integrator-cp-timer";
+		status = "disabled";
 	};
 
 	timer1: timer at 13000100 {
+		/* TIMER1 runs @ 1MHz */
 		compatible = "arm,integrator-cp-timer";
 	};
 
 	timer2: timer at 13000200 {
+		/* TIMER2 runs @ 1MHz */
 		compatible = "arm,integrator-cp-timer";
 	};
 
-- 
1.8.3.1
