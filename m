From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:19 +0100
Subject: [PATCH 3/6] ARM: keystone2: move address space switch printk to
 generic code
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmXv-0006Wv-Q1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
index 71563fdf298c..657b50085942 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1424,6 +1424,9 @@ void __init early_paging_init(const struct machine_desc *mdesc,
 	if (offset == 0)
 		return;
 
+	pr_info("Switching physical address space to 0x%08llx\n",
+		(u64)PHYS_OFFSET + offset);
+
 	/* Re-set the phys pfn offset, and the pv offset */
 	__pv_offset = PHYS_OFFSET + offset - PAGE_OFFSET;
 	__pv_phys_pfn_offset = PFN_DOWN(PHYS_OFFSET + offset);
-- 
1.8.3.1
