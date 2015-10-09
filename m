From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Oct 2015 23:52:10 +0100
Subject: [PULL v2] GIC changes for Linux 4.4
Message-ID: <1444431130-29571-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Jason,

Here's the pull request for the GIC updates I stashed over the past
few weeks. Only real new feature is the 32bit support from
Jean-Philippe, the rest is all about dealing with errata and firmware.

Please pull!

Thanks,

	M.

The following changes since commit 0e841b04c829f59a5d5745f98d2857f48882efe9:

  irqchip/sunxi-nmi: Switch to of_io_request_and_map() from of_iomap() (2015-10-09 22:47:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/gic-4.4

for you to fetch changes up to 4f64cb65bf76fbd89c62d8e69c7bf75091950739:

  arm/arm64: KVM: Only allow 64bit hosts to build VGICv3 (2015-10-09 23:11:57 +0100)

----------------------------------------------------------------
GIC updates for Linux 4.4:

- Enable basic GICv3 support on 32bit ARM (mostly for running VMs with
  more than 8 virtual CPUs)
- arm64 changes to deal with firmware limitations that forces a GICv3
  to be used as a GICv2
- A GICv2m erratum workaround on Applied Micro X-Gene2

----------------------------------------------------------------
Duc Dang (1):
      irqchip/gic-v2m: Add workaround for APM X-Gene GICv2m erratum

Jean-Philippe Brucker (6):
      irqchip/gic-v3: Refactor the arm64 specific parts
      irqchip/gic-v3: Change unsigned types for AArch32 compatibility
      irqchip/gic-v3: Specialize readq and writeq accesses
      ARM: add 32bit support to GICv3
      ARM: virt: select ARM_GIC_V3
      arm/arm64: KVM: Only allow 64bit hosts to build VGICv3

Marc Zyngier (5):
      arm64: el2_setup: Make sure ICC_SRE_EL2.SRE sticks before using GICv3 sysregs
      irqchip/gic-v3: Make gic_enable_sre an inline function
      arm64: cpufeatures: Check ICC_EL1_SRE.SRE before enabling ARM64_HAS_SYSREG_GIC_CPUIF
      irqchip/gic: Warn if GICv3 system registers are enabled
      arm64: Update booting requirements for GICv3 in GICv2 mode

 Documentation/arm64/booting.txt     |  11 ++-
 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/arch_gicv3.h   | 188 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 170 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |  19 +++-
 arch/arm64/kernel/head.S            |   2 +
 arch/arm64/kvm/Kconfig              |   4 +
 drivers/irqchip/irq-gic-v2m.c       |  22 +++++
 drivers/irqchip/irq-gic-v3.c        | 120 ++++++-----------------
 drivers/irqchip/irq-gic.c           |  15 +++
 include/kvm/arm_vgic.h              |   4 +-
 include/linux/irqchip/arm-gic-v3.h  | 104 +++++---------------
 virt/kvm/arm/vgic.c                 |   4 +-
 13 files changed, 487 insertions(+), 177 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_gicv3.h
 create mode 100644 arch/arm64/include/asm/arch_gicv3.h
