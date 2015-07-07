From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  7 Jul 2015 17:29:52 +0100
Subject: [PATCH v8 00/11] KVM Guest Debug support for arm64
Message-ID: <1436286603-15192-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is V8 of the KVM Guest Debug support for arm64.

The diffstat between v7 and v8 is getting pretty small and as I
haven't re-based you can run:

        git diff -u guest-debug/4.1-v7..guest-debug/4.1-v8

And the kernelci report is at:

        http://kernelci.org/build/alex/kernel/v4.1-11-g182a5fa64600/


The only real changes apart from comments and white space are to
sys_regs which sees another minor re-factoring. The 32 bit handling
explicitly preserves the top 32 bits of the AArch64 registers although
I'm not convinced it matter too much as for a booting AArch32 guest
kernel they should start as 0 and never change.

For full details see the changelog on each of the patches.

GIT Repos:

The patches for this series are based off v4.1 and can be found
at:

Kernel:
https://git.linaro.org/people/alex.bennee/linux.git
branch: guest-debug/4.1-v8
describe: v4.1-11-g182a5faB

QEMU:
https://github.com/stsquad/qemu
branch: kvm/guest-debug-v6*** BLURB HERE ***

Alex Benn?e (11):
  KVM: add comments for kvm_debug_exit_arch struct
  KVM: arm64: guest debug, define API headers
  KVM: arm: guest debug, add stub KVM_SET_GUEST_DEBUG ioctl
  KVM: arm: introduce kvm_arm_init/setup/clear_debug
  KVM: arm64: guest debug, add SW break point support
  KVM: arm64: guest debug, add support for single-step
  KVM: arm64: re-factor hyp.S debug register code
  KVM: arm64: introduce vcpu->arch.debug_ptr
  KVM: arm64: guest debug, HW assisted debug support
  KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG
  KVM: arm64: add trace points for guest_debug debug

 Documentation/virtual/kvm/api.txt      |  15 +-
 arch/arm/include/asm/kvm_host.h        |   5 +
 arch/arm/kvm/arm.c                     |  18 +-
 arch/arm/kvm/guest.c                   |   6 +
 arch/arm64/include/asm/hw_breakpoint.h |  14 +
 arch/arm64/include/asm/kvm_asm.h       |  26 +-
 arch/arm64/include/asm/kvm_host.h      |  37 ++-
 arch/arm64/include/uapi/asm/kvm.h      |  27 ++
 arch/arm64/kernel/asm-offsets.c        |   7 +
 arch/arm64/kernel/hw_breakpoint.c      |  12 -
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/debug.c                 | 217 +++++++++++++
 arch/arm64/kvm/guest.c                 |  40 +++
 arch/arm64/kvm/handle_exit.c           |  44 +++
 arch/arm64/kvm/hyp.S                   | 544 ++++++++++-----------------------
 arch/arm64/kvm/reset.c                 |  16 +
 arch/arm64/kvm/sys_regs.c              | 291 ++++++++++++++++--
 arch/arm64/kvm/sys_regs.h              |   6 +
 arch/arm64/kvm/trace.h                 | 123 ++++++++
 include/uapi/linux/kvm.h               |   5 +
 20 files changed, 1001 insertions(+), 454 deletions(-)
 create mode 100644 arch/arm64/kvm/debug.c

-- 
2.4.5
