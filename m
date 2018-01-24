From: clingutla@codeaurora.org (Lingutla Chandrasekhar)
Date: Wed, 24 Jan 2018 14:53:45 +0530
Subject: [PATCH v1] arm64: setup: Check for overlapping dtb and Image load
 addresses
Message-ID: <20180124092345.5072-1-clingutla@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometime kernel image and dtb load offsets can overlap due to
dynamically increased Image or dtb size if both load addresses
are near to each other, which leads to bootup failures.

So validate dtb load address and kernel image, if they overlap
do not proceed to boot.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
---

Changes since v0:
- Print overlap bytes.
- Simplify ovelap checks.

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..fd9be0ad4a78 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -181,14 +181,21 @@ static void __init smp_build_mpidr_hash(void)
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	u64 end_phys = __pa_symbol(_end);
+	u64 start_phys = __pa_symbol(_text);
 	const char *name;
 
-	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
-		pr_crit("\n"
-			"Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
+	if (!dt_virt || (end_phys > dt_phys &&
+		(dt_phys + fdt_totalsize(dt_virt)) > start_phys) ||
+		!early_init_dt_scan(dt_virt)) {
+		pr_crit("Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
 			"The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
+			"The dtb load address overllaped %lld bytes with kernel image\n"
 			"\nPlease check your bootloader.",
-			&dt_phys, dt_virt);
+			&dt_phys, dt_virt,
+			(dt_phys < start_phys) ?
+			(dt_phys + fdt_totalsize(dt_virt) - start_phys) :
+			(end_phys - dt_phys));
 
 		while (true)
 			cpu_relax();
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.
