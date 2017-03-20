From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Mar 2017 11:58:09 +0100
Subject: [PATCH 0/9] KVM: arm/arm64: vgic: Improvements and optimizations
Message-ID: <20170320105818.20481-1-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can improve the performance of our VGIC implementation a bit and
clean up a lot of the implementation while we're at it.

At first, patch 1 may seem excessive for a single register, the VMCR,
but whlie it adds complexity it does move logic out of the critical path
and into the vcpu_load/put hooks, which are executed much more rarely.
It also provides an infrastructure to move more things into the
vgic_load/put functions later one.

Avoiding the need to take a spinlock in the common case where there are
no virtual interrupts in flight are actually measurable and well worth
the effort.

The implementation cleanups boil down to maintaining a single count of
the used lrs instead of an additional bitmap, avoiding the need to deel
with the MISR and EISR fields, and doing an early init of the VGIC to
avoid a number of vgic_initialized() checks.

Tested on Mustang and TC2, and Thunder-X.

Patches also available on:
git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git gic-optimize

Thanks,
-Christoffer

Christoffer Dall (8):
  KVM: arm/arm64: vgic: Defer touching GICH_VMCR to vcpu_load/put
  KVM: arm/arm64: vgic: Get rid of live_lrs
  KVM: arm/arm64: vgic: Get rid of unnecessary process_maintenance
    operation
  KVM: arm/arm64: vgic: Get rid of unnecessary save_maint_int_state
  KVM: arm/arm64: vgic: Get rid of MISR and EISR fields
  KVM: arm/arm64: vgic: Implement early VGIC init functionality
  KVM: arm/arm64: vgic: Don't check vgic_initialized in flush_hwstate
  KVM: arm/arm64: vgic: Improve sync_hwstate performance

Shih-Wei Li (1):
  KVM: arm/arm64: vgic: Avoid flushing vgic state when there's no
    pending IRQ

 arch/arm/include/asm/kvm_asm.h   |   3 ++
 arch/arm/kvm/arm.c               |  11 ++--
 arch/arm64/include/asm/kvm_asm.h |   2 +
 include/kvm/arm_vgic.h           |   9 ++--
 virt/kvm/arm/hyp/vgic-v2-sr.c    |  78 +++-------------------------
 virt/kvm/arm/hyp/vgic-v3-sr.c    |  79 +++++++---------------------
 virt/kvm/arm/vgic/vgic-init.c    | 108 ++++++++++++++++++++++++---------------
 virt/kvm/arm/vgic/vgic-v2.c      | 101 ++++++++++++++++++++----------------
 virt/kvm/arm/vgic/vgic-v3.c      |  89 +++++++++++++++++++-------------
 virt/kvm/arm/vgic/vgic.c         |  44 +++++++++++++---
 virt/kvm/arm/vgic/vgic.h         |  10 +++-
 11 files changed, 261 insertions(+), 273 deletions(-)

-- 
2.9.0
