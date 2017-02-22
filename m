From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:20 +0100
Subject: [PATCH v2 0/8] ARM64: Initial Marvell IAP140 enablement
Message-ID: <20170222022929.10540-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the Marvell IAP140 SoC (aka PXA1908)
and the Andromeda Box Edge development board.

v2 reuses ARCH_MMP.

Both earlycon and serial are working, but an explicit console=ttyS0,115200n8
is needed; with just "earlycon" and stdout-path the earlycon stops early and
switches to a tty0, long before disabling the bootconsole...

All four CPUs come up, and an initrd can be reached.

However, there are errors about CPUs 1-3 having a zero SYS_CNTFRQ_EL0:

[    0.095812] smp: Bringing up secondary CPUs ...
======pxa1908_pmu_core_pwr_on: mpidr = 0x1
======pxa1908_pmu_core_pwr_on: mpidr = 0x2
======pxa1908_pmu_core_pwr_on: mpidr = 0x3
[    0.133419] Detected VIPT I-cache on CPU1
[    0.133430] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU1: 0x00000000000000
[    0.133447] Unsupported CPU feature variation.
...
[    0.133748] CPU1: Booted secondary processor [410fd032]
[    0.165465] Detected VIPT I-cache on CPU2
[    0.165474] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU2: 0x00000000000000
[    0.165505] CPU2: Booted secondary processor [410fd032]
[    0.197539] Detected VIPT I-cache on CPU3
[    0.197546] CPU features: SANITY CHECK: Unexpected variation in SYS_CNTFRQ_EL0. Boot CPU: 0x000000018cba80, CPU3: 0x00000000000000
[    0.197573] CPU3: Booted secondary processor [410fd032]
[    0.197625] smp: Brought up 1 node, 4 CPUs
[    0.522514] SMP: Total of 4 processors activated.
[    0.527212] CPU features: detected feature: 32-bit EL0 Support
[    0.533105] CPU: All CPU(s) started at EL2

KVM appears to initialize okay, but was not yet tested with guests.

[    0.865255] kvm [1]: 8-bit VMID
[    0.868401] kvm [1]: IDMAP page: d23000
[    0.872233] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    0.878262] kvm [1]: Hyp mode initialized successfully
[    0.883429] kvm [1]: vgic-v2 at d1dfc000
[    0.887179] kvm [1]: vgic interrupt IRQ1
[    0.891120] kvm [1]: virtual timer IRQ4

One limitation is currently the lack of an IAP140 clk driver. Patch 4/4 works
around that for UART0 with a fixed-clock.

A 3.14 based tree is available on GitHub acorn-marvell/brillo_pxa_kernel.

Booting required changes to the vendor U-Boot,
cf. https://en.opensuse.org/HCL:AndromedaBoxEdge

https://github.com/afaerber/linux/commits/edge-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Add non-DT documentation
* Use ARCH_MMP instead of ARCH_PXA
* Split off Kconfig cleanups per subsystem
* Drop "mrvl,pxa-uart" and instead implement mmp earlycon
* Add some more DT nodes

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: info at andromedabox.org
Cc: devicetree at vger.kernel.org

Andreas F?rber (8):
  Documentation: arm: Marvell: Document IAP140
  tty: serial: Suppress deprecated SERIAL_PXA on arm64
  tty: serial: 8250_pxa: Implement mmp earlycon
  sound: soc: pxa: Suppress SND_MMP_SOC for arm64
  ARM64: Prepare Marvell IAP140 aka PXA1908
  Documentation: devicetree: arm: marvell: Document IAP140
  ARM64: dts: marvell: Add IAP140 and Andromeda Box Edge
  ARM64: dts: marvell: iap140-andromeda-box-edge: Add uart0 clock

 Documentation/arm/Marvell/README                   |  12 +-
 .../devicetree/bindings/arm/marvell/iap140.txt     |  11 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 .../boot/dts/marvell/iap140-andromeda-box-edge.dts |  87 ++++++++
 arch/arm64/boot/dts/marvell/iap140.dtsi            | 241 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_pxa.c                 |   1 +
 drivers/tty/serial/Kconfig                         |   2 +-
 sound/soc/pxa/Kconfig                              |   4 +-
 9 files changed, 364 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/iap140.txt
 create mode 100644 arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
 create mode 100644 arch/arm64/boot/dts/marvell/iap140.dtsi

-- 
2.10.2
