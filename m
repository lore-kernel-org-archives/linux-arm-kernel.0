From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:28 -0400
Subject: [RFC/PATCH 1/7] ARM: ARM11 MPCore: pgd_alloc is not preempt safe
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-2-git-send-email-gdavis@mvista.com>
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
index b2027c1..6f6213e 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -14,6 +14,7 @@
 #include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -31,6 +32,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (!new_pgd)
 		goto no_pgd;
 
+	if (cache_ops_need_broadcast())
+		get_cpu();
+
 	memset(new_pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 
 	/*
@@ -42,6 +46,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
 
+	if (cache_ops_need_broadcast())
+		put_cpu();
+
 	if (!vectors_high()) {
 		/*
 		 * On ARM, first page must always be allocated since it
-- 
1.7.4.4
