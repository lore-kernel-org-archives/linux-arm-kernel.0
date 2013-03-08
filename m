From: jhovold@gmail.com (Johan Hovold)
Date: Fri,  8 Mar 2013 13:51:40 +0100
Subject: [PATCH 0/3] ARM: at91: fix hanged boot
Message-ID: <1362747103-21445-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix a few severe issues affecting most AT91 SOCs where
boot can hang after a non-general reset, and where the only way to get
the system booting again is to do a general reset -- something which
could require physically removing any backup battery.

The problems stem from the fact that the RTC and RTT-peripherals are
powered by backup power (VDDBU) and are not reset on wake-up, user,
watchdog or software reset. Consequently, RTC and RTT-alarms and their
interrupts may be enabled at boot, leading to a system lock-up when an
interrupt arrives on the shared system-interrupt line before the
appropriate handler (e.g. RTC-driver) has been installed.

The easiest way to trigger this is to simply wake up from an RTC-alarm
on at91sam9g45. The RTC-driver currently does not disable interrupts at
shutdown so even after a clean shut-down the system will always hang
after waking up.

The first patch fixes this very general case of RTC-wake up after a
clean shutdown in the RTC-driver and is marked for stable as it is
perfectly straight-forward. [ Note that the other, RTT-based, AT91
RTC-driver already disables its interrupts at shutdown. ]

The more general problem can be triggered, for example, by doing a
user-reset while updating the RTC-time or if an RTC or RTT-alarm goes
off after a non-clean shutdown.

To fix this I propose that arch-code should mask the relevant interrupts
at early boot, and this is what the third patch does. To access the
RTC-registers I choose to revert a recent patch that moved the register
definitions to drivers/rtc.

Arguably, the interrupts could also be disabled in bootloaders, but I
strongly suggest fixing it in the kernel once and for all. By adding a
new, mandatory AT91 SOC-initialiser (rather extending init) it will not
be overlooked when adding new SOCs either.

The patches have been tested on at91sam9263 and at91sam9g45, and
compile-tested for the other SOCs.

Johan


Johan Hovold (3):
  ARM: at91/rtc: fix boot after RTC wake-up
  Revert "arm: at91: move at91rm9200 rtc header in drivers/rtc"
  ARM: at91: fix hanged boot

 arch/arm/mach-at91/at91rm9200.c               |  9 ++++
 arch/arm/mach-at91/at91sam9260.c              |  6 +++
 arch/arm/mach-at91/at91sam9261.c              |  6 +++
 arch/arm/mach-at91/at91sam9263.c              |  7 +++
 arch/arm/mach-at91/at91sam9g45.c              |  7 +++
 arch/arm/mach-at91/at91sam9n12.c              |  6 +++
 arch/arm/mach-at91/at91sam9rl.c               |  7 +++
 arch/arm/mach-at91/at91sam9x5.c               |  6 +++
 arch/arm/mach-at91/generic.h                  |  2 +
 arch/arm/mach-at91/include/mach/at91_rtc.h    | 75 +++++++++++++++++++++++++++
 arch/arm/mach-at91/include/mach/at91sam9n12.h |  5 ++
 arch/arm/mach-at91/include/mach/at91sam9x5.h  |  5 ++
 arch/arm/mach-at91/setup.c                    | 31 +++++++++++
 arch/arm/mach-at91/soc.h                      |  1 +
 drivers/rtc/rtc-at91rm9200.c                  | 11 +++-
 drivers/rtc/rtc-at91rm9200.h                  | 75 ---------------------------
 16 files changed, 183 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_rtc.h
 delete mode 100644 drivers/rtc/rtc-at91rm9200.h

-- 
1.8.1.1
