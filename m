From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri,  6 Sep 2013 10:19:17 +0100
Subject: [PATCH v2 1/2] Documentation: arm: early_ioremap/early_memremap
In-Reply-To: <1378459158-2145-1-git-send-email-leif.lindholm@linaro.org>
References: <1378459158-2145-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1378459158-2145-2-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides documentation of the early_ioremap() and
early_memremap() functionality,including its implementation and usage
instructions.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Rob Landley <rob@landley.net>
---
 Documentation/arm/00-INDEX          |    2 ++
 Documentation/arm/early_ioremap.txt |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/arm/early_ioremap.txt

diff --git a/Documentation/arm/00-INDEX b/Documentation/arm/00-INDEX
index 36420e1..4978456 100644
--- a/Documentation/arm/00-INDEX
+++ b/Documentation/arm/00-INDEX
@@ -24,6 +24,8 @@ SPEAr
 	- ST SPEAr platform Linux Overview
 VFP/
 	- Release notes for Linux Kernel Vector Floating Point support code
+early_ioremap.txt
+	- documentation of the early_ioremap() functionality
 empeg/
 	- Ltd's Empeg MP3 Car Audio Player
 mem_alignment
diff --git a/Documentation/arm/early_ioremap.txt b/Documentation/arm/early_ioremap.txt
new file mode 100644
index 0000000..e1c0b16
--- /dev/null
+++ b/Documentation/arm/early_ioremap.txt
@@ -0,0 +1,23 @@
+early_ioremap()/early_memremap() and early_iounmap() provide a mechanism for
+temporarily mapping in small blocks of memory, identified by their physical
+address, into the fixmap virtual address block before paging_init() has run
+and more flexible mapping functions are available.
+
+Due to its direct method, it also gets around potential need for special
+handling of regions that end up in highmem.
+
+It supports up to 7 simultaneously mapped regions of up to 128KB each.
+All mappings created by early_ioremap() are non-shareable device memory.
+All mappings created by early_memremap() are uncached normal memory.
+
+Any residual mappings will be overridden by subsequent kmap() calls (but do
+use early_iounmap()).
+
+Specify 'early_ioremap_debug' on the kernel commandline for verbose output.
+
+SYNOPSIS
+	#include <asm/io.h>
+
+	void *early_ioremap(resource_size_t phys_addr, unsigned long size);
+	void *early_memremap(resource_size_t phys_addr, unsigned long size);
+	void early_iounmap(void *addr, unsigned long size);
-- 
1.7.10.4
