From: clingutla@codeaurora.org (Lingutla Chandrasekhar)
Date: Fri, 19 Jan 2018 12:26:37 +0530
Subject: [PATCH] arm64: setup: Check for overlapping dtb and Image load
 addresses
Message-ID: <20180119065637.12789-1-clingutla@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometime kernel image and dtb load offsets can overlap due to
dynamically increased Image or dtb size if both load addresses
are near to each other, which leads to bootup failures.

So validate dtb load address and kernel image, if they overlap
do not proceed to boot.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..c9dd699f09ab 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -181,11 +181,17 @@ static void __init smp_build_mpidr_hash(void)
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	void *dt_virt = fixmap_remap_fdt(dt_phys);
+	u64 end_phys = __pa_symbol(_end);
+	u64 start_phys = __pa_symbol(_text);
 	const char *name;
 
-	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
+	if (!dt_virt || ((dt_phys < start_phys) &&
+		((dt_phys + fdt_totalsize(dt_virt)) > start_phys)) ||
+		((dt_phys > start_phys) && (dt_phys < end_phys)) ||
+		!early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob@physical address %pa (virtual address 0x%p)\n"
+			"The dtb load address should not overlap with kernel image\n"
 			"The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
 			"\nPlease check your bootloader.",
 			&dt_phys, dt_virt);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.
