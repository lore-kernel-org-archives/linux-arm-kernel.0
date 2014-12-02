From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Dec 2014 16:58:01 +0000
Subject: [PATCH 00/16] irqchip: gic: killing gic_arch_extn, slowly
Message-ID: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gic_arch_extn hack that a number of platform use has been nagging
me for too long. It is only there for the benefit of a few platform,
and yet it impacts all GIC users. Moreover, it gives people the wrong
idea ("let's use it to put some new custom hack in there"...).

But now that stacked irq domains have landed in -next, the time has
come for gic_arch_extn to meet the Big Bit Bucket.

This patch series takes several steps towards the elimination of
gic_arch_extn:

- moves Tegra's legacy interrupt controller support to
  drivers/irqchip, implementing a stacked domain on top of the
  standard GIC.

- OMAP, imx6 and exynos are also converted to stacked domains, but
  their implementation is left in place (the code is far too
  intricately mixed with other details of the platform for me to even
  try to move it).

- shmobile, ux500 and zynq are only slightly modified.

- The GIC itself is cleaned up, and some other bits and bobs are
  adjusted for a good measure.

It is worth realizing that:

- I haven't been able to test this as much as I would have wanted to
  (it's only been tested on tegra2 and omap5).

- I've created DT bindings when needed, updated existing ones, but I
  haven't created a binding for platforms that already used an
  undocumented one (imx6, I'm looking at you).

- I've relaxed quite a bit of the locking in the GIC code. I believe
  this is safe, but someone else should give it a long hard look.

- This actively *breaks* existing setups. Once you boot a new kernel
  with an old DT, suspend/resume *will* be broken. Old kernels on a
  new DT won't even boot! You've been warned. This really outline the
  necessity of actually describing the HW in device trees...

As for the patches, they are on top of 3.18-rc7 + tip/irq/irqdomain-arm.

I've pushed the code to:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/die-gic-arch-extn-die-die-die

Comments welcome,

	 M.

Marc Zyngier (16):
  ARM: tegra: irq: nuke leftovers from non-DT support
  irqchip: tegra: add DT-based support for legacy interrupt controller
  ARM: tegra: skip gic_arch_extn setup if DT has a LIC node
  ARM: tegra: update DTs to expose legacy interrupt controller
  DT: tegra: add binding for the legacy interrupt controller
  ARM: tegra: remove old LIC support
  ARM: omap: convert wakeupgen to stacked domains
  DT: omap4/5: add binding for the wake-up generator
  ARM: imx6: convert wakeupgen to stacked domains
  ARM: exynos4/5: convert pmu wakeup to stacked domains
  DT: exynos: update PMU binding
  irqchip: gic: add an entry point to set up irqchip flags
  ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
  ARM: ux500: switch from gic_arch_extn to gic_set_irqchip_flags
  ARM: zynq: switch from gic_arch_extn to gic_set_irqchip_flags
  irqchip: gic: Drop support for gic_arch_extn

 .../devicetree/bindings/arm/samsung/pmu.txt        |  13 +
 .../interrupt-controller/nvidia,tegra-ictlr.txt    |  39 +++
 .../interrupt-controller/ti,omap4-wugen-mpu        |  32 ++
 arch/arm/boot/dts/am4372.dtsi                      |  11 +-
 arch/arm/boot/dts/dra7.dtsi                        |  12 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   3 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   3 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   5 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   5 +-
 arch/arm/boot/dts/omap4.dtsi                       |  12 +-
 arch/arm/boot/dts/omap5.dtsi                       |  12 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra20.dtsi                     |  15 +-
 arch/arm/boot/dts/tegra30.dtsi                     |  16 +-
 arch/arm/mach-exynos/exynos.c                      |  12 +-
 arch/arm/mach-exynos/pm.c                          | 116 ++++++-
 arch/arm/mach-imx/common.h                         |   1 -
 arch/arm/mach-imx/gpc.c                            | 127 ++++++--
 arch/arm/mach-imx/mach-imx6q.c                     |   1 -
 arch/arm/mach-imx/mach-imx6sl.c                    |   1 -
 arch/arm/mach-imx/mach-imx6sx.c                    |   1 -
 arch/arm/mach-omap2/omap-wakeupgen.c               | 125 ++++++--
 arch/arm/mach-omap2/omap-wakeupgen.h               |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |   1 -
 arch/arm/mach-shmobile/intc-sh73a0.c               |   7 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |   7 +-
 arch/arm/mach-tegra/iomap.h                        |  15 -
 arch/arm/mach-tegra/irq.c                          | 208 +------------
 arch/arm/mach-tegra/irq.h                          |   6 -
 arch/arm/mach-tegra/tegra.c                        |   1 -
 arch/arm/mach-ux500/cpu.c                          |   2 +-
 arch/arm/mach-zynq/common.c                        |   2 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic.c                          |  59 +---
 drivers/irqchip/irq-tegra.c                        | 335 +++++++++++++++++++++
 include/linux/irqchip/arm-gic.h                    |   3 +-
 38 files changed, 869 insertions(+), 379 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
 create mode 100644 drivers/irqchip/irq-tegra.c

-- 
2.1.3
