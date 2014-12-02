From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Dec 2014 16:58:14 +0000
Subject: [PATCH 13/16] ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
In-Reply-To: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417539497-20101-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shmobile only uses gic_arch_extn.irq_set_wake to prevent the GIC
from returning -ENXIO when receiving a wake-up configuration request.

It is a lot simpler to tell the irq layer that we don't need any
configuration by using the IRQCHIP_SKIP_SET_WAKE, thanks to the
new gic_set_irqchip_flags function.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/intc-sh73a0.c   | 7 +------
 arch/arm/mach-shmobile/setup-r8a7779.c | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 44457a9..b5af6ad 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -256,11 +256,6 @@ static irqreturn_t sh73a0_intcs_demux(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
-{
-	return 0; /* always allow wakeup */
-}
-
 #define PINTER0_PHYS 0xe69000a0
 #define PINTER1_PHYS 0xe69000a4
 #define PINTER0_VIRT IOMEM(0xe69000a0)
@@ -322,8 +317,8 @@ void __init sh73a0_init_irq(void)
 	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intc_pint0_desc);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 136078a..8cde457 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -716,14 +716,9 @@ void __init r8a7779_init_late(void)
 }
 
 #ifdef CONFIG_USE_OF
-static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
-{
-	return 0; /* always allow wakeup */
-}
-
 void __init r8a7779_init_irq_dt(void)
 {
-	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
+	gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE);
 
 	irqchip_init();
 
-- 
2.1.3
