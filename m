From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 12 Jun 2012 16:40:12 -0400
Subject: [RFC/PATCH v5 1/7] ARM: ARM11 MPCore: Make pgd_alloc preempt safe
In-Reply-To: <1339533618-15969-1-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
Message-ID: <1339533618-15969-2-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Konstantin Baidarov <kbaidarov@mvista.com>

If preemption and subsequent task migration occurs during a call to
pgd_alloc on ARM11 MPCore machines, global memory state can become
inconsistent.  To prevent inconsistent memory state on these
machines, disable preemption around initialization and flushing
of new PGDs.

Signed-off-by: Konstantin Baidarov <kbaidarov@mvista.com>
Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/mm/pgd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 0acb089..174b387 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -16,6 +16,7 @@
 #include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -41,6 +42,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (!new_pgd)
 		goto no_pgd;
 
+	if (cache_ops_need_broadcast())
+		preempt_disable();
+
 	memset(new_pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 
 	/*
@@ -52,6 +56,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
 
+	if (cache_ops_need_broadcast())
+		preempt_enable();
+
 #ifdef CONFIG_ARM_LPAE
 	/*
 	 * Allocate PMD table for modules and pkmap mappings.
-- 
1.7.4.4
