From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Sep 2010 17:08:44 -0400 (EDT)
Subject: [PATCH] ARM: implement CONFIG_STRICT_DEVMEM by disabling access to RAM
	via /dev/mem
Message-ID: <alpine.LFD.2.00.1009231707300.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


There are very few legitimate use cases, if any, for directly accessing
system RAM through /dev/mem.  So let's mimic what they do on x86 and
forbid it when CONFIG_STRICT_DEVMEM is turned on.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 91344af..c29fb38 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -2,6 +2,20 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config STRICT_DEVMEM
+	bool "Filter access to /dev/mem"
+	depends on MMU
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  of memory, including kernel and userspace memory. Accidental
+	  access to this is obviously disastrous, but specific access can
+	  be used by people debugging the kernel.
+
+	  If this option is switched on, the /dev/mem file only allows
+	  userspace access to memory mapped peripherals.
+
+          If in doubt, say Y.
+
 # RMK wants arm kernels compiled with frame pointers or stack unwinding.
 # If you know what you are doing and are willing to live without stack
 # traces, you can get a slightly smaller kernel by setting this option to
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1261b1f9..815efa2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -294,6 +294,7 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern int valid_phys_addr_range(unsigned long addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
+extern int devmem_is_allowed(unsigned long pfn);
 #endif
 
 /*
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 4f5b396..b0a9830 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -144,3 +144,25 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(pfn + (size >> PAGE_SHIFT) > 0x00100000);
 }
+
+#ifdef CONFIG_STRICT_DEVMEM
+
+#include <linux/ioport.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain
+ * address is valid. The argument is a physical page number.
+ * We mimic x86 here by disallowing access to system RAM as well as
+ * device-exclusive MMIO regions. This effectively disable read()/write()
+ * on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
+
+#endif
