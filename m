From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:06 +0000
Subject: [PATCH 6/6] ARM: mm: truncate memory banks to fit in 4GB space for
 classic MMU
In-Reply-To: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
Message-ID: <1331052846-19144-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a bank of memory spanning the 4GB boundary is added on a !CONFIG_LPAE
kernel then we will hang early during boot since the memory bank will
have wrapped around to zero.

This patch truncates memory banks for !LPAE configurations when the end
address is not representable in 32 bits.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/setup.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a255c39..aeaa048 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -521,7 +521,16 @@ int __init arm_add_memory(phys_addr_t start, unsigned long size)
 	 */
 	size -= start & ~PAGE_MASK;
 	bank->start = PAGE_ALIGN(start);
-	bank->size  = size & PAGE_MASK;
+
+#ifndef CONFIG_LPAE
+	if (bank->start + size < bank->start) {
+		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
+			"32-bit physical address space\n", (long long)start);
+		size = ULONG_MAX - bank->start;
+	}
+#endif
+
+	bank->size = size & PAGE_MASK;
 
 	/*
 	 * Check whether this memory region has non-zero size or
-- 
1.7.4.1
