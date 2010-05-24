From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:49 +0800
Subject: [PATCH 6/6] [ARM] pxa/cm-x2xx: encode IRQ number into .nr_irqs
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/cm-x2xx-pci.h       |    6 ++++++
 arch/arm/mach-pxa/cm-x2xx.c           |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h |   11 -----------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.h b/arch/arm/mach-pxa/cm-x2xx-pci.h
index e24aad2..9a87134 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.h
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.h
@@ -11,3 +11,9 @@ extern void __cmx2xx_pci_resume(void);
 #define cmx2xx_pci_suspend(x) do {} while (0)
 #define cmx2xx_pci_resume(x) do {} while (0)
 #endif
+
+#ifdef CONFIG_PCI
+#define CMX2XX_NR_IRQS	(IRQ_BOARD_START + 41)
+#else
+#define CMX2XX_NR_IRQS	IRQ_BOARD_START
+#endif
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bff6e78..d10b733 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -514,6 +514,7 @@ MACHINE_START(ARMCORE, "Compulab CM-X2XX")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= cmx2xx_map_io,
+	.nr_irqs	= CMX2XX_NR_IRQS,
 	.init_irq	= cmx2xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= cmx2xx_init,
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 145fe1d..62d148c 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -138,15 +138,4 @@
 #define NR_IRQS			(IRQ_BOARD_START)
 #endif
 
-/* add IT8152 IRQs beyond BOARD_END */
-#ifdef CONFIG_PCI_HOST_ITE8152
-#define IT8152_LAST_IRQ         (IRQ_BOARD_END + 40)
-
-#if NR_IRQS < (IT8152_LAST_IRQ+1)
-#undef NR_IRQS
-#define NR_IRQS (IT8152_LAST_IRQ+1)
-#endif
-
-#endif /* CONFIG_PCI_HOST_ITE8152 */
-
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.7.0.4
