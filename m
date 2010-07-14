From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jul 2010 17:16:09 +0200
Subject: [PATCH] arm: fix mach-versatile booting in qemu
Message-ID: <201007141716.09384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The versatile platform has not been able to boot in qemu since 2.6.34-rc2,
because e388771 "ARM: Realview/Versatile: separate out common SP804
timer code" changed the behavior of the versatile_set_mode function.

This restores the original way it worked until 2.6.34-rc1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this with git-bisect. I do not know wether the old behavior
that this reverts to is sensible, but it's how both versatile and
realview have been doing it since they first started using clockevents.

I also don't know if the same problem exists on actual versatile
hardware or if it's really a qemu bug.

Please apply in combination with common sense. If it's correct, do
we also want the same change in 2.6.34.x-stable?

--- a/arch/arm/plat-versatile/timer-sp.c
+++ b/arch/arm/plat-versatile/timer-sp.c
@@ -90,8 +90,6 @@ static void sp804_set_mode(enum clock_event_mode mode,
 {
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
 
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
@@ -106,6 +104,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	default:
+		ctrl = 0;
 		break;
 	}
 
