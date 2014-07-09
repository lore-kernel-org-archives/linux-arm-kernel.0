From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  9 Jul 2014 18:12:52 +0100
Subject: [PATCH v4 0/9] arm64: KVM: debug infrastructure support
Message-ID: <1404925981-17561-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds debug support, a key feature missing from the
KVM/arm64 port.

The main idea is to keep track of whether the debug registers are
"dirty" (changed by the guest) or not. In this case, perform the usual
save/restore dance, for one run only. It means we only have a penalty
if a guest is actively using the debug registers.

The amount of registers is properly frightening, but CPUs actually
only implement a subset of them. Also, there is a number of registers
we don't bother emulating (things having to do with external debug and
OSlock).

External debug is when you actually plug a physical JTAG into the CPU.
OSlock is a way to prevent "other software" to play with the debug
registers. My understanding is that it is only useful in combination
with the external debug. In both case, implementing support for this
is probably not worth the effort, at least for the time being.

This has been tested on a Cortex-A53/A57 platform, running both 32 and
64bit guests, on top of 3.16-rc1. This code also lives in my tree in
the kvm-arm/debug-merge-3.17 branch (containing GICv3 and BE patches),
which I consider to be a stable branch, ready to be merged.

>From v3 [3]:
- Clearer comments about the way we deal with the dirty bit
- Additional comment about future use of the per-vcpu debug flags
- Added missing Reviewed-by tags
- Rebased on top of the branch from hell (GICv3+BE)

>From v2 [2]:
- Fixed a number of very stupid bugs in the macros generating the trap
  entries
- Added some documentation explaining why we don't bother emulating
  external debug and the OSlock stuff
- Other bits of documentation here and there

>From v1 [1]:
- Renamed trap_wi_raz to trap_raz_wi
- Renamed skip_clean_debug_state to skip_debug_state
- Simplified debug state computing, moved to its own macro
- Added some comment to make the logic more obvious

[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009332.html
[2]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009534.html
[3]: https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010124.html

Marc Zyngier (9):
  arm64: KVM: rename pm_fake handler to trap_raz_wi
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
 arch/arm64/include/asm/kvm_host.h       |  16 +-
 arch/arm64/kernel/asm-offsets.c         |   1 +
 arch/arm64/kernel/debug-monitors.c      |   9 -
 arch/arm64/kvm/handle_exit.c            |   4 +-
 arch/arm64/kvm/hyp.S                    | 471 +++++++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c               | 533 ++++++++++++++++++++++++++++----
 9 files changed, 994 insertions(+), 101 deletions(-)

-- 
2.0.0
