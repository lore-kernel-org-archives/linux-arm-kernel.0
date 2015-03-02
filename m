From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 21:40:14 +0100
Subject: [PATCH 0/5] ARM: orion5k/mv78xx0/dove multiplatform support
In-Reply-To: <1425328618-894030-1-git-send-email-arnd@arndb.de>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
Message-ID: <3759703.9ZVN3LdzHt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 21:36:53 Arnd Bergmann wrote:

> This is build tested so far and survives a randconfig builder
> for a few hundred builds without regressions, but I have not
> done any runtime testing. Any help in testing or reviewing would
> be much appreciated.

It would help to send out the version that I have actually tested.
If you want to give it a try, please apply the patch below to
actually get mach-dove to build.

	Arnd

diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index c9d68dbbdc08..c0d5f52713b7 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <asm/exception.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index c0d5f52713b7..eed251513ca5 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -161,7 +161,7 @@ void __init dove_init_irq(void)
 	writel(0, PMU_INTERRUPT_MASK);
 	writel(0, PMU_INTERRUPT_CAUSE);
 
-	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
+	for (i = IRQ_DOVE_PMU_START; i < DOVE_NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
 		irq_set_status_flags(i, IRQ_LEVEL);
 		set_irq_flags(i, IRQF_VALID);
diff --git a/arch/arm/mach-dove/pm.h b/arch/arm/mach-dove/pm.h
index 584954d26241..3e2712a89c61 100644
--- a/arch/arm/mach-dove/pm.h
+++ b/arch/arm/mach-dove/pm.h
@@ -61,7 +61,7 @@ static inline int pmu_to_irq(int pin)
 
 static inline int irq_to_pmu(int irq)
 {
-	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
+	if (IRQ_DOVE_PMU_START <= irq && irq < DOVE_NR_IRQS)
 		return irq - IRQ_DOVE_PMU_START;
 
 	return -EINVAL;
