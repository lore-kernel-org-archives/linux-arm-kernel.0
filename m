From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:39 +0200
Subject: [RESEND PATCH 10/12] ARM: integrator: move static ioremapping into
 PCIv3 driver
Message-ID: <1366466199-15651-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to make this driver self-contained by moving the ioremapping
into the driver.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/include/mach/platform.h | 22 -----------
 arch/arm/mach-integrator/integrator_ap.c         | 17 +--------
 arch/arm/mach-integrator/pci_v3.c                | 48 +++++++++++++++++++++++-
 arch/arm/mach-integrator/pci_v3.h                |  2 +
 4 files changed, 51 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-integrator/pci_v3.h

diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index 62fa119..306d025 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -305,28 +305,6 @@
 /* KMI definitions are now in include/asm-arm/hardware/amba_kmi.h -- rmk */
 
 /* ------------------------------------------------------------------------
- *  Where in the memory map does PCI live?
- * ------------------------------------------------------------------------
- *  This represents a fairly liberal usage of address space.  Even though
- *  the V3 only has two windows (therefore we need to map stuff on the fly),
- *  we maintain the same addresses, even if they're not mapped.
- *
- */
-#define PHYS_PCI_MEM_BASE               0x40000000   /* 512M to xxx */
-/*  unused 256M from A0000000-AFFFFFFF might be used for I2O ???
- */
-#define PHYS_PCI_IO_BASE                0x60000000   /* 16M to xxx */
-/*  unused (128-16)M from B1000000-B7FFFFFF
- */
-#define PHYS_PCI_CONFIG_BASE            0x61000000   /* 16M to xxx */
-/*  unused ((128-16)M - 64K) from XXX
- */
-#define PHYS_PCI_V3_BASE                0x62000000
-
-#define PCI_MEMORY_VADDR		IOMEM(0xe8000000)
-#define PCI_CONFIG_VADDR		IOMEM(0xec000000)
-
-/* ------------------------------------------------------------------------
  *  Integrator Interrupt Controllers
  * ------------------------------------------------------------------------
  *
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index fe1ee7c0..f617489 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -56,10 +56,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/pci.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
+#include "pci_v3.h"
 
 /* Base address to the AP system controller */
 void __iomem *ap_syscon_base;
@@ -77,9 +77,6 @@ void __iomem *ap_syscon_base;
 
 /*
  * Logical      Physical
- * e8000000	40000000	PCI memory		PHYS_PCI_MEM_BASE	(max 512M)
- * ec000000	61000000	PCI config space	PHYS_PCI_CONFIG_BASE	(max 16M)
- * fee00000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
  * ef000000			Cache flush
  * f1000000	10000000	Core module registers
  * f1100000	11000000	System controller registers
@@ -128,23 +125,13 @@ static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 		.pfn		= __phys_to_pfn(INTEGRATOR_AP_GPIO_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	= (unsigned long)PCI_MEMORY_VADDR,
-		.pfn		= __phys_to_pfn(PHYS_PCI_MEM_BASE),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= (unsigned long)PCI_CONFIG_VADDR,
-		.pfn		= __phys_to_pfn(PHYS_PCI_CONFIG_BASE),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
 	}
 };
 
 static void __init ap_map_io(void)
 {
 	iotable_init(ap_io_desc, ARRAY_SIZE(ap_io_desc));
-	pci_map_io_early(__phys_to_pfn(PHYS_PCI_IO_BASE));
+	pci_v3_early_init();
 }
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 059ac4e..a3cefde 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -34,10 +34,28 @@
 #include <mach/platform.h>
 #include <mach/irqs.h>
 
+#include <asm/mach/map.h>
 #include <asm/signal.h>
 #include <asm/mach/pci.h>
 #include <asm/irq_regs.h>
 
+#include "pci_v3.h"
+
+/*
+ * Where in the memory map does PCI live?
+ *
+ * This represents a fairly liberal usage of address space.  Even though
+ * the V3 only has two windows (therefore we need to map stuff on the fly),
+ * we maintain the same addresses, even if they're not mapped.
+ */
+#define PHYS_PCI_MEM_BASE               0x40000000 /* 512M */
+#define PHYS_PCI_IO_BASE                0x60000000 /* 16M */
+#define PHYS_PCI_CONFIG_BASE            0x61000000 /* 16M */
+#define PHYS_PCI_V3_BASE                0x62000000 /* 64K */
+
+#define PCI_MEMORY_VADDR               IOMEM(0xe8000000)
+#define PCI_CONFIG_VADDR               IOMEM(0xec000000)
+
 /*
  * V3 Local Bus to PCI Bridge definitions
  *
@@ -851,7 +869,6 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	vga_base = (unsigned long)PCI_MEMORY_VADDR;
 	pci_common_init(&pci_v3);
 
 	return 0;
@@ -869,3 +886,32 @@ static int __init pci_v3_init(void)
 }
 
 subsys_initcall(pci_v3_init);
+
+/*
+ * Static mappings for the PCIv3 bridge
+ *
+ * e8000000	40000000	PCI memory		PHYS_PCI_MEM_BASE	(max 512M)
+ * ec000000	61000000	PCI config space	PHYS_PCI_CONFIG_BASE	(max 16M)
+ * fee00000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
+ */
+static struct map_desc pci_v3_io_desc[] __initdata __maybe_unused = {
+	{
+		.virtual	= (unsigned long)PCI_MEMORY_VADDR,
+		.pfn		= __phys_to_pfn(PHYS_PCI_MEM_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= (unsigned long)PCI_CONFIG_VADDR,
+		.pfn		= __phys_to_pfn(PHYS_PCI_CONFIG_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}
+};
+
+int __init pci_v3_early_init(void)
+{
+	iotable_init(pci_v3_io_desc, ARRAY_SIZE(pci_v3_io_desc));
+	vga_base = (unsigned long)PCI_MEMORY_VADDR;
+	pci_map_io_early(__phys_to_pfn(PHYS_PCI_IO_BASE));
+	return 0;
+}
diff --git a/arch/arm/mach-integrator/pci_v3.h b/arch/arm/mach-integrator/pci_v3.h
new file mode 100644
index 0000000..755fd29
--- /dev/null
+++ b/arch/arm/mach-integrator/pci_v3.h
@@ -0,0 +1,2 @@
+/* Simple oneliner include to the PCIv3 early init */
+extern int pci_v3_early_init(void);
-- 
1.8.1.4
