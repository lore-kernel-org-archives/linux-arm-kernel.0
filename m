From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  7 Jul 2014 17:45:43 -0700
Subject: [PATCH] of: Use proper types for checking memory overflow
Message-ID: <1404780343-32188-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a67a6ed15513541579d38bcbd127e7be170710e5
(of: Check for phys_addr_t overflows in early_init_dt_add_memory_arch)
corrected early_init_dt_add_memory_arch to account for overflows
but did so in an unclean way using ULONG_MAX. There is no
guarantee that sizeof(unsigned long) == sizeof(phys_addr_t).
Check against phys_addr_t instead.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/of/fdt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b777d8f..b88a68e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -875,24 +875,24 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK
+#define MAX_PHYS_ADDR	((phys_addr_t)~0)
+
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = __pa(PAGE_OFFSET);
 	base &= PAGE_MASK;
 	size &= PAGE_MASK;
 
-	if (sizeof(phys_addr_t) < sizeof(u64)) {
-		if (base > ULONG_MAX) {
-			pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
-					base, base + size);
-			return;
-		}
+	if (base > MAX_PHYS_ADDR) {
+		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
+				base, base + size);
+		return;
+	}
 
-		if (base + size > ULONG_MAX) {
-			pr_warning("Ignoring memory range 0x%lx - 0x%llx\n",
-					ULONG_MAX, base + size);
-			size = ULONG_MAX - base;
-		}
+	if (base + size > MAX_PHYS_ADDR) {
+		pr_warning("Ignoring memory range 0x%lx - 0x%llx\n",
+				ULONG_MAX, base + size);
+		size = MAX_PHYS_ADDR - base;
 	}
 
 	if (base + size < phys_offset) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
