From: msalter@redhat.com (Mark Salter)
Date: Fri, 18 Sep 2015 10:14:26 -0400
Subject: [PATCH] arm64: dmi: initialize DMI earlier in boot
Message-ID: <1442585666-14093-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, DMI initialization takes place in a core initcall. This
limits how early in boot the kernel can make DMI-based decisions
about firmware/hardware quirks. This patch moves DMI initialization
to setup_arch() so that DMI info is available before initcalls run.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/dmi.h | 19 ++++++++++++++++---
 arch/arm64/kernel/efi.c      | 15 ---------------
 arch/arm64/kernel/setup.c    |  5 +++++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
index 69d37d8..e6389fd 100644
--- a/arch/arm64/include/asm/dmi.h
+++ b/arch/arm64/include/asm/dmi.h
@@ -16,16 +16,29 @@
 
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 /*
  * According to section 2.3.6 of the UEFI spec, the firmware should not
  * request a virtual mapping for configuration tables such as SMBIOS.
  * This means we have to map them before use.
  */
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
-#define dmi_early_unmap(x, l)		iounmap(x)
+static inline __init void __iomem *dmi_early_remap(resource_size_t addr,
+						   unsigned long size)
+{
+	return (__force void __iomem *)early_memremap(addr, size);
+}
+
+#define dmi_early_unmap(x, l)		early_memunmap((__force void *)(x), l)
 #define dmi_remap(x, l)			ioremap_cache(x, l)
 #define dmi_unmap(x)			iounmap(x)
-#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
+
+static inline __init void *dmi_alloc(size_t len)
+{
+	void *ptr = __va(memblock_alloc(len, sizeof(long)));
+
+	memset(ptr, 0, len);
+	return ptr;
+}
 
 #endif
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 7939667..b9e6afb 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -413,20 +412,6 @@ static int __init arm64_enable_runtime_services(void)
 }
 early_initcall(arm64_enable_runtime_services);
 
-static int __init arm64_dmi_init(void)
-{
-	/*
-	 * On arm64, DMI depends on UEFI, and dmi_scan_machine() needs to
-	 * be called early because dmi_id_init(), which is an arch_initcall
-	 * itself, depends on dmi_scan_machine() having been called already.
-	 */
-	dmi_scan_machine();
-	if (dmi_available)
-		dmi_set_dump_stack_arch_desc();
-	return 0;
-}
-core_initcall(arm64_dmi_init);
-
 static void efi_set_pgd(struct mm_struct *mm)
 {
 	if (mm == &init_mm)
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index dc9eb5f..200c2e9 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -46,6 +46,7 @@
 #include <linux/efi.h>
 #include <linux/personality.h>
 #include <linux/psci.h>
+#include <linux/dmi.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -436,6 +437,10 @@ void __init setup_arch(char **cmdline_p)
 	relocate_initrd();
 	request_standard_resources();
 
+	dmi_scan_machine();
+	if (dmi_available)
+		dmi_set_dump_stack_arch_desc();
+
 	early_ioremap_reset();
 
 	if (acpi_disabled) {
-- 
1.8.3.1
