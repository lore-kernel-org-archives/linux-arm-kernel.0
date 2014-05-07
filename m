From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 May 2014 16:20:45 +0100
Subject: [PATCH 0/9] arm64: KVM: debug infrastructure support
Message-ID: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds debug support, a key feature missing from the
KVM/arm64 port.

The main idea is to keep track of whether the debug registers are
"dirty" (changed by the guest) or not. In this case, perform the usual
save/restore dance, for one run only. It means we only have a penalty
if a guest is actually using the debug registers.

The huge amount of registers is properly frightening, but CPUs
actually only implement a subset of them. Also, there is a number of
registers we don't bother emulating (things having to do with external
debug and OSlock).

This has been tested on a Cortex-A57 platform, running both 32 and
64bit guests, on top of 3.15-rc4. This code also lives in my tree in
the kvm-arm64/debug-trap branch.

Marc Zyngier (9):
  arm64: KVM: rename pm_fake handler to trap_wi_raz
  arm64: move DBG_MDSCR_* to asm/debug-monitors.h
  arm64: KVM: add trap handlers for AArch64 debug registers
  arm64: KVM: common infrastructure for handling AArch32 CP14/CP15
  arm64: KVM: use separate tables for AArch32 32 and 64bit traps
  arm64: KVM: check ordering of all system register tables
  arm64: KVM: add trap handlers for AArch32 debug registers
  arm64: KVM: implement lazy world switch for debug registers
  arm64: KVM: enable trapping of all debug registers

 arch/arm64/include/asm/debug-monitors.h |  19 +-
 arch/arm64/include/asm/kvm_asm.h        |  39 ++-
 arch/arm64/include/asm/kvm_coproc.h     |   3 +-
 arch/arm64/include/asm/kvm_host.h       |  12 +-
 arch/arm64/kernel/asm-offsets.c         |   1 +
 arch/arm64/kernel/debug-monitors.c      |   9 -
 arch/arm64/kvm/handle_exit.c            |   4 +-
 arch/arm64/kvm/hyp.S                    | 457 ++++++++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c               | 494 +++++++++++++++++++++++++++-----
 9 files changed, 940 insertions(+), 98 deletions(-)

-- 
1.8.3.4
