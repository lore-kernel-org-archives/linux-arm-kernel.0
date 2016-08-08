From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 8 Aug 2016 18:04:59 +0800
Subject: [PATCH v6 0/6] ARM: at91: pm: add ULP1 mode support
Message-ID: <1470650705-31418-1-git-send-email-wenyou.yang@atmel.com>
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

Changes in v6:
 - Add Acked-by tag.
 - Add specific sama5d2_pm_init() for SAMA5D2, which supports ULP1.
   It is called sama5d2_dt_device_init(). Instead of by reading
   the PMC version to check if it supports ULP1.
 - Add comment to describe the platform condition of calling
   at91_pm_ulp1_mode().
 - Update the commit log.
 - Add a new patch to support a new DT_MACHINE for SAMA5D2.

Changes in v5:
 - to improve the scalability, rework the DT expression part, use
   the child nodes to describe the wake-up input and its active level.
 - due to the DT property expression change, update the binding
   document.
 - due to the DT property expression change, update the fast restart
   node's property.

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

Wenyou Yang (6):
  ARM: at91: sama5: Add a new DT_MACHINE for SAMA5D2
  ARM: at91: pm: Create a procedure for the ULP0 mode
  ARM: at91: pm: Add ULP1 mode support
  ARM: at91: pm: Configure PMC fast startup signals
  Documentation: atmel-pmc: Add DT bindings for fast startup
  ARM: at91/dt: sama5d2_xplained: Add fast_restart node

 .../devicetree/bindings/arm/atmel-pmc.txt          |  52 +++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  19 +++
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            |  83 ++++++++++-
 arch/arm/mach-at91/pm.h                            |   7 +
 arch/arm/mach-at91/pm_suspend.S                    | 160 ++++++++++++++++++---
 arch/arm/mach-at91/sama5.c                         |  26 +++-
 include/linux/clk/at91_pmc.h                       |  16 +++
 8 files changed, 338 insertions(+), 27 deletions(-)

-- 
2.7.4
