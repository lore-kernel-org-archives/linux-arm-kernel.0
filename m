From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 21:35:22 +0100
Subject: [PATCH v3 00/16] Move vcpu_load and vcpu_put calls to arch code
Message-ID: <20171204203538.8370-1-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Some architectures may decide to do different things during
kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
arm64 is about to do significant work in vcpu load/put when running a
vcpu, but it's problematic to do this for any other vcpu ioctl than
KVM_RUN.

Further, while it may be possible to call kvm_arch_vcpu_load() for a
number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
to reason about, especially after my optimization series, because a lot
of things can now happen, where we have to consider if we're really in
the process of running a vcpu or not.

This series will first move the vcpu_load() and vcpu_put() calls in the
arch generic dispatch function into each case of the switch statement
and then, one-by-one, pushed the calls down into the architecture
specific code making the changes for each ioctl as required.

Based on v4.15-rc1

Patches also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put-v3

Changes since v2:
 - Clarified commit message on patch 1
 - Initialized ret to -EINVAL at declaration on patch 9
 - Added David Hildenbrand's reviewed-by tag

Changes since v1:
 - Fix PPC and S390 bugs from v1
 - Take the mutex in the main disaptcher function and make vcpu_load a
   void, which simplifies the patches overall.
 - Add a patch that moves vcpu_load for arm/arm64 after the first-run
   init function.

Thanks,
-Christoffer

Christoffer Dall (16):
  KVM: Take vcpu->mutex outside vcpu_load
  KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
  KVM: Move vcpu_load to arch-specific
    kvm_arch_vcpu_ioctl_set_guest_debug
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
  KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
  KVM: arm/arm64: Move vcpu_load call after kvm_vcpu_first_run_init

 arch/arm64/kvm/guest.c        |  12 +++--
 arch/mips/kvm/mips.c          |  58 +++++++++++++++--------
 arch/powerpc/kvm/book3s.c     |  24 +++++++++-
 arch/powerpc/kvm/booke.c      |  51 +++++++++++++++-----
 arch/powerpc/kvm/powerpc.c    |  19 +++++---
 arch/s390/kvm/kvm-s390.c      |  90 +++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx.c            |   4 +-
 arch/x86/kvm/x86.c            | 106 ++++++++++++++++++++++++++++++------------
 include/linux/kvm_host.h      |   2 +-
 virt/kvm/arm/arch_timer.c     |   4 --
 virt/kvm/arm/arm.c            |  68 ++++++++++++++++++---------
 virt/kvm/arm/vgic/vgic-init.c |  11 -----
 virt/kvm/kvm_main.c           |  17 ++-----
 13 files changed, 322 insertions(+), 144 deletions(-)

-- 
2.14.2
