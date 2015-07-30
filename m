From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:21:46 +0200
Subject: [PATCH 00/20] ARM: at91: Properly handle slow clock
Message-ID: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It was discovered that all the slow clock user were not properly claiming it.
This can end up in a system hang because the last registered user is releasing
it, and it gets disabled.

commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system hang")
was a workaround. This series is adding the slow clock to the necessary drivers
to avoid the issue and then removes that workaround.

The Documentation updates and DT patches should probably go through the AT91
tree this cycle to avoid breakage.

Then the other patches can go through each subsystem tree. They are trivial
enough to also go in this cycle.

The final clk patch depends on the other ones and may be taken for the next
cycle to avoid synchronization issues.

I've thrown in a cleanup for at91-reset as it avoids adding support for that
clock to the platform data initialization

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog at vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm at vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org

Alexandre Belloni (20):
  Documentation: dt: atmel-at91: add clocks to system timer, rstc and
    shdwc
  Documentation: watchdog: at91sam9_wdt: add clocks property
  Documentation: dt: rtc: at91rm9200: add clocks property
  ARM: at91/dt: at91rm9200: use slow clock where necessary
  ARM: at91/dt: at91sam9260: use slow clock where necessary
  ARM: at91/dt: at91sam9261: use slow clock where necessary
  ARM: at91/dt: at91sam9263: use slow clock where necessary
  ARM: at91/dt: at91sam9g45: use slow clock where necessary
  ARM: at91/dt: at91sam9n12: use slow clock where necessary
  ARM: at91/dt: at91sam9rl: use slow clock where necessary
  ARM: at91/dt: at91sam9x5: use slow clock where necessary
  ARM: at91/dt: sama5d3: use slow clock where necessary
  ARM: at91/dt: sama5d4: use slow clock where necessary
  rtc: at91rm9200: get and use slow clock
  watchdog: at91sam9: get and use slow clock
  power/reset: at91-reset: remove useless at91_reset_platform_probe()
  power/reset: at91-reset: get and use slow clock
  power/reset: at91-poweroff: get and use slow clock
  clocksource: atmel-st: get and use slow clock
  clk: at91: Revert "keep slow clk enabled to prevent system hang"

 .../devicetree/bindings/arm/atmel-at91.txt         | 11 +++--
 .../bindings/rtc/atmel,at91rm9200-rtc.txt          |  2 +
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  2 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |  2 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9261.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9263.dtsi                 |  3 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  4 ++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  4 ++
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  4 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  4 ++
 arch/arm/boot/dts/sama5d3.dtsi                     |  4 ++
 arch/arm/boot/dts/sama5d4.dtsi                     |  4 ++
 drivers/clk/at91/clk-slow.c                        | 27 -------------
 drivers/clocksource/timer-atmel-st.c               | 31 +++++++++-----
 drivers/power/reset/at91-poweroff.c                | 13 ++++++
 drivers/power/reset/at91-reset.c                   | 47 ++++++----------------
 drivers/rtc/rtc-at91rm9200.c                       | 27 +++++++++++--
 drivers/watchdog/at91sam9_wdt.c                    | 22 +++++++++-
 19 files changed, 138 insertions(+), 79 deletions(-)

-- 
2.1.4
