From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Jan 2018 12:09:04 +0000
Subject: [PATCH 0/3] ARM branch predictor hardening
Message-ID: <20180106120907.26701-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series implements some basic BP hardening by invalidating
the BTB on CPUs that are known to be susceptible to aliasing attacks.

These patches are closely modelled against what we do on arm64,
although simpler as we can rely on an architected instruction to
perform the invalidation.

The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
generalises it to be used on all affected CPUs. The second perform the
same invalidation on fatal signal delivery. The last one nukes it on
guest exit, and results in some major surgery (kudos to Dimitris
Papastamos who came up with the magic vector decoding sequence).

Note that that M-class CPUs are not affected and for R-class cores,
the mitigation doesn't make much sense since we do not enforce
user/kernel isolation.

Marc Zyngier (3):
  arm: Add BTB invalidation on switch_mm for Cortex-A9, A12, A15 and A17
  arm: Invalidate BTB on fatal signal for Cortex A8, A9, A12, A15 and
    A17
  arm: KVM: Invalidate BTB on guest exit

 arch/arm/include/asm/cp15.h  |  2 ++
 arch/arm/kvm/hyp/hyp-entry.S | 74 +++++++++++++++++++++++++++++++++++++-------
 arch/arm/mm/fault.c          | 11 +++++++
 arch/arm/mm/proc-v7-2level.S |  4 +--
 arch/arm/mm/proc-v7-3level.S |  6 ++++
 arch/arm/mm/proc-v7.S        | 32 +++++++++----------
 6 files changed, 100 insertions(+), 29 deletions(-)

-- 
2.14.2
