From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 15:52:58 +0000
Subject: [PATCH v5 3/8] ARM: idmap: populate identity map pgd at init time
In-Reply-To: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
References: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
Message-ID: <1320767583-21162-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling the MMU, it is necessary to take out an identity mapping
for as much of the address space as possible so that the reset path can
be executed using its physical address. This is useful for softbooting
and entering low power states.

This patch allocates a set of pagetables during boot and populates them
with an identity mapping for all of memory apart from a small window
containing the kernel image.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/idmap.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 296ad2e..24f6cf3 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -3,6 +3,9 @@
 #include <asm/cputype.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
+
+static pgd_t *idmap_pgd;
 
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long prot)
@@ -73,6 +76,21 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
 }
 #endif
 
+static int __init init_static_idmap(void)
+{
+	unsigned long kernel_end = ALIGN((unsigned long)_end, PMD_SIZE);
+
+	idmap_pgd = pgd_alloc(&init_mm);
+	if (!idmap_pgd)
+		return -ENOMEM;
+
+	identity_mapping_add(idmap_pgd, 0, TASK_SIZE);
+	identity_mapping_add(idmap_pgd, kernel_end, 0);
+
+	return 0;
+}
+arch_initcall(init_static_idmap);
+
 /*
  * In order to soft-boot, we need to insert a 1:1 mapping in place of
  * the user-mode pages.  This will then ensure that we have predictable
-- 
1.7.4.1
