From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:34:55 -0400
Subject: [PATCH 04/15] ARM: idmap: only initialize HYP idmap when HYP mode is
 available
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120915153455.21241.27798.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/idmap.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 7a944af..95e8d67 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -8,6 +8,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/system_info.h>
+#include <asm/virt.h>
 
 pgd_t *idmap_pgd;
 
@@ -149,6 +150,9 @@ EXPORT_SYMBOL_GPL(hyp_idmap_setup);
 
 static int __init hyp_init_static_idmap(void)
 {
+	if (!is_hyp_mode_available())
+		return 0;
+
 	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!hyp_pgd)
 		return -ENOMEM;
