From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 May 2017 16:05:34 +0200
Subject: [PATCH 0/8] clocksource: Generalize Faraday timer
Message-ID: <20170517140542.20016-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that the Moxa is using a Faraday IP timer named
FTTMR010. This is also what Aspeed's derivative is based on.

This series attempts to merge these two drivers into one to
get lesser code to maintain. Also it incidentally adds a
sched_clock() implementation to the Moxa and Aspeed, which
is nice.

The patches can also be grabbed from here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=fttmr010

Future ideas include supporting the optional EXTCLK
(32kHz clock) and delay timers. This will then get available
on all three supported platforms = big win.

The patches can be applied as soon as Jonas Jensen and Joel
Stanley says they work for them.

I have chosen to work on this body of code (rather than the
Moxart code) as it is derived from code originally posted
by Faraday themselves here:
https://lwn.net/Articles/447919/

I hope we can get this to work!

Linus Walleij (8):
  clocksource/drivers/fttmr010: Fix the clock handling
  clocksource/drivers/fttmr010: Merge FTTMR010 DT bindings
  clocksource/drivers/fttmr010: Drop Gemini specifics
  clocksource/drivers/fttmr010: Use state container
  clocksource/drivers/fttmr010: Switch to use bitops
  clocksource/drivers/fttmr010: Switch to use TIMER2 src
  clocksource/drivers/fttmr010: Merge Moxa into FTTMR010
  ARM: dts: augment Moxa and Aspeed DTS for FTTMR010

 .../devicetree/bindings/timer/faraday,fttmr010.txt |   4 +-
 .../bindings/timer/moxa,moxart-timer.txt           |  19 --
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   7 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   6 +-
 arch/arm/boot/dts/moxart.dtsi                      |   3 +-
 arch/arm/mach-aspeed/Kconfig                       |   2 +-
 arch/arm/mach-moxart/Kconfig                       |   2 +-
 drivers/clocksource/Kconfig                        |   7 -
 drivers/clocksource/Makefile                       |   1 -
 drivers/clocksource/moxart_timer.c                 | 256 --------------
 drivers/clocksource/timer-fttmr010.c               | 377 +++++++++++----------
 11 files changed, 214 insertions(+), 470 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
 delete mode 100644 drivers/clocksource/moxart_timer.c

-- 
2.9.3
