From: marex@denx.de (Marek Vasut)
Date: Fri, 7 Sep 2018 21:46:09 +0200
Subject: SoCFPGA Arria10 timer hang
Message-ID: <f696454d-d81d-2b2d-d5b3-04f868c080be@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Latest upstream U-Boot (2018.09-rc3 and newer) properly handles reset on
the SoCFPGA Arria10. Since it uses only SP Timer 2, the remaining timers
(0, 1, 3) are left in reset state.

Linux, on the other hand, picks the last timer in DT, which is SP Timer
3, as a system timer. But since on Arria10 it doesn't unreset the timer
and depends on bootloader behavior, Linux just hangs very early on there.

The Arria10 DTSI lacks any SP Timer "reset" phandles, so the reset
controller cannot unreset those timers. Adding those reset phandles is
the first step to fix this problem.

Next one is drivers/clocksource/dw_apb_timer_of.c, which lacks support
for reset control at all. Adding reset controller support there is
another step.

But there is a problem, the reset controller driver comes up much later
than the timer. This is something I didn't have time to solve. If any of
you can continue fixing this, that'd be nice. I can share the patches I
have thus far too.

-- 
Best regards,
Marek Vasut
