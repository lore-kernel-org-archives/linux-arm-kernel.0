From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Mar 2011 15:38:18 +0000
Subject: [PATCH 2/2] ARM: perf: add required isbs() to ARMv7 backend
In-Reply-To: <1300289898-2720-1-git-send-email-will.deacon@arm.com>
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>
Message-ID: <1300289898-2720-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv7 architecture does not guarantee that effects from co-processor
writes are immediately visible to following instructions.

This patch adds two isbs to the ARMv7 perf code:

(1) Immediately after selecting an event register, so that the PMU state
    following this instruction is consistent with the new event.

(2) Immediately before writing to the PMCR, so that any previous writes
    to the PMU have taken effect before (typically) enabling the
    counters.

Cc: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 3f42473..a79a7b6 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -466,6 +466,7 @@ static inline unsigned long armv7_pmnc_read(void)
 static inline void armv7_pmnc_write(unsigned long val)
 {
 	val &= ARMV7_PMNC_MASK;
+	isb();
 	asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r"(val));
 }
 
@@ -502,6 +503,7 @@ static inline int armv7_pmnc_select_counter(unsigned int idx)
 
 	val = (idx - ARMV7_EVENT_CNT_TO_CNTx) & ARMV7_SELECT_MASK;
 	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (val));
+	isb();
 
 	return idx;
 }
-- 
1.7.0.4
