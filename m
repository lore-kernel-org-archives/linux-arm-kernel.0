From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 19 Feb 2017 04:19:56 +0100
Subject: [PATCH 0/4] ARM64: Initial Marvell IAP140 enablement
Message-ID: <20170219032000.4674-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Marvell IAP140 SoC (aka PXA1908)
and the Andromeda Box Edge development board.

In order to enable the 8250 UART driver, it reuses ARCH_PXA; but some drivers
enabled with ARCH_PXA don't build due to arm assembly or arm64's lack of mach-,
so their dependencies need to be limited to ARM alongside (blacklisted). The
alternative would of course be to choose a new ARCH_ symbol and to selectively
add it to drivers known working (whitelisting). The latter would require
finding a suitable name.

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

More Marvell drivers may be available in-tree for reuse - besides build errors
the limitation is currently the lack of an IAP140 clk driver though. Patch 4/4
works around that for UART0 with a fixed-clock.

A 3.14 based tree is available on GitHub acorn-marvell/brillo_pxa_kernel. No
driver comparisons to mainline have been attempted yet.

Booting required changes to the vendor U-Boot,
cf. https://en.opensuse.org/HCL:AndromedaBoxEdge

https://github.com/afaerber/linux/commits/edge-next

Have a lot of fun!

Cheers,
Andreas

Cc: info at andromedabox.org
Cc: devicetree at vger.kernel.org

Andreas F?rber (4):
  ARM64: Prepare Marvell IAP140 aka PXA1908
  Documentation: devicetree: arm: Document Marvell IAP140
  ARM64: dts: marvell: Add IAP140 and Andromeda Box Edge
  ARM64: dts: marvell: iap140-andromeda-box-edge: Add uart0 clock

 .../devicetree/bindings/arm/marvell/iap140.txt     |   7 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 .../boot/dts/marvell/iap140-andromeda-box-edge.dts |  77 ++++++++
 arch/arm64/boot/dts/marvell/iap140.dtsi            | 195 +++++++++++++++++++++
 drivers/clk/Kconfig                                |   2 +-
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/tty/serial/Kconfig                         |   2 +-
 8 files changed, 289 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/iap140.txt
 create mode 100644 arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
 create mode 100644 arch/arm64/boot/dts/marvell/iap140.dtsi

-- 
2.10.2
