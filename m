From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 12:44:43 -0400
Subject: [PATCH v2 3/6] ARM: mm: Move the idmap print to appropriate place in
 the code
In-Reply-To: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375289086-5315-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9e9a367c29cebd2 {ARM: Section based HYP idmap} moved
the address conversion inside identity_mapping_add() without
respective print which carries useful idmap information.

Move the print as well inside identity_mapping_add() to
fix the same.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/idmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index c0a1e48..8e0e52e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -70,6 +70,7 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 
 	addr = virt_to_idmap(text_start);
 	end = virt_to_idmap(text_end);
+	pr_info("Setting up static identity map for 0x%lx - 0x%lx\n", addr, end);
 
 	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
 
@@ -91,8 +92,6 @@ static int __init init_static_idmap(void)
 	if (!idmap_pgd)
 		return -ENOMEM;
 
-	pr_info("Setting up static identity map for 0x%p - 0x%p\n",
-		__idmap_text_start, __idmap_text_end);
 	identity_mapping_add(idmap_pgd, __idmap_text_start,
 			     __idmap_text_end, 0);
 
-- 
1.7.9.5
