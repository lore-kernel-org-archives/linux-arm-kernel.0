From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Dec 2015 10:53:16 +0000
Subject: [PATCH v3 00/22] arm64: KVM: Rewriting the world switch in C
Message-ID: <1449485618-9443-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once upon a time, the KVM/arm64 world switch was a nice, clean, lean
and mean piece of hand-crafted assembly code. Over time, features have
crept in, the code has become harder to maintain, and the smallest
change is a pain to introduce. The VHE patches are a prime example of
why this doesn't work anymore.

This series rewrites most of the existing assembly code in C, but keeps
the existing code structure in place (most function names will look
familiar to the reader). The biggest change is that we don't have to
deal with a static register allocation (the compiler does it for us),
we can easily follow structure and pointers, and only the lowest level
is still in assembly code. Oh, and a negative diffstat.

There is still a healthy dose of inline assembly (system register
accessors, runtime code patching), but I've tried not to make it too
invasive. The generated code, while not exactly brilliant, doesn't
look too shaby. I do expect a small performance degradation, but I
believe this is something we can improve over time (my initial
measurements don't show any obvious regression though).

Assuming people are happy with the general approach taken here, I plan
to rewrite the 32bit version in a similar vein, and reuse some parts
of that code.

Patches are against 4.4-rc4 (mostly), and I've pushed a branch out
(kvm-arm64/wsinc). This has been tested on Juno, Seattle and the FVP
model. I also have pushed out kvm-arm64/vhe-wsinc that implements VHE
on top of these patches.

* From v2:
  - Extensive review by Christoffer (thanks!)
  - Reuse the LR indexing macro used by the vgic-v3 layer
  - Plenty of comments added to the code

* From v1:
  - A number of bugs have been squashed: vgic, FP/SIMD, debug, panic
    (thanks to Mark, Steve, Ard and Alex for their reviews)
  - Rebased on 4.4-rc2 plus KVM fixes aimed at -rc3 plus a couple
    of gic-v3 fixes

Marc Zyngier (21):
  arm64: KVM: Add a HYP-specific header file
  arm64: KVM: Implement vgic-v2 save/restore
  KVM: arm/arm64: vgic-v3: Make the LR indexing macro public
  arm64: KVM: Implement vgic-v3 save/restore
  arm64: KVM: Implement timer save/restore
  arm64: KVM: Implement system register save/restore
  arm64: KVM: Implement 32bit system register save/restore
  arm64: KVM: Implement debug save/restore
  arm64: KVM: Implement guest entry
  arm64: KVM: Add patchable function selector
  arm64: KVM: Implement the core world switch
  arm64: KVM: Implement fpsimd save/restore
  arm64: KVM: Implement TLB handling
  arm64: KVM: HYP mode entry points
  arm64: KVM: Add panic handling
  arm64: KVM: Add compatibility aliases
  arm64: KVM: Map the kernel RO section into HYP
  arm64: KVM: Move away from the assembly version of the world switch
  arm64: KVM: Turn system register numbers to an enum
  arm64: KVM: Cleanup asm-offset.c
  arm64: KVM: Remove weak attributes

Mark Rutland (1):
  arm64: Add macros to read/write system registers

 arch/arm/kvm/arm.c                   |    7 +
 arch/arm64/include/asm/kvm_asm.h     |   76 ---
 arch/arm64/include/asm/kvm_emulate.h |    1 -
 arch/arm64/include/asm/kvm_host.h    |   81 ++-
 arch/arm64/include/asm/kvm_mmio.h    |    1 -
 arch/arm64/include/asm/sysreg.h      |   17 +
 arch/arm64/kernel/asm-offsets.c      |   40 +-
 arch/arm64/kvm/Makefile              |    3 +-
 arch/arm64/kvm/guest.c               |    1 -
 arch/arm64/kvm/handle_exit.c         |    1 +
 arch/arm64/kvm/hyp.S                 | 1081 +---------------------------------
 arch/arm64/kvm/hyp/Makefile          |   14 +
 arch/arm64/kvm/hyp/debug-sr.c        |  140 +++++
 arch/arm64/kvm/hyp/entry.S           |  161 +++++
 arch/arm64/kvm/hyp/fpsimd.S          |   33 ++
 arch/arm64/kvm/hyp/hyp-entry.S       |  212 +++++++
 arch/arm64/kvm/hyp/hyp.h             |   90 +++
 arch/arm64/kvm/hyp/switch.c          |  175 ++++++
 arch/arm64/kvm/hyp/sysreg-sr.c       |  138 +++++
 arch/arm64/kvm/hyp/timer-sr.c        |   72 +++
 arch/arm64/kvm/hyp/tlb.c             |   80 +++
 arch/arm64/kvm/hyp/vgic-v2-sr.c      |   84 +++
 arch/arm64/kvm/hyp/vgic-v3-sr.c      |  228 +++++++
 arch/arm64/kvm/sys_regs.c            |    1 +
 arch/arm64/kvm/vgic-v2-switch.S      |  134 -----
 arch/arm64/kvm/vgic-v3-switch.S      |  269 ---------
 include/clocksource/arm_arch_timer.h |    6 +
 include/kvm/arm_vgic.h               |    6 +
 virt/kvm/arm/vgic-v3.c               |   11 +-
 29 files changed, 1551 insertions(+), 1612 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/Makefile
 create mode 100644 arch/arm64/kvm/hyp/debug-sr.c
 create mode 100644 arch/arm64/kvm/hyp/entry.S
 create mode 100644 arch/arm64/kvm/hyp/fpsimd.S
 create mode 100644 arch/arm64/kvm/hyp/hyp-entry.S
 create mode 100644 arch/arm64/kvm/hyp/hyp.h
 create mode 100644 arch/arm64/kvm/hyp/switch.c
 create mode 100644 arch/arm64/kvm/hyp/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/timer-sr.c
 create mode 100644 arch/arm64/kvm/hyp/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/vgic-v2-sr.c
 create mode 100644 arch/arm64/kvm/hyp/vgic-v3-sr.c
 delete mode 100644 arch/arm64/kvm/vgic-v2-switch.S
 delete mode 100644 arch/arm64/kvm/vgic-v3-switch.S

-- 
2.1.4
