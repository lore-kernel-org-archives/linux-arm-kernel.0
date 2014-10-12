From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:13:54 +0200
Subject: [RFC 0/7] ARM: vf610m4: Add Vybrid Cortex-M4 support
Message-ID: <cover.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Vybrid SoC support for the !MMU Cortex-M4 core. The patchset is
its current state is more a collection of hacks than anything mergabel,
advice and ideas how to beat it in good shape are welcome. I added some
thoughts as comments in the individual patches.

I wrote also some more info about Vybrid Cortex-M4 support in my blog
post:
http://falstaff.agner.ch/2014/10/05/make-it-two-tuxes-on-one-soc/

One thing I noticed that when I move the xipImage below the DRAM base
address, the kernel freezes:
...
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[freeze]

I think it happens when the scheduler gets started. Any idea what could
go wrong here?

Stefan Agner (7):
  ARM: vf610: add low level debug support for !MMU
  clocksource: add dependencies for Vybrid pit clocksource
  ARM: vf610m4: add new machine and SoC for Vybrid on Cortex-M4
  ARM: dts: add support for Vybrid running on Cortex-M4
  irqchip: nvic: increase number of external interrupts to 112
  ARM: vf610m4: HACK: get dtb pointer from SRC_GPR3
  ARM: vf610m4: add defconfig for Linux on Vybrids Cortex-M4

 arch/arm/Kconfig                   |  12 ++++
 arch/arm/Kconfig.debug             |   4 +-
 arch/arm/Makefile                  |   1 +
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/armv7-m.dtsi     |   1 -
 arch/arm/boot/dts/vf610m4.dts      | 144 +++++++++++++++++++++++++++++++++++++
 arch/arm/configs/vf610m4_defconfig |  37 ++++++++++
 arch/arm/include/debug/vf.S        |  10 +++
 arch/arm/kernel/entry-v7m.S        |   4 +-
 arch/arm/kernel/head-nommu.S       |   8 +++
 arch/arm/mach-imx/Kconfig          |  22 ++++++
 arch/arm/mach-imx/Makefile         |   1 +
 arch/arm/mach-imx/Makefile.boot    |   0
 arch/arm/mach-imx/mach-vf610m4.c   |  16 +++++
 drivers/clocksource/Kconfig        |   2 +
 drivers/irqchip/irq-nvic.c         |   2 +
 drivers/mmc/host/Kconfig           |   2 +-
 drivers/pinctrl/Kconfig            |   2 +-
 18 files changed, 262 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/vf610m4.dts
 create mode 100644 arch/arm/configs/vf610m4_defconfig
 create mode 100644 arch/arm/mach-imx/Makefile.boot
 create mode 100644 arch/arm/mach-imx/mach-vf610m4.c

-- 
2.1.2
