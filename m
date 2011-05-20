From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 12:19:59 +0100
Subject: [PATCH 5/5] ARM: mm: allow ASID 0 to be allocated to tasks
In-Reply-To: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1305890399-29075-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ASID 0 is no longer used as a reserved value, allow it to be
allocated to tasks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 55041c1..2352395 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -94,7 +94,7 @@ static void reset_context(void *info)
 		return;
 
 	smp_rmb();
-	asid = cpu_last_asid + cpu + 1;
+	asid = cpu_last_asid + cpu;
 
 	flush_context();
 	set_mm_context(mm, asid);
@@ -143,13 +143,13 @@ void __new_context(struct mm_struct *mm)
 	 * to start a new version and flush the TLB.
 	 */
 	if (unlikely((asid & ~ASID_MASK) == 0)) {
-		asid = cpu_last_asid + smp_processor_id() + 1;
+		asid = cpu_last_asid + smp_processor_id();
 		flush_context();
 #ifdef CONFIG_SMP
 		smp_wmb();
 		smp_call_function(reset_context, NULL, 1);
 #endif
-		cpu_last_asid += NR_CPUS;
+		cpu_last_asid += NR_CPUS - 1;
 	}
 
 	set_mm_context(mm, asid);
-- 
1.7.0.4
