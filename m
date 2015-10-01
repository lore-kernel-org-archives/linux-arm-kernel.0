From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu,  1 Oct 2015 13:47:13 +0100
Subject: [PATCH v3 0/6] GICv3: add 32bit compatibility
Message-ID: <1443703639-3730-1-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds 32bit support to the GICv3 driver. Only SGIs, PPIs and
SPIs support is present, no ITS.
Currently, the main targets for those patches are 32bit guests running under
KVM. They can now use affinity routing and theoretically have a lot more than
8 CPUs. During my tests, I was able to use 16 virtual CPUs on an AEM model.

We don't support 32bit hosts with GICv3 at the moment. I added a patch to allow
building a host when CONFIG_ARM_GIC_V3 enabled, as pointed out by Vladimir in
the last series. When attempting to run such host with a device-tree that
declares GICv3, KVM will refuse to start, and throw a -ENODEV error.

Some time has passed since last series, but I am now available full-time to act
on reviews and comments.

Changes since v2 [2]:
- rebased on 4.3-rc3,
- add a sixth patch to handle build with CONFIG_KVM + CONFIG_ARM_GIC_V3.

Changes since v1 [1]:
- fix the mistakes pointed out on the list,
- add a patch to select ARM_GIC_V3 under ARCH_VIRT.

Cheers,
Jean

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310124.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327034.html

Jean-Philippe Brucker (6):
  arm64: GICv3: refactor the AArch64 specific parts
  arm64: GICv3: change unsigned types for AArch32 compatibility
  arm64: GICv3: Specialize readq and writeq accesses
  ARM: add 32bit support to GICv3
  ARM: virt: select ARM_GIC_V3
  arm/arm64: KVM: only allow 64bit hosts to build VGICv3

 arch/arm/Kconfig                    |    1 +
 arch/arm/include/asm/arch_gicv3.h   |  188 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h |  148 +++++++++++++++++++++++++++
 arch/arm64/kvm/Kconfig              |    4 +
 drivers/irqchip/irq-gic-v3.c        |   69 ++++---------
 include/kvm/arm_vgic.h              |    4 +-
 include/linux/irqchip/arm-gic-v3.h  |   87 ++--------------
 virt/kvm/arm/vgic.c                 |    4 +-
 8 files changed, 373 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_gicv3.h
 create mode 100644 arch/arm64/include/asm/arch_gicv3.h

-- 
1.7.9.5
