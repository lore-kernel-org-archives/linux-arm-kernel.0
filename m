From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:25 +0200
Subject: [RESEND PATCH 08/12] ARM: integrator: remap PCIv3 base dynamically
Message-ID: <1366466185-15579-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the static mapping for the PCIv3 PCI bridge controller
and do this dynamically when probing instead.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/include/mach/platform.h |  1 -
 arch/arm/mach-integrator/integrator_ap.c         |  6 ------
 arch/arm/mach-integrator/pci_v3.c                | 20 ++++++++++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index be5859e..62fa119 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -325,7 +325,6 @@
 
 #define PCI_MEMORY_VADDR		IOMEM(0xe8000000)
 #define PCI_CONFIG_VADDR		IOMEM(0xec000000)
-#define PCI_V3_VADDR			IOMEM(0xed000000)
 
 /* ------------------------------------------------------------------------
  *  Integrator Interrupt Controllers
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index f190bab..9b2d28b 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -80,7 +80,6 @@ void __iomem *ap_syscon_base;
  * Logical      Physical
  * e8000000	40000000	PCI memory		PHYS_PCI_MEM_BASE	(max 512M)
  * ec000000	61000000	PCI config space	PHYS_PCI_CONFIG_BASE	(max 16M)
- * ed000000	62000000	PCI V3 regs		PHYS_PCI_V3_BASE	(max 64k)
  * fee00000	60000000	PCI IO			PHYS_PCI_IO_BASE	(max 16M)
  * ef000000			Cache flush
  * f1000000	10000000	Core module registers
@@ -140,11 +139,6 @@ static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 		.pfn		= __phys_to_pfn(PHYS_PCI_CONFIG_BASE),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	= (unsigned long)PCI_V3_VADDR,
-		.pfn		= __phys_to_pfn(PHYS_PCI_V3_BASE),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE
 	}
 };
 
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 604064b..9dd7125 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -260,15 +260,17 @@
  * the mappings into PCI memory.
  */
 
+static void __iomem *pci_v3_base;
+
 // V3 access routines
-#define v3_writeb(o,v) __raw_writeb(v, PCI_V3_VADDR + (unsigned int)(o))
-#define v3_readb(o)    (__raw_readb(PCI_V3_VADDR + (unsigned int)(o)))
+#define v3_writeb(o,v) __raw_writeb(v, pci_v3_base + (unsigned int)(o))
+#define v3_readb(o)    (__raw_readb(pci_v3_base + (unsigned int)(o)))
 
-#define v3_writew(o,v) __raw_writew(v, PCI_V3_VADDR + (unsigned int)(o))
-#define v3_readw(o)    (__raw_readw(PCI_V3_VADDR + (unsigned int)(o)))
+#define v3_writew(o,v) __raw_writew(v, pci_v3_base + (unsigned int)(o))
+#define v3_readw(o)    (__raw_readw(pci_v3_base + (unsigned int)(o)))
 
-#define v3_writel(o,v) __raw_writel(v, PCI_V3_VADDR + (unsigned int)(o))
-#define v3_readl(o)    (__raw_readl(PCI_V3_VADDR + (unsigned int)(o)))
+#define v3_writel(o,v) __raw_writel(v, pci_v3_base + (unsigned int)(o))
+#define v3_readl(o)    (__raw_readl(pci_v3_base + (unsigned int)(o)))
 
 /*============================================================================
  *
@@ -835,6 +837,12 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	pci_v3_base = devm_ioremap(&pdev->dev, PHYS_PCI_V3_BASE, SZ_64K);
+	if (!pci_v3_base) {
+		dev_err(&pdev->dev, "unable to remap PCIv3 base\n");
+		return -ENODEV;
+	}
+
 	ret = devm_request_irq(&pdev->dev, IRQ_AP_V3INT, v3_irq, 0, "V3", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to grab PCI error interrupt: %d\n",
-- 
1.8.1.4
