From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Oct 2013 14:07:38 +0100
Subject: [PATCH v2 0/5] Allwinner SoCs High Speed Timer support
Message-ID: <1382706463-3892-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here is a few patches adding support for the High Speed Timers running on the
Allwinner SoCs.

These timers are 64 bits timers running at a much higher speed than the timers
used for now on these SoCs, since they are no longer wired to the 24MHz
oscillator, but to the AHB clock.

This HS timers are actually found in all the supported SoCs but the A10.
However, the A20 and A31 come with 4 of these high speed timers, while the A10s
and A13 only have two, hence why we introduce two different compatibles.

The A31 is not using these for now, as its timers are asserted in reset by a
reset controller that first need to gain some support in the kernel first, but
that's for another patchset.

Thanks,
Maxime

Changes from v1:
  - Reported correctly the minimum ticks we can set
  - No longer use the HS timers as the default timers in the system
  - Removed the IRQF_DISABLED interrupt flag
  - Filled the irq clock_event_device field
  - Changed the cpumask to cpu_possible_mask

Maxime Ripard (5):
  clocksource: sun4i: Increase a bit the clock event and sources rating
  clocksource: Add Allwinner SoCs HS timers driver
  ARM: sun5i: a10s: Add support for the High Speed Timers
  ARM: sun5i: a13: Add support for the High Speed Timers
  ARM: sun7i: a20: Add support for the High Speed Timers

 .../bindings/timer/allwinner,sun5i-a13-hstimer.txt |  22 +++
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   7 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   7 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  10 ++
 arch/arm/mach-sunxi/Kconfig                        |   1 +
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/sun4i_timer.c                  |   4 +-
 drivers/clocksource/timer-sun5i.c                  | 192 +++++++++++++++++++++
 9 files changed, 246 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
 create mode 100644 drivers/clocksource/timer-sun5i.c

-- 
1.8.4
