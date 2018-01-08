From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Jan 2018 18:55:27 +0000
Subject: [PATCH v2 0/6] ARM branch predictor hardening
Message-ID: <20180108185533.9698-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series implements some basic BP hardening by invalidating
the BTB on CPUs that are known to be susceptible to aliasing attacks.

These patches are closely modelled against what we do on arm64,
although simpler as we can rely on an architected instruction to
perform the invalidation. The notable exception is Cortex-A15, where
BTB invalidation behaves like a NOP, and the only way to shoot the
predictor down is to invalidate the icache *and* to have ACTLR[0] set
to 1 (which is a secure-only operation).

The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
generalises it to be used on all affected CPUs. The second perform the
same invalidation on prefetch abort outside of the userspace
range. The third one nukes it on guest exit, and results in some major
surgery as we cannot take a branch from the vectors (that, and Thumb2
being a massive pain).

Patches 4 to 6 are doing a similar thing for Cortex-A15, which the
aforementioned ICIALLU.

Note 1: Contrary to the initial version, this new series relies on
the arm64/kpti branch (I reuse the per-CPU vector hook for KVM).

Note 2: M-class CPUs are not affected and for R-class cores, the
mitigation doesn't make much sense since we do not enforce user/kernel
isolation.

* From v1:
  - Fixed broken hyp_fiq vector (noticed by Ard)
  - Fixed broken BTB invalidation in LPAE switch_mm (reported by Andre)
  - Revamped invalidation on PABT (noticed by James on arm64,
    suggested by Will)
  - Rewrote the whole HYP sequence, as Thumb2 was pretty unhappy about
    arithmetic with the stack pointer

Marc Zyngier (6):
  arm: Add BTB invalidation on switch_mm for Cortex-A9, A12 and A17
  arm: Invalidate BTB on prefetch abort outside of user mapping on
    Cortex A8, A9, A12 and A17
  arm: KVM: Invalidate BTB on guest exit
  arm: Add icache invalidation on switch_mm for Cortex-A15
  arm: Invalidate icache on prefetch abort outside of user mapping on
    Cortex-A15
  arm: KVM: Invalidate icache on guest exit for Cortex-A15

 arch/arm/include/asm/cp15.h    |  3 ++
 arch/arm/include/asm/kvm_asm.h |  2 -
 arch/arm/include/asm/kvm_mmu.h | 17 +++++++-
 arch/arm/kvm/hyp/hyp-entry.S   | 89 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/fault.c            | 23 +++++++++++
 arch/arm/mm/fsr-2level.c       |  4 +-
 arch/arm/mm/fsr-3level.c       | 67 ++++++++++++++++++++++++++++++-
 arch/arm/mm/proc-v7-2level.S   | 14 ++++++-
 arch/arm/mm/proc-v7-3level.S   | 22 +++++++++++
 arch/arm/mm/proc-v7.S          | 48 +++++++++++++++--------
 10 files changed, 263 insertions(+), 26 deletions(-)

-- 
2.14.2
