From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Oct 2012 19:02:45 +0200
Subject: [PATCH 3/5] arm: mvebu: Added IPI support via doorbells
In-Reply-To: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yehuda Yitschak <yehuday@marvell.com>

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.h     |   10 ++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c |   92 +++++++++++++++++++++++++++++--
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index f521ed8..531619f 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -24,7 +24,7 @@
 
 	mpic: interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x1d0>,
-		    <0xd0021870 0x58>;
+		    <0xd0021070 0x58>;
 	};
 
 	armada-370-xp-pmsu at d0022000 {
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index aac9beb..dce590d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -19,4 +19,14 @@
 #define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfeb00000)
 #define ARMADA_370_XP_REGS_SIZE		SZ_1M
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+
+void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
+void armada_xp_mpic_smp_cpu_init(void);
+#endif
+#endif
+
 #endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 5f5f939..549b684 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -24,6 +24,7 @@
 #include <linux/irqdomain.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
+#include <asm/smp_plat.h>
 
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
@@ -35,6 +36,12 @@
 
 #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
 
+#define ARMADA_370_XP_SW_TRIG_INT_OFFS           (0x4)
+#define ARMADA_370_XP_IN_DRBEL_MSK_OFFS          (0xc)
+#define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS        (0x8)
+
+#define ACTIVE_DOORBELLS			(8)
+
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
@@ -51,11 +58,22 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 	       per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
+#ifdef CONFIG_SMP
+static int armada_xp_set_affinity(struct irq_data *d,
+				  const struct cpumask *mask_val, bool force)
+{
+	return 0;
+}
+#endif
+
 static struct irq_chip armada_370_xp_irq_chip = {
 	.name		= "armada_370_xp_irq",
 	.irq_mask       = armada_370_xp_irq_mask,
 	.irq_mask_ack   = armada_370_xp_irq_mask,
 	.irq_unmask     = armada_370_xp_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = armada_xp_set_affinity,
+#endif
 };
 
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
@@ -72,6 +90,41 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq)
+{
+	int cpu;
+	unsigned long map = 0;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* submit softirq */
+	writel((map << 8) | irq, main_int_base +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+}
+
+void armada_xp_mpic_smp_cpu_init(void)
+{
+	/* Clear pending IPIs */
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+
+	/* Enable first 8 IPIs */
+	writel((1 << ACTIVE_DOORBELLS) - 1, per_cpu_int_base +
+		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
+	/* Unmask IPI interrupt */
+	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+#endif /* CONFIG_SMP */
+
 static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.map = armada_370_xp_mpic_irq_map,
 	.xlate = irq_domain_xlate_onecell,
@@ -91,13 +144,18 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
 
 	armada_370_xp_mpic_domain =
-	    irq_domain_add_linear(node, (control >> 2) & 0x3ff,
-				  &armada_370_xp_mpic_irq_ops, NULL);
+		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
+				&armada_370_xp_mpic_irq_ops, NULL);
 
 	if (!armada_370_xp_mpic_domain)
 		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
 
 	irq_set_default_host(armada_370_xp_mpic_domain);
+
+#ifdef CONFIG_SMP
+	armada_xp_mpic_smp_cpu_init();
+#endif
+
 	return 0;
 }
 
@@ -111,14 +169,36 @@ asmlinkage void __exception_irq_entry armada_370_xp_handle_irq(struct pt_regs
 					ARMADA_370_XP_CPU_INTACK_OFFS);
 		irqnr = irqstat & 0x3FF;
 
-		if (irqnr < 1023) {
-			irqnr =
-			    irq_find_mapping(armada_370_xp_mpic_domain, irqnr);
+		if (irqnr > 1022)
+			break;
+
+		if (irqnr >= 8) {
+			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
+					irqnr);
 			handle_IRQ(irqnr, regs);
 			continue;
 		}
+#ifdef CONFIG_SMP
+		/* IPI Handling */
+		if (irqnr == 0) {
+			u32 ipimask, ipinr;
+
+			ipimask = readl_relaxed(per_cpu_int_base +
+						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
+				& 0xFF;
+
+			writel(0x0, per_cpu_int_base +
+				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+
+			/* Handle all pending doorbells */
+			for (ipinr = 0; ipinr < ACTIVE_DOORBELLS; ipinr++) {
+				if (ipimask & (0x1 << ipinr))
+					handle_IPI(ipinr, regs);
+			}
+			continue;
+		}
+#endif
 
-		break;
 	} while (1);
 }
 
-- 
1.7.9.5
