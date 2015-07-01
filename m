From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  1 Jul 2015 19:28:52 +0100
Subject: [PATCH v7 00/11] KVM Guest Debug support for arm64
Message-ID: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is V7 of the KVM Guest Debug support for arm64.

The fixes are fairly minor aside from the re-factoring of sys_regs.c
to have individual trap functions for each debug register. There is a
lot of boiler plate but it does make the ugliness of the previous
offset hacks go away.

On top of that I've fixed some build failures on v7 which were not
apparent on my defconfig build. I've also been helped with
kernelci.org doing the heavy lifting for me:

    http://kernelci.org/boot/all/job/alex/

For full details see the changelog on each of the patches.

GIT Repos:

The patches for this series are based off v4.1 and can be found
at:

Kernel:
https://git.linaro.org/people/alex.bennee/linux.git
branch: guest-debug/4.1-v7
describe: v4.1-11-g2a10438

QEMU:
https://github.com/stsquad/qemu
branch: kvm/guest-debug-v6


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
 arch/arm/include/asm/kvm_host.h        |   4 +
 arch/arm/kvm/arm.c                     |  18 +-
 arch/arm/kvm/guest.c                   |   6 +
 arch/arm64/include/asm/hw_breakpoint.h |   4 +
 arch/arm64/include/asm/kvm_asm.h       |  26 +-
 arch/arm64/include/asm/kvm_host.h      |  37 ++-
 arch/arm64/include/uapi/asm/kvm.h      |  27 ++
 arch/arm64/kernel/asm-offsets.c        |   7 +
 arch/arm64/kernel/hw_breakpoint.c      |   4 +-
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/debug.c                 | 216 +++++++++++++
 arch/arm64/kvm/guest.c                 |  40 +++
 arch/arm64/kvm/handle_exit.c           |  44 +++
 arch/arm64/kvm/hyp.S                   | 544 ++++++++++-----------------------
 arch/arm64/kvm/reset.c                 |  15 +
 arch/arm64/kvm/sys_regs.c              | 299 ++++++++++++++++--
 arch/arm64/kvm/sys_regs.h              |   6 +
 arch/arm64/kvm/trace.h                 | 123 ++++++++
 include/uapi/linux/kvm.h               |   5 +
 20 files changed, 996 insertions(+), 446 deletions(-)
 create mode 100644 arch/arm64/kvm/debug.c

-- 
2.4.5
