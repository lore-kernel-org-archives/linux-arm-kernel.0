From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:26:44 +0000
Subject: [PATCH 0/9] irqchip: gic: kill gic_arch_extn
Message-ID: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gic_arch_extn hack that Tegra uses has been nagging me for too
long. It is only there for the benefit of a single platform, and yet
it impacts all GIC users. Moreover, it gives people the wrong idea
("let's use it to put some new custom hack in there"...).

But now that stacked irq domains have landed in -next, the time has
come for gic_arch_extn to meet the Big Bit Bucket.

This patch series moves Tegra's legacy interrupt controller support to
drivers/irqchip, implementing a stacked domain on top of the standard
GIC. The GIC itself is cleaned up, and some other bits and bobs are
adjusted for a good measure.

It is worth realizing that:
- I haven't been able to test this as much as I would have wanted to
(suspend/resume seems to be broken on my Harmony, and I don't have
another platform at hand). But I haven't seen any regression from 3.17.
- I've relaxed quite a bit of the locking in the GIC code. I believe
this is safe, but someone else should give it a long hard look.
- This actively *breaks* existing setups. Once you boot a new kernel
with an old DT, suspend/resume *will* be broken. Old kernels on a new
DT won't even boot! You've been warned.

As for the patches, they are on top of 3.18-rc6 +
tip/irq/irqdomain-arm. Patch #1 is already queued for 3.18, and only
included here for completeness.

I've pushed the code to:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/tegra-lic

Comments welcome,

	 M.

Marc Zyngier (9):
  ARM: tegra: irq: fix buggy usage of irq_data irq field
  ARM: tegra: irq: nuke leftovers from non-DT support
  irqchip: tegra: add DT-based support for legacy interrupt controller
  ARM: tegra: skip gic_arch_extn setup if DT has a LIC node
  ARM: tegra: update DTs to expose legacy interrupt controller
  DT: tegra: add binding for the legacy interrupt controller
  ARM: tegra: remove old LIC support
  ARM: tegra: use DT to find the GIC distributor
  irqchip: gic: Drop support for gic_arch_extn

 .../interrupt-controller/nvdia,tegra-ictlr.txt     |  39 +++
 arch/arm/boot/dts/tegra114.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra20.dtsi                     |  15 +-
 arch/arm/boot/dts/tegra30.dtsi                     |  16 +-
 arch/arm/mach-tegra/iomap.h                        |  18 --
 arch/arm/mach-tegra/irq.c                          | 228 ++------------
 arch/arm/mach-tegra/irq.h                          |   6 -
 arch/arm/mach-tegra/tegra.c                        |   1 -
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic.c                          |  46 +--
 drivers/irqchip/irq-tegra.c                        | 335 +++++++++++++++++++++
 include/linux/irqchip/arm-gic.h                    |   2 -
 13 files changed, 461 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvdia,tegra-ictlr.txt
 create mode 100644 drivers/irqchip/irq-tegra.c

-- 
2.1.3
