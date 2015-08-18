From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Aug 2015 11:34:41 +0200
Subject: [PATCH 1/2] of/fdt: make memblock maximum physical address arch
 configurable
In-Reply-To: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1439890482-20798-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When parsing the memory nodes to populate the memblock memory
table, we check against high and low limits and clip any memory
that exceeds either one of them.

However, for arm64, the high limit of (phys_addr_t)~0 is not very
meaningful, since phys_addr_t is 64 bits (i.e., no limit) but there
may be other constraints that limit the memory ranges that we can
support.

So rename MAX_PHYS_ADDR to MAX_MEMBLOCK_ADDR (for clarity) and only
define it if the arch does not supply a definition of its own.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/of/fdt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 07496560e5b9..6e82bc42373b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -967,7 +967,9 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK
-#define MAX_PHYS_ADDR	((phys_addr_t)~0)
+#ifndef MAX_MEMBLOCK_ADDR
+#define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
+#endif
 
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
@@ -984,16 +986,16 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 	size &= PAGE_MASK;
 
-	if (base > MAX_PHYS_ADDR) {
+	if (base > MAX_MEMBLOCK_ADDR) {
 		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
 				base, base + size);
 		return;
 	}
 
-	if (base + size - 1 > MAX_PHYS_ADDR) {
+	if (base + size - 1 > MAX_MEMBLOCK_ADDR) {
 		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
-				((u64)MAX_PHYS_ADDR) + 1, base + size);
-		size = MAX_PHYS_ADDR - base + 1;
+				((u64)MAX_MEMBLOCK_ADDR) + 1, base + size);
+		size = MAX_MEMBLOCK_ADDR - base + 1;
 	}
 
 	if (base + size < phys_offset) {
-- 
1.9.1
