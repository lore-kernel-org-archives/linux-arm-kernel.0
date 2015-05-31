From: zhichao.huang@linaro.org (Zhichao Huang)
Date: Sun, 31 May 2015 12:27:01 +0800
Subject: [PATCH v2 00/11] KVM: arm: debug infrastructure support
Message-ID: <1433046432-1824-1-git-send-email-zhichao.huang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds debug support, a key feature missing from the
KVM/armv7 port.

The main idea is borrowed from armv8, which is to keep track of whether 
the debug registers are "dirty" (changed by the guest) or not. In this 
case, perform the usual save/restore dance, for one run only. It means 
we only have a penalty if a guest is actively using the debug registers.

The amount of registers is properly frightening, but CPUs actually
only implement a subset of them. Also, there is a number of registers
we don't bother emulating (things having to do with external debug and
OSlock).

External debug is when you actually plug a physical JTAG into the CPU.
OSlock is a way to prevent "other software" to play with the debug
registers. My understanding is that it is only useful in combination
with the external debug. In both case, implementing support for this
is probably not worth the effort, at least for the time being.

This has been tested on a Cortex-A15 platform, running 32bit guests.

The patches for this series are based off v4.1-rc5 and can be found
at:

https://git.linaro.org/people/zhichao.huang/linux.git
branch: guest-debug/4.1-rc5-v2

>From v1 [1]:
- Added missing cp14 reset functions
- Disable debug mode if we don't need it to reduce unnecessary switch

[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2015-May/014729.html

Zhichao Huang (11):
  KVM: arm: plug guest debug exploit
  KVM: arm: rename pm_fake handler to trap_raz_wi
  KVM: arm: enable to use the ARM_DSCR_MDBGEN macro from KVM assembly
    code
  KVM: arm: common infrastructure for handling AArch32 CP14/CP15
  KVM: arm: check ordering of all system register tables
  KVM: arm: add trap handlers for 32-bit debug registers
  KVM: arm: add trap handlers for 64-bit debug registers
  KVM: arm: implement dirty bit mechanism for debug registers
  KVM: arm: disable debug mode if we don't actually need it.
  KVM: arm: implement lazy world switch for debug registers
  KVM: arm: enable trapping of all debug registers

 arch/arm/include/asm/hw_breakpoint.h |  54 ++---
 arch/arm/include/asm/kvm_asm.h       |  15 ++
 arch/arm/include/asm/kvm_coproc.h    |   3 +-
 arch/arm/include/asm/kvm_host.h      |   6 +
 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm/kernel/hw_breakpoint.c      |  55 ++++-
 arch/arm/kvm/coproc.c                | 386 +++++++++++++++++++++++++++++------
 arch/arm/kvm/handle_exit.c           |   4 +-
 arch/arm/kvm/interrupts.S            |  16 ++
 arch/arm/kvm/interrupts_head.S       | 313 +++++++++++++++++++++++++++-
 10 files changed, 757 insertions(+), 97 deletions(-)

-- 
1.7.12.4
