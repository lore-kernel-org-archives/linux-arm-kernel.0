From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 16:35:38 -0700
Subject: [PATCH 0/4] Correct wlcore irqs for PM improvments for omap4 boards
Message-ID: <20180517233542.30629-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like we can get omap4 devices to do some PM with mainline kernel
mostly with just few dts tweaks. Mostly we just try to remove any GPIO
level interrupts and debounce clocks. But let's fix the wlcore irq for all
the boards as we know for sure it should be a level interrupt.

These changes allow pandaboard-es and duovero parlor to enter core retention
during idle, and droid4 to enter per retention during idle.

To have the devices enter idle, the UARTs need to be idled, and USB related
modules need to be unloaded or unbound. Additionally pandaboard-es somehow
needs also rmmod ti_soc_thermal which I don't quite understand.

On droid4, GPIO bank 1 needs to be somehow reset after init to not block
core retention. I also don't quite understand why this is, maybe because of
kexec booting?

For dealing with GPIO level interrupts, we're missing some GPIO PM runtime
patches that will be posted later after some more testing.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Make sure LOGICRETSTATE bits are not cleared
  ARM: dts: Fix omap l4per idling with wlcore edge sensitive interrupt
  ARM: dts: Configure duovero for to allow core retention during idle
  omap4-droid4: Use software debounce for gpio-keys

 arch/arm/boot/dts/am335x-baltos.dtsi              |  2 +-
 arch/arm/boot/dts/am335x-evm.dts                  |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               |  2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi             |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts              |  2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts              |  2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi           |  2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts        |  2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts        |  2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                 |  2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts          |  5 +++--
 arch/arm/boot/dts/omap4-duovero-parlor.dts        |  3 ++-
 arch/arm/boot/dts/omap4-duovero.dtsi              |  1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi         |  2 +-
 arch/arm/boot/dts/omap4-sdp.dts                   |  2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi    |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi         |  2 +-
 arch/arm/mach-omap2/pm44xx.c                      | 13 +++++++++++++
 20 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.17.0
