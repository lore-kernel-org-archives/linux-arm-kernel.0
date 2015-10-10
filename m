From: yalin.wang2010@gmail.com (yalin wang)
Date: Sat, 10 Oct 2015 10:01:41 +0800
Subject: [RFC V2] arm: add relocate initrd support
Message-ID: <1444442501-17245-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for initrd on ARM arch, in case
mem= boot option change the memory size or the initrd are
not placed in low memory region, we need copy the initrd
to low memory region.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm/include/asm/fixmap.h |  1 +
 arch/arm/kernel/setup.c       | 70 +++++++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt.c              |  2 ++
 include/linux/initrd.h        |  1 +
 init/do_mounts_initrd.c       |  2 ++
 5 files changed, 76 insertions(+)

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
index 20edd34..036473b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -811,6 +811,75 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
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
+	phys_addr_t ram_end = memblock_end_of_DRAM();
+	phys_addr_t new_start;
+	phys_addr_t src;
+	unsigned long size, to_free = 0;
+	unsigned long slop, clen, p;
+	void *dest;
+
+	if (initrd_end_phys <= __virt_to_phys(memblock_get_current_limit()))
+		return;
+
+	/*
+	 * Any of the original initrd which overlaps the linear map should
+	 * be freed after relocating.
+	 */
+	if (initrd_start_phys < ram_end)
+		to_free = min(ram_end, initrd_end_phys) - initrd_start_phys;
+
+	size = initrd_end_phys - initrd_start_phys;
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
+		(unsigned long long)initrd_start_phys,
+		(unsigned long long)(initrd_start_phys + size - 1),
+		(unsigned long long)new_start,
+		(unsigned long long)(new_start + size - 1));
+
+	dest = (void *)initrd_start;
+
+	src = initrd_start_phys;
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
+			(unsigned long long)initrd_start_phys,
+			(unsigned long long)(initrd_start_phys + to_free - 1));
+		memblock_free(initrd_start_phys, to_free);
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
@@ -969,6 +1038,7 @@ void __init setup_arch(char **cmdline_p)
 	arm_memblock_init(mdesc);
 
 	paging_init(mdesc);
+	relocate_initrd();
 	request_standard_resources(mdesc);
 
 	if (mdesc->restart)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0749656..3287ecb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -777,6 +777,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 		return;
 	end = of_read_number(prop, len/4);
 
+	initrd_start_phys = start;
+	initrd_end_phys = end;
 	initrd_start = (unsigned long)__va(start);
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 55289d2..0698f37 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -15,6 +15,7 @@ extern int initrd_below_start_ok;
 
 /* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
+extern phys_addr_t initrd_start_phys, initrd_end_phys;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
 extern unsigned int real_root_dev;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 3e0878e..cb07338 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -21,6 +21,8 @@
 #include "do_mounts.h"
 
 unsigned long initrd_start, initrd_end;
+phys_addr_t initrd_start_pyhs __initdata;
+phys_addr_t initrd_end_phys __initdata;
 int initrd_below_start_ok;
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
-- 
1.9.1
