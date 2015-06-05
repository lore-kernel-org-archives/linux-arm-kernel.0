From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  5 Jun 2015 09:37:45 +0100
Subject: [PATCH v2 0/8] kvmtool: arm64: GICv3 guest support
Message-ID: <1433493473-4002-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

a rework of the GICv3 support series for kvmtool.
I addressed Will's comments on the broken fallback in VGIC creation,
also changed the command line parameter to --irqchip=[gicv2,gicv3].
The default is still GICv2 emulation for the sake of reproducibility,
not sure we want to have an automatic switch-over in case GICv2
emulation is not supported by the hardware.
This is also the base for ITS support, which I will send later as
a follow-up series.

Cheers,
Andre.
-----

Since Linux 3.19 the kernel can emulate a GICv3 for KVM guests.
This allows more than 8 VCPUs in a guest and enables in-kernel irqchip
for non-backwards-compatible GICv3 implementations.

This series updates kvmtool to support this feature.
The first half of the series is mostly from Marc and supports some
newer features of the virtual GIC which we later depend on. The second
part enables support for a guest GICv3 by adding a new command line
parameter (--irqchip=).

We now use the KVM_CREATE_DEVICE interface to create a virtual GIC
and only fall back to the now legacy KVM_CREATE_IRQCHIP call if the
former is not supported by the kernel.
Also we use two new features the KVM_CREATE_DEVICE interface
introduces:
* We now set the number of actually used interrupts to avoid
  allocating too many of them without ever using them.
* We tell the kernel explicitly that we are finished with the GIC
  initialisation. This is a requirement for future VGIC versions.

The final three patches introduce virtual GICv3 support, so on
supported hardware (and given kernel support) the user can ask KVM to
emulate a GICv3, lifting the 8 VCPU limit of KVM. This is done by
specifying "--irqchip=gicv3" on the command line.
As the kernel currently only supports this on ARM64, this parameter
is valid for the arm64 kvmtool build. But as the GIC is shared in
kvmtool, I had to add the macro definitions to not break the build
on ARM.

This series goes on top of the new official stand-alone repo hosted
on Will's kernel.org git [1].
Find a branch with those patches included at my repo [2].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
[2] git://linux-arm.org/kvmtool.git (branch gicv3/v2)
    http://www.linux-arm.org/git?p=kvmtool.git;a=log;h=refs/heads/gicv3/v2

Andre Przywara (4):
  arm: finish VGIC initialisation explicitly
  arm: prepare for instantiating different IRQ chip devices
  arm: add support for supplying GICv3 redistributor addresses
  arm: use new irqchip parameter to create different vGIC types

Marc Zyngier (4):
  AArch64: Reserve two 64k pages for GIC CPU interface
  AArch{32,64}: use KVM_CREATE_DEVICE & co to instanciate the GIC
  irq: add irq__get_nr_allocated_lines
  AArch{32,64}: dynamically configure the number of GIC interrupts

 arm/aarch32/arm-cpu.c                    |   2 +-
 arm/aarch64/arm-cpu.c                    |   2 +-
 arm/aarch64/include/kvm/kvm-arch.h       |   2 +-
 arm/gic.c                                | 202 +++++++++++++++++++++++++++++--
 arm/include/arm-common/gic.h             |   6 +-
 arm/include/arm-common/kvm-arch.h        |  18 ++-
 arm/include/arm-common/kvm-config-arch.h |   9 +-
 arm/kvm-cpu.c                            |  10 +-
 arm/kvm.c                                |   8 +-
 include/kvm/irq.h                        |   1 +
 irq.c                                    |   5 +
 11 files changed, 240 insertions(+), 25 deletions(-)

-- 
2.3.5
