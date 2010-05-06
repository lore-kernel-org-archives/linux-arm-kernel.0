From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:01 -0700
Subject: [PATCH 10/34] Davinci: cpintc host map configuration
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Host map configuration instructs the interrupt controller to route interrupt
channels to FIQ or IRQ lines.  Currently, DA8xx family of devices leave these
registers at their reset-default values.

TNETV107X however does not have sane reset defaults, and therefore this
architecture needs to reconfigure the host-map such that channels 0 and 1
go to FIQ, and the remaining channels raise IRQs.

This patch adds an optional host map argument to cp_intc_init() for this.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c      |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c      |    2 +-
 arch/arm/mach-davinci/cp_intc.c              |    6 +++++-
 arch/arm/mach-davinci/include/mach/cp_intc.h |    2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index ea293b8..db5ac0f 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -569,7 +569,7 @@ static __init void da830_evm_irq_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	cp_intc_init((void __iomem *)DA8XX_CP_INTC_VIRT, DA830_N_CP_INTC_IRQ,
-			soc_info->intc_irq_prios);
+			soc_info->intc_irq_prios, NULL);
 }
 
 static void __init da830_evm_map_io(void)
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 411284d..ef691ae 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -741,7 +741,7 @@ static __init void da850_evm_irq_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	cp_intc_init((void __iomem *)DA8XX_CP_INTC_VIRT, DA850_N_CP_INTC_IRQ,
-			soc_info->intc_irq_prios);
+			soc_info->intc_irq_prios, NULL);
 }
 
 static void __init da850_evm_map_io(void)
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 37311d1..2a8d26e 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -101,7 +101,7 @@ static struct irq_chip cp_intc_irq_chip = {
 };
 
 void __init cp_intc_init(void __iomem *base, unsigned short num_irq,
-			 u8 *irq_prio)
+			 u8 *irq_prio, u32 *host_map)
 {
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i;
@@ -157,6 +157,10 @@ void __init cp_intc_init(void __iomem *base, unsigned short num_irq,
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
+	if (host_map)
+		for (i = 0; host_map[i] != -1; i++)
+			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
+
 	/* Set up genirq dispatching for cp_intc */
 	for (i = 0; i < num_irq; i++) {
 		set_irq_chip(i, &cp_intc_irq_chip);
diff --git a/arch/arm/mach-davinci/include/mach/cp_intc.h b/arch/arm/mach-davinci/include/mach/cp_intc.h
index c4d27ee..121b114 100644
--- a/arch/arm/mach-davinci/include/mach/cp_intc.h
+++ b/arch/arm/mach-davinci/include/mach/cp_intc.h
@@ -52,6 +52,6 @@
 #define CP_INTC_VECTOR_ADDR(n)		(0x2000 + (n << 2))
 
 void __init cp_intc_init(void __iomem *base, unsigned short num_irq,
-			 u8 *irq_prio);
+			 u8 *irq_prio, u32 *host_map);
 
 #endif	/* __ASM_HARDWARE_CP_INTC_H */
-- 
1.7.0.2
