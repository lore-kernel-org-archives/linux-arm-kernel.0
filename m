From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 19 Oct 2012 09:58:59 -0500
Subject: [PATCH V4 0/5] ARM: OMAP2+: Add device-tree support for timers
Message-ID: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device-tree support for the timers on OMAP2+ devices
including AM33xx. Based upon v3.7-rc1.

Testing:
1. I have booted tested this series on OMAP2420 H4, OMAP3430 Beagle, OMAP4430
   Panda and AM335x Beagle Bone with/without ...
   a). device-tree present
   b). CONFIG_OMAP_32K_TIMER set
   c). kernel boot parameter "clocksource=gp_timer" present
2. I have tested the all the timers (not used by the kernel as sys-timers) on
   OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda with/without device-tree with
   this series. The testing includes ...
   a. Configuring, starting a timer and checking the counter value is
      incrementing.
   b. Testing timer overflow interrupt when timer expires.
   c. Using different clock sources to operate the timer with.

V4 changes:
- Update timer binding to make "interrupt-parent" a required property. After
  reviewing the of_irq_find_parent() function it became apparent that it is
  much more efficient, in terms of parsing the DT blob, to have the interrupt
  parent defined in the timer binding than globally.

V3 changes:
- Removed definition "TIMER_PROP_ALWON" per Rob Herring's feedback
- Updated OMAP system timer (clock-events and clock-source) code so that
  HWMOD is NOT used for getting resource (memory and interrupt) information
  when device-tree is present.

V2 changes:
- Remove use of device-tree alias property
- Migrate OMAP timers to request timers by property instead of device ID
- Include OMAP2 support

Jon Hunter (5):
  ARM: dts: OMAP: Add timer nodes
  ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
  ARM: OMAP: Add function to request a timer by capability
  ARM: OMAP3: Add generic machine descriptor for boards with OMAP3 GP
    devices
  ARM: OMAP: Add DT support for timer driver

 .../devicetree/bindings/arm/omap/timer.txt         |   34 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++
 arch/arm/boot/dts/omap2.dtsi                       |   96 +++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    9 +
 arch/arm/boot/dts/omap2430.dtsi                    |    9 +
 arch/arm/boot/dts/omap3.dtsi                       |  107 ++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   97 +++++++++++
 arch/arm/mach-omap2/board-generic.c                |   17 ++
 arch/arm/mach-omap2/timer.c                        |  175 ++++++++++++++++----
 arch/arm/plat-omap/dmtimer.c                       |   93 ++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 11 files changed, 661 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

-- 
1.7.9.5
