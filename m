From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:54 +0200
Subject: [PATCH v3 10/11] arm64: allow kernel Image to be loaded anywhere in
 physical memory
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This relaxes the kernel Image placement requirements, so that it
may be placed at any 2 MB aligned offset in physical memory.

This is accomplished by ignoring PHYS_OFFSET when installing
memblocks, and accounting for the apparent virtual offset of
the kernel Image (in addition to the 64 MB that is is moved
below PAGE_OFFSET). As a result, virtual address references
below PAGE_OFFSET are correctly mapped onto physical references
into the kernel Image regardless of where it sits in memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 17 +++++++----------
 arch/arm64/mm/init.c            | 32 +++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 6396460f6085..811d93548bdc 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -110,16 +110,13 @@ Header notes:
   depending on selected features, and is effectively unbound.
 
 The Image must be placed text_offset bytes from a 2MB aligned base
-address near the start of usable system RAM and called there. Memory
-below that base address is currently unusable by Linux, and therefore it
-is strongly recommended that this location is the start of system RAM.
-At least image_size bytes from the start of the image must be free for
-use by the kernel.
-
-Any memory described to the kernel (even that below the 2MB aligned base
-address) which is not marked as reserved from the kernel e.g. with a
-memreserve region in the device tree) will be considered as available to
-the kernel.
+address anywhere in usable system RAM and called there. At least
+image_size bytes from the start of the image must be free for use
+by the kernel.
+
+Any memory described to the kernel which is not marked as reserved from
+the kernel e.g. with a memreserve region in the device tree) will be
+considered as available to the kernel.
 
 Before jumping into the kernel, the following conditions must be met:
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 48175b769074..18234c7cf6e6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -375,8 +375,6 @@ __setup("keepinitrd", keepinitrd_setup);
 
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	const u64 phys_offset = __pa(PAGE_OFFSET);
-
 	if (!PAGE_ALIGNED(base)) {
 		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
 			pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
@@ -388,16 +386,24 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 	size &= PAGE_MASK;
 
-	if (base + size < phys_offset) {
-		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
-			   base, base + size);
-		return;
-	}
-	if (base < phys_offset) {
-		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
-			   base, phys_offset);
-		size -= phys_offset - base;
-		base = phys_offset;
-	}
 	memblock_add(base, size);
+
+	/*
+	 * Set memstart_addr to the base of the lowest physical memory region,
+	 * rounded down to PUD/PMD alignment so we can map it efficiently.
+	 * Since this also affects the apparent offset of the kernel image in
+	 * the virtual address space, increase image_offset by the same amount
+	 * that we decrease memstart_addr.
+	 */
+	if (!memstart_addr || memstart_addr > base) {
+		u64 new_memstart_addr;
+
+		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
+			new_memstart_addr = base & PMD_MASK;
+		else
+			new_memstart_addr = base & PUD_MASK;
+
+		image_offset += memstart_addr - new_memstart_addr;
+		memstart_addr = new_memstart_addr;
+	}
 }
-- 
1.8.3.2
