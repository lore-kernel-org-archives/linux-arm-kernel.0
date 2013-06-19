From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 13:44:51 +0100
Subject: [PATCH 1/3] ARM: let the ASID allocator handle suspended animation
In-Reply-To: <1371645893-7630-1-git-send-email-marc.zyngier@arm.com>
References: <1371645893-7630-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371645893-7630-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is running a process, the ASID for that process is
held in a per-CPU variable (the "active ASIDs" array). When
the ASID allocator handles a rollover, it copies the active
ASIDs into a "reserved ASIDs" array to ensure that a process
currently running on another CPU will continue to run unaffected.
The active array is zero-ed to indicate that a rollover occurred.

Because of this mechanism, a reserved ASID is only remembered for
a single rollover. A subsequent rollover will completely refill
the reserved ASIDs array.

In a severely oversubscribed environment where a CPU can be
prevented from running for extended periods of time (think virtual
machines), the above has a horrible side effect:

[P{a} denotes process P running with ASID a]

	CPU-0		CPU-1

	A{x}				[active = <x 0>]

	[suspended]	runs B{y}	[active = <x y>]

					[rollover:
					 active = <0 0>
					 reserved = <x y>]

			runs B{y}	[active = <0 y>
					 reserved = <x y>]

					[rollover:
					 active = <0 0>
					 reserved = <0 y>]

			runs C{x}	[active = <0 x>]

	[resumes]

	runs A{x}

At that stage, both A and C have the same ASID, with deadly
consequences.

The fix is to preserve reserved ASIDs across rollovers if
the CPU doesn't have an active ASID when the rollover occurs.

Cc: <stable@vger.kernel.org> # 3.9
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Carinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/context.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 2ac3737..8e12fcb 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -128,6 +128,15 @@ static void flush_context(unsigned int cpu)
 			asid = 0;
 		} else {
 			asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
+			/*
+			 * If this CPU has already been through a
+			 * rollover, but hasn't run another task in
+			 * the meantime, we must preserve its reserved
+			 * ASID, as this is the only trace we have of
+			 * the process it is still running.
+			 */
+			if (asid == 0)
+				asid = per_cpu(reserved_asids, i);
 			__set_bit(ASID_TO_IDX(asid), asid_map);
 		}
 		per_cpu(reserved_asids, i) = asid;
-- 
1.8.2.3
