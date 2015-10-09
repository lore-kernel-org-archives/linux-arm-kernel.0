From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri,  9 Oct 2015 23:55:09 +0800
Subject: [RFC] arm: add relocate initrd support
Message-ID: <1444406109-28354-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for initrd on ARM arch, in case
mem= boot option change the memory size or the initrd are
not placed in low memory region, we need copy the initrd
to low memory region.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm/include/asm/fixmap.h |  1 +
 arch/arm/kernel/setup.c       | 72 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 58cfe9f..18ad90f 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -10,6 +10,7 @@
 
 enum fixed_addresses {
 	FIX_EARLYCON_MEM_BASE,
+	FIX_RELOCATE_INITRD,
 	__end_of_permanent_fixed_addresses,
 
 	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd34..4260d59 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -811,6 +811,77 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 		request_resource(&ioport_resource, &lp2);
 }
 
+#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_MMU)
+/*
+ * Relocate initrd if it is not completely within the linear mapping.
+ * This would be the case if mem= cuts out all or part of it
+ * or the initrd are not in low mem region place.
+ */
+static void __init relocate_initrd(void)
+{
+	phys_addr_t orig_start = __virt_to_phys(initrd_start);
+	phys_addr_t orig_end = __virt_to_phys(initrd_end);
+	phys_addr_t ram_end = memblock_end_of_DRAM();
+	phys_addr_t new_start;
+	phys_addr_t src;
+	unsigned long size, to_free = 0;
+	unsigned long slop, clen, p;
+	void *dest;
+
+	if (orig_end <= memblock_get_current_limit())
+		return;
+
+	/*
+	 * Any of the original initrd which overlaps the linear map should
+	 * be freed after relocating.
+	 */
+	if (orig_start < ram_end)
+		to_free = min(ram_end, orig_end) - orig_start;
+
+	size = orig_end - orig_start;
+
+	/* initrd needs to be relocated completely inside linear mapping */
+	new_start = memblock_find_in_range(0, 0, size, PAGE_SIZE);
+	if (!new_start)
+		panic("Cannot relocate initrd of size %ld\n", size);
+	memblock_reserve(new_start, size);
+
+	initrd_start = __phys_to_virt(new_start);
+	initrd_end   = initrd_start + size;
+
+	pr_info("Moving initrd from [%llx-%llx] to [%llx-%llx]\n",
+		(unsigned long long)orig_start,
+		(unsigned long long)(orig_start + size - 1),
+		(unsigned long long)new_start,
+		(unsigned long long)(new_start + size - 1));
+
+	dest = (void *)initrd_start;
+
+	src = orig_start;
+	while (size) {
+		slop = src & ~PAGE_MASK;
+		clen = min(PAGE_SIZE - slop, size);
+		p = set_fixmap_offset(FIX_RELOCATE_INITRD, src);
+		memcpy(dest, (void *)p, clen);
+		clear_fixmap(FIX_RELOCATE_INITRD);
+		dest += clen;
+		src += clen;
+		size -= clen;
+	}
+
+	if (to_free) {
+		pr_info("Freeing original RAMDISK from [%llx-%llx]\n",
+			(unsigned long long)orig_start,
+			(unsigned long long)(orig_start + to_free - 1));
+		memblock_free(orig_start, to_free);
+	}
+}
+#else
+static inline void __init relocate_initrd(void)
+{
+}
+#endif
+
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
  .orig_video_lines	= 30,
@@ -969,6 +1040,7 @@ void __init setup_arch(char **cmdline_p)
 	arm_memblock_init(mdesc);
 
 	paging_init(mdesc);
+	relocate_initrd();
 	request_standard_resources(mdesc);
 
 	if (mdesc->restart)
-- 
1.9.1
