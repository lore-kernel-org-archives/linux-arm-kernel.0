From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 8 Mar 2016 09:41:57 +0800
Subject: [PATCH v4 0/5] ARM: at91: pm: add ULP1 mode support
Message-ID: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULP1 (Ultra Low-power mode 1) is introduced by SAMA5D2.

In order to achieve the lowest power consumption, in the ULP1 mode,
all the clocks are shut off, inclusive the embedded 12MHz RC oscillator.

The fast startup signal is used as a wake up source for ULP1 mode.
As soon as the wake up event is asserted, the embedded 12MHz RC
oscillator restarts automatically, which fast startup signal
to trigger the PMC to wake up the system from the ULP1 mode can be
configured via DT.

Changes in v4:
 - add Acked-by tag.
 - add fast_restart node to the DT file.

Changes in v3:
 - use 0 and 1, not string, to define the trigger active polarity.
 - update the property description.

Changes in v2:
 - fix label pm_exit to ulp_exit.
 - shorten the pmc-fast-startup property's name.
 - use the value property, instead of bool property for high
   or low triggered.
 - change the property name and property description.

Wenyou Yang (5):
  ARM: at91: pm: create a separate procedure for the ULP0 mode
  ARM: at91: pm: add ULP1 mode support
  ARM: at91: pm: configure PMC fast startup signals
  Documentation: atmel-pmc: add DT bindings for fast startup
  ARM: at91/dt: sama5d2_xplained: add fast_restart node

 .../devicetree/bindings/arm/atmel-pmc.txt          |   63 ++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |    8 +
 arch/arm/mach-at91/pm.c                            |  130 +++++++++++++++-
 arch/arm/mach-at91/pm.h                            |    7 +
 arch/arm/mach-at91/pm_suspend.S                    |  158 +++++++++++++++++---
 include/linux/clk/at91_pmc.h                       |   36 +++++
 6 files changed, 377 insertions(+), 25 deletions(-)

-- 
1.7.9.5
