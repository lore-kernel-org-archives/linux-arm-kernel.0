From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  6 May 2015 17:23:15 +0100
Subject: [PATCH v3 00/12] KVM Guest Debug support for arm64
Message-ID: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is V3 of the KVM Guest Debug support for arm64.

This sees the return of hyp.S re-factoring code which has been
expanded to handle both the save and restore legs. The HW debug patch
then adds a simple indirection to enable switching between the guest
context debug registers and the active debugging context.

The API has been further simplified to remove the PC (as that is
already available by the GET_ONE_REG ioctl). The responsibility for
handling re-injection is now explicitly that of userspace.

The setup/clear debug code has gained an init function to be called at
start-up and save useful values (currently only mdcr_el2.HPMN).

For full details see the changelog on each of the patches.

As before there are a few checkpatch violations for white space. Some
in existing code (asm-offsets) and a couple in the handle_exit code
where adding a whole extra tab seemed excessive.

Reviewed-by tags have been added to the earlier patches as
appropriate.

GIT Repos:

The patches for this series are based off v4.1-rc1 and can be found
at:

https://git.linaro.org/people/alex.bennee/linux.git
branch: guest-debug/4.1-rc1-v3

I'm still in the process of going through the QEMU comments and adding
the re-injection support. However the current working state can be
seen at:

https://github.com/stsquad/qemu
branch: kvm/guest-debug-v3

Patch breakdown:

The first 2 patches are simple clean-ups to rationalise some of the
commentary and #defines.

The next 2 introduce the API and implement the stub ioctl handler
which is built up in later patches.

The kvm_arch_setup/clear_debug() patch is a functional replacement for
the previous manipulations of mdcr_el2 in hyp.S but making the value
part of the VCPU context.

The next 2 patches implement the software and single step
functionalists.

Before the HW assisted patch can go in there is a patch to re-factor
some of the debug register setup code.

The penultimate patch could be merged with the one before but I kept
it split apart for ease of review.

The final patch may get dropped before up-streaming but it does
provide useful trace points for anyone who want to track what is
happening during guest debug.

Alex Benn?e (12):
  KVM: add comments for kvm_debug_exit_arch struct
  KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP values
  KVM: arm64: guest debug, define API headers
  KVM: arm: guest debug, add stub KVM_SET_GUEST_DEBUG ioctl
  KVM: arm: introduce kvm_arm_init/setup/clear_debug
  KVM: arm64: guest debug, add SW break point support
  KVM: arm64: guest debug, add support for single-step
  KVM: arm64: re-factor hyp.S debug register code
  KVM: arm64: guest debug, HW assisted debug support
  KVM: arm64: trap nested debug register access
  KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG
  KVM: arm64: add trace points for guest_debug debug

 Documentation/virtual/kvm/api.txt      |  15 +-
 arch/arm/include/asm/kvm_host.h        |   4 +
 arch/arm/kvm/arm.c                     |  45 ++-
 arch/arm64/include/asm/hw_breakpoint.h |  12 +
 arch/arm64/include/asm/kvm_asm.h       |   2 +
 arch/arm64/include/asm/kvm_host.h      |  28 +-
 arch/arm64/include/uapi/asm/kvm.h      |  25 ++
 arch/arm64/kernel/asm-offsets.c        |   6 +
 arch/arm64/kernel/hw_breakpoint.c      |  12 -
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/debug.c                 | 210 +++++++++++++
 arch/arm64/kvm/handle_exit.c           |  46 +++
 arch/arm64/kvm/hyp.S                   | 546 ++++++++++-----------------------
 arch/arm64/kvm/reset.c                 |  15 +
 arch/arm64/kvm/sys_regs.c              |  34 ++
 arch/arm64/kvm/trace.h                 | 107 +++++++
 arch/powerpc/include/uapi/asm/kvm.h    |   4 +-
 arch/x86/include/uapi/asm/kvm.h        |   4 +-
 include/uapi/linux/kvm.h               |  17 +-
 19 files changed, 718 insertions(+), 416 deletions(-)
 create mode 100644 arch/arm64/kvm/debug.c

-- 
2.3.5
