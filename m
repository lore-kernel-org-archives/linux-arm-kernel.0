From: tony@atomide.com (Tony Lindgren)
Date: Fri, 07 Jun 2013 13:50:32 -0700
Subject: [PATCH 0/4] pinctrl single support for SoC specific features
Message-ID: <20130607203936.16513.57494.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few patches to add support for SoC specific features
to pinctrl-single. This is needed at least for omaps to support
IO chain wake-up events from deeper idle states.

With this patch series, device drivers can request named pinctrl
states like active and idle from the PM runtime suspend and resume
calls to set the wake enable bits for selected pins. Further
the device driver can toggle the wake-up feature as needed based on
the device_may_wakeup() state set by the standard sysfs
power/wakeup entry.

This is implemented in a separate pinctrl-single-omap driver that
works together with pinctrl-single. This way the SoC specific
are separated from the common pinctrl-single, and allows a relatively
easy way to implement SoC specific things like wake-up events,
pin interrupts, and GPIO.

Regards,

Tony

---

Tony Lindgren (4):
      pinctrl: single: Prepare for supporting SoC specific features
      pinctrl: single: Add hardware specific hooks for IRQ and GPIO wake-up events
      pinctrl: single: omap: Add SoC specific module for wake-up events
      ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap


 .../devicetree/bindings/pinctrl/pinctrl-single.txt |    5 
 arch/arm/boot/dts/omap3.dtsi                       |    4 
 arch/arm/boot/dts/omap4.dtsi                       |    4 
 arch/arm/boot/dts/omap5.dtsi                       |    4 
 arch/arm/mach-omap2/mux.c                          |    8 -
 arch/arm/mach-omap2/pm34xx.c                       |    2 
 arch/arm/mach-omap2/prm_common.c                   |   26 ++
 drivers/pinctrl/Makefile                           |    3 
 drivers/pinctrl/pinctrl-single-omap.c              |  287 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-single.c                   |  157 +++++++++--
 drivers/pinctrl/pinctrl-single.h                   |   43 +++
 include/linux/platform_data/pinctrl-single-omap.h  |    4 
 12 files changed, 508 insertions(+), 39 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
 create mode 100644 drivers/pinctrl/pinctrl-single.h
 create mode 100644 include/linux/platform_data/pinctrl-single-omap.h

-- 
Signature
