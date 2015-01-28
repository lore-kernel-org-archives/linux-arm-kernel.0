From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:11 +0100
Subject: [PATCH 04/15] ARM: fix LPAE build without ARM_PATCH_PHYS_VIRT
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We may want to disable ARM_PATCH_PHYS_VIRT on kernels
using LPAE, but currently the early_paging_init() function
unconditionally calls fixup_pv_table().

This patch encloses the call to fixup_pv_table in an #ifdef,
mirroring what we do for normal (non-LPAE) mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4e6ef896c619..235aed5f8284 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1422,8 +1422,10 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	mdesc->init_meminfo();
 
 	/* Run the patch stub to update the constants */
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 	fixup_pv_table(&__pv_table_begin,
 		(&__pv_table_end - &__pv_table_begin) << 2);
+#endif
 
 	/*
 	 * Cache cleaning operations for self-modifying code
-- 
2.1.0.rc2
