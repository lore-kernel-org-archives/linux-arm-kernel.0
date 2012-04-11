From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 00:43:43 +0200
Subject: [PATCH 1/3] integrator: fix the IRQ masks on the Integrator/CP
Message-ID: <1334184223-18864-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mask for the PIC FPGA IRQ controller was just wrong, so
convert all the IRQ controllers to use the same, correct
design pattern to produce the valid IRQ mask. Also use the
IRQ_FOO_END macro consistently so this looks coherent.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/include/mach/irqs.h |    2 +-
 arch/arm/mach-integrator/integrator_cp.c     |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/irqs.h b/arch/arm/mach-integrator/include/mach/irqs.h
index a19a1a2..283931e 100644
--- a/arch/arm/mach-integrator/include/mach/irqs.h
+++ b/arch/arm/mach-integrator/include/mach/irqs.h
@@ -52,7 +52,7 @@
 #define IRQ_CP_CPPLDINT			26
 #define IRQ_CP_ETHINT			27
 #define IRQ_CP_TSPENINT			28
-#define IRQ_PIC_END			31
+#define IRQ_PIC_END			28
 
 #define IRQ_CIC_START			32
 #define IRQ_CM_SOFTINT			32
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 48a115a..2172f4c 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -163,10 +163,10 @@ static struct fpga_irq_data sic_irq_data = {
 
 static void __init intcp_init_irq(void)
 {
-	u32 pic_mask, sic_mask;
+	u32 pic_mask, cic_mask, sic_mask;
 
-	pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
-	pic_mask |= (~((~0u) << (29 - 22))) << 22;
+	pic_mask = ~((~0u) << (1 + IRQ_PIC_END - IRQ_PIC_START));
+	cic_mask = ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START));
 	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
 
 	/*
@@ -181,8 +181,7 @@ static void __init intcp_init_irq(void)
 
 	fpga_irq_init(-1, pic_mask, &pic_irq_data);
 
-	fpga_irq_init(-1, ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START)),
-		&cic_irq_data);
+	fpga_irq_init(-1, cic_mask, &cic_irq_data);
 
 	fpga_irq_init(IRQ_CP_CPPLDINT, sic_mask, &sic_irq_data);
 }
-- 
1.7.7.6
