From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:07:58 +0100
Subject: [PATCH v2 00/10] KVM Guest Debug support for arm64
Message-ID: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is V2 of the KVM Guest Debug support for arm64. Although there
has been an increase in the total number of patches the implementation
is both simpler and more complete.

Gone are most of the changes that touch hyp.S replaced with C based
hooks kvm_arch_setup/clear_debug() that manipulate the VCPU context
before entering hyp.S. As a result I dropped the re-factoring patch
for simplicity.

The API has been simplified to pass the syndrome information directly
back to user-space and leaving it to figure out what each exception
is.

The ioctl and handle_exit code have been re-factored and simplified.
The handle_exit code in particular is all done with one handler which
aside from watchpoints is supplying pretty much the same information
for every exception.

The HW debugging support has been improved by handling guest access to
the debug register while debugging is happening.

As a result a bunch of the review comments are no longer relevant as
they applied to code that no longer exists. All the rest have been
addressed as of this patch series.

There are a few checkpatch violations for white space. Some in
existing code (asm-offsets) and a couple in the handle_exit code where
adding a whole extra tab seemed excessive.

GIT Repos:

The patches for this series are based off v4.0-rc6 and can be found
at:

https://git.linaro.org/people/alex.bennee/linux.git
branch: guest-debug/4.0-rc6-v2

You can find the QEMU code that goes with this patch series at:

https://github.com/stsquad/qemu
branch: kvm/guest-debug-v2

Patch breakdown:

The first 2 patches are simple clean-ups to rationalise some of the
commentary and #defines.

The next 2 introduce the API and implement the stub ioctl handler
which is built up in later patches.

The kvm_arch_setup/clear_debug() patch is a functional replacement for
the previous manipulations of mdcr_el2 in hyp.S but making the value
part of the VCPU context.

The next 3 patches implement the various guest debug features.

The penultimate patch could be merged with the one before but I kept
it split apart for ease of review.

The final patch may get dropped before up-streaming but it does
provide useful trace points for anyone who want to track what is
happening during guest debug.

Alex Benn?e (10):
  KVM: add commentary for kvm_debug_exit_arch struct
  KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP values
  KVM: arm: guest debug, define API headers
  KVM: arm: guest debug, add stub KVM_SET_GUEST_DEBUG ioctl
  KVM: arm: introduce kvm_arch_setup/clear_debug()
  KVM: arm64: guest debug, add SW break point support
  KVM: arm64: guest debug, add support for single-step
  KVM: arm64: guest debug, HW assisted debug support
  KVM: arm64: trap nested debug register access
  KVM: arm64: add trace points for guest_debug debug

 Documentation/virtual/kvm/api.txt      |  10 +-
 arch/arm/include/asm/kvm_host.h        |   2 +
 arch/arm/kvm/arm.c                     |  51 ++++++-
 arch/arm64/include/asm/hw_breakpoint.h |  12 ++
 arch/arm64/include/asm/kvm_host.h      |  19 ++-
 arch/arm64/include/uapi/asm/kvm.h      |  22 +++
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/hw_breakpoint.c      |  12 --
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/debug.c                 | 249 +++++++++++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c           |  43 ++++++
 arch/arm64/kvm/hyp.S                   |  13 +-
 arch/arm64/kvm/reset.c                 |   6 +
 arch/arm64/kvm/sys_regs.c              |  55 ++++++++
 arch/arm64/kvm/trace.h                 |  66 +++++++++
 arch/powerpc/include/uapi/asm/kvm.h    |   4 +-
 arch/x86/include/uapi/asm/kvm.h        |   4 +-
 include/uapi/linux/kvm.h               |  17 ++-
 18 files changed, 553 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/kvm/debug.c

-- 
2.3.4
