From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 14:31:00 +0100
Subject: [PATCH v3 0/2] ARM: KVM: Moving GIC/timer out of arch/arm
Message-ID: <1368538262-25546-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As KVM/arm64 is looming on the horizon, it makes sense to move some
of the common code to a single location in order to reduce duplication.

The code could live anywhere. Actually, most of KVM is already built
with a bunch of ugly ../../.. hacks in the various Makefiles, so we're
not exactly talking about style here. But maybe it is time to start
moving into a less ugly direction.

The include files must be in a "public" location, as they are accessed
from non-KVM files (arch/arm/kernel/asm-offsets.c).

For this purpose, introduce two new locations:
- virt/kvm/arm/ : x86 and ia64 already share the ioapic code in
  virt/kvm, so this could be seen as a (very ugly) precedent.
- include/kvm/  : there is already an include/xen, and while the
  intent is slightly different, this seems as good a location as
  any

A second, tree-wide patch also removes the use of the addprefix used
to refer to the main KVM code from the arch code, and replace it with
a KVM variable that does the same thing.

* From v2:
  - Fix silly bug breaking compilation on x86...

Marc Zyngier (2):
  ARM: KVM: move GIC/timer code to a common location
  KVM: get rid of $(addprefix ../../../virt/kvm/, ...) in Makefiles

 arch/arm/include/asm/kvm_host.h                             |  4 ++--
 arch/arm/kvm/Makefile                                       |  7 ++++---
 arch/ia64/kvm/Makefile                                      |  7 ++++---
 arch/powerpc/kvm/Makefile                                   | 13 +++++++------
 arch/s390/kvm/Makefile                                      |  3 ++-
 arch/x86/kvm/Makefile                                       | 13 +++++++------
 .../asm/kvm_arch_timer.h => include/kvm/arm_arch_timer.h    |  0
 arch/arm/include/asm/kvm_vgic.h => include/kvm/arm_vgic.h   |  0
 {arch/arm/kvm => virt/kvm/arm}/arch_timer.c                 |  4 ++--
 {arch/arm/kvm => virt/kvm/arm}/vgic.c                       |  0
 10 files changed, 28 insertions(+), 23 deletions(-)
 rename arch/arm/include/asm/kvm_arch_timer.h => include/kvm/arm_arch_timer.h (100%)
 rename arch/arm/include/asm/kvm_vgic.h => include/kvm/arm_vgic.h (100%)
 rename {arch/arm/kvm => virt/kvm/arm}/arch_timer.c (99%)
 rename {arch/arm/kvm => virt/kvm/arm}/vgic.c (100%)

-- 
1.8.2.3
