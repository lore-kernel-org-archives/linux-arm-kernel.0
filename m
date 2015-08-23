From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 23 Aug 2015 21:13:57 +0200
Subject: [PATCH] ARM: pxa: fix DFI bus lockups on startup
Message-ID: <1440357237-26713-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the conversion of pxa architecture to common clock framework, the
NAND clock can be disabled on startup if no nand driver claims it.

In this case, it happens that if the bootloader used the NAND and set
the DFI arbitration bit, the next access to a static memory controller
area, such as an ethernet card, the system bus will stall, and the core
will be stalled forever.

Fix this by clearing the DFI arbritration bit in pxa3xx startup. The bit
will be enabled the pxa3xx-nand driver on need anyway. The only left
requirement is that upon pxa3xx-nand removal, the bit should be cleared
before the clock is disabled.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/addr-map.h |  7 +++++++
 arch/arm/mach-pxa/pxa3xx.c                | 21 ++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/addr-map.h b/arch/arm/mach-pxa/include/mach/addr-map.h
index d28fe291233a..07b93fd24474 100644
--- a/arch/arm/mach-pxa/include/mach/addr-map.h
+++ b/arch/arm/mach-pxa/include/mach/addr-map.h
@@ -44,6 +44,13 @@
  */
 
 /*
+ * DFI Bus for NAND, PXA3xx only
+ */
+#define NAND_PHYS		0x43100000
+#define NAND_VIRT		IOMEM(0xf6300000)
+#define NAND_SIZE		0x00100000
+
+/*
  * Internal Memory Controller (PXA27x and later)
  */
 #define IMEMC_PHYS		0x58000000
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index aa85ec1a3065..26105167d433 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -47,6 +47,13 @@ extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
 #define ISRAM_START	0x5c000000
 #define ISRAM_SIZE	SZ_256K
 
+/*
+ * NAND NFC: DFI bus arbitration subset
+ */
+#define NDCR			(*(volatile u32 __iomem*)(NAND_VIRT + 0))
+#define NDCR_ND_ARB_EN		(1 << 12)
+#define NDCR_ND_ARB_CNTL	(1 << 19)
+
 static void __iomem *sram;
 static unsigned long wakeup_src;
 
@@ -362,7 +369,12 @@ static struct map_desc pxa3xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(PXA3XX_SMEMC_BASE),
 		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
-	}
+	}, {
+		.virtual	= (unsigned long)NAND_VIRT,
+		.pfn		= __phys_to_pfn(NAND_PHYS),
+		.length		= NAND_SIZE,
+		.type		= MT_DEVICE
+	},
 };
 
 void __init pxa3xx_map_io(void)
@@ -420,6 +432,13 @@ static int __init pxa3xx_init(void)
 		 */
 		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
 
+		/*
+		 * Disable DFI bus arbitration, to prevent a system bus lock if
+		 * somebody disables the NAND clock (unused clock) while this
+		 * bit remains set.
+		 */
+		NDCR = (NDCR & ~NDCR_ND_ARB_EN) | NDCR_ND_ARB_CNTL;
+
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
 			return ret;
 
-- 
2.1.4
