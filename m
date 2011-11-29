From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Nov 2011 12:22:29 +0000
Subject: [RFC PATCH 3/6] ARM: Allow ASID 0 to be allocated to tasks
In-Reply-To: <1322569352-23584-1-git-send-email-catalin.marinas@arm.com>
References: <1322569352-23584-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1322569352-23584-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Now that ASID 0 is no longer used as a reserved value, allow it to be
allocated to tasks.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/context.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index a062230..1d5014b 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -100,7 +100,7 @@ static void reset_context(void *info)
 		return;
 
 	smp_rmb();
-	asid = cpu_last_asid + cpu + 1;
+	asid = cpu_last_asid + cpu;
 
 	flush_context();
 	set_mm_context(mm, asid);
@@ -149,13 +149,13 @@ void __new_context(struct mm_struct *mm)
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
