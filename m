From: vitalya@ti.com (Vitaly Andrianov)
Date: Tue, 2 Jun 2015 10:14:30 -0400
Subject: [PATCH] ARM: mm: use virt_to_idmap to get phys_reset address
Message-ID: <1433254470-26507-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to get correct physical address of the reset function for
PAE systems, which use aliased physical memory for booting.

See the "ARM: mm: Introduce virt_to_idmap() with an arch hook" for details.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/kernel/reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 1a4d232..3826935 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -50,7 +50,7 @@ static void __soft_restart(void *addr)
 	flush_cache_all();
 
 	/* Switch to the identity mapping. */
-	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_idmap(cpu_reset);
 	phys_reset((unsigned long)addr);
 
 	/* Should never get here. */
-- 
1.9.1
