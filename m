From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 06 May 2015 11:30:34 +0100
Subject: [PATCH 3/7] ARM: keystone2: move address space switch printk into
 generic code
In-Reply-To: <20150506103000.GF2067@n2100.arm.linux.org.uk>
References: <20150506103000.GF2067@n2100.arm.linux.org.uk>
Message-ID: <E1Ypwb4-0000wT-VE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point platform code doing this, let's move it into the
generic code so it doesn't get duplicated.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-keystone/keystone.c | 3 ---
 arch/arm/mm/mmu.c                 | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index baa0fbc9803a..af8c92bc8188 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -93,9 +93,6 @@ static long long __init keystone_init_meminfo(void)
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
 
-	pr_info("Switching to high address space at 0x%llx\n",
-	        (u64)PHYS_OFFSET + (u64)offset);
-
 	return offset;
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 38ccbdf6c322..91262d28a4c9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1424,6 +1424,9 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	if (offset == 0)
 		return;
 
+	pr_info("Switching physical address space to 0x%08llx\n",
+		(u64)PHYS_OFFSET + offset);
+
 	/* Re-set the phys pfn offset, and the pv offset */
 	__pv_offset += offset;
 	__pv_phys_pfn_offset += PFN_DOWN(offset);
-- 
1.8.3.1
