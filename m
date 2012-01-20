From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2012 17:42:29 +0000
Subject: [PATCH v3 3/6] ARM: Allow ASID 0 to be allocated to tasks
In-Reply-To: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
References: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1327081352-13178-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Now that ASID 0 is no longer used as a reserved value, allow it to be
allocated to tasks.

Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/context.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 97842a0..efa413a 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -118,7 +118,7 @@ static void reset_context(void *info)
 		return;
 
 	smp_rmb();
-	asid = cpu_last_asid + cpu + 1;
+	asid = cpu_last_asid + cpu;
 
 	flush_context();
 	set_mm_context(mm, asid);
@@ -167,13 +167,13 @@ void __new_context(struct mm_struct *mm)
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
