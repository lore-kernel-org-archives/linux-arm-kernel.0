From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:07 +0000
Subject: [RFC PATCH 10/11] ARM: NOMMU: define __arm_ioremap_exec and
 pci_ioremap functions
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-11-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define __arm_ioremap_exec and pci_ioremap* functions fallowing pattern
for other ioremap functions.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/nommu.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2740967..681cec8 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -19,6 +19,7 @@
 #include <asm/cputype.h>
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
+#include <asm/mach/map.h>
 
 #include "mm.h"
 
@@ -401,3 +402,37 @@ void iounmap(volatile void __iomem *addr)
 {
 }
 EXPORT_SYMBOL(iounmap);
+
+void __iomem *
+__arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
+{
+	unsigned int mtype;
+
+	if (cached)
+		mtype = MT_MEMORY_RWX;
+	else
+		mtype = MT_MEMORY_RWX_NONCACHED;
+
+	return __arm_ioremap_caller(phys_addr, size, mtype,
+			__builtin_return_address(0));
+}
+
+#ifdef CONFIG_PCI
+static int pci_ioremap_mem_type = MT_DEVICE;
+
+void pci_ioremap_set_mem_type(int mem_type)
+{
+	pci_ioremap_mem_type = mem_type;
+}
+
+int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
+{
+	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+
+	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
+				  PCI_IO_VIRT_BASE + offset + SZ_64K,
+				  phys_addr,
+				  MT_DEVICE);
+}
+EXPORT_SYMBOL_GPL(pci_ioremap_io);
+#endif
-- 
1.7.9.5
