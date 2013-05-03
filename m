From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 May 2013 15:02:51 +0100
Subject: [RFC PATCH 0/2] ARM: KVM: Moving GIC/timer out of arch/arm
Message-ID: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
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

Once the code has been moved, it becomes easy to build it in a
less hackish way, which makes the code easily reusable by KVM/arm64.

Marc Zyngier (2):
  ARM: KVM: move GIC/timer code to a common location
  ARM: KVM: standalone Makefile for vgic and timers

 Makefile                                               | 2 +-
 arch/arm/include/asm/kvm_host.h                        | 4 ++--
 arch/arm/kvm/Makefile                                  | 5 ++---
 {arch/arm/include/asm => include/kvm}/kvm_arch_timer.h | 0
 {arch/arm/include/asm => include/kvm}/kvm_vgic.h       | 0
 virt/Makefile                                          | 1 +
 virt/kvm/Makefile                                      | 1 +
 virt/kvm/arm/Makefile                                  | 2 ++
 {arch/arm/kvm => virt/kvm/arm}/arch_timer.c            | 4 ++--
 {arch/arm/kvm => virt/kvm/arm}/vgic.c                  | 0
 10 files changed, 11 insertions(+), 8 deletions(-)
 rename {arch/arm/include/asm => include/kvm}/kvm_arch_timer.h (100%)
 rename {arch/arm/include/asm => include/kvm}/kvm_vgic.h (100%)
 create mode 100644 virt/Makefile
 create mode 100644 virt/kvm/Makefile
 create mode 100644 virt/kvm/arm/Makefile
 rename {arch/arm/kvm => virt/kvm/arm}/arch_timer.c (99%)
 rename {arch/arm/kvm => virt/kvm/arm}/vgic.c (100%)

-- 
1.8.2.1
