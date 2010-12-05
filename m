From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:08:48 -0800
Subject: [PATCH 01/21] ARM: tegra: irq: Rename gic pointers to avoid conflicts
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-2-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A future patch will export gic_mask_irq and gic_unmask_irq.
Rename the pointers in arch/arm/mach-tegra/irq.c to avoid
a compile error.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/irq.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 50a8dfb..37b4f97 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -46,8 +46,8 @@
 #define ICTLR_COP_IER_CLR	0x38
 #define ICTLR_COP_IEP_CLASS	0x3c
 
-static void (*gic_mask_irq)(unsigned int irq);
-static void (*gic_unmask_irq)(unsigned int irq);
+static void (*tegra_gic_mask_irq)(unsigned int irq);
+static void (*tegra_gic_unmask_irq)(unsigned int irq);
 
 #define irq_to_ictlr(irq) (((irq)-32) >> 5)
 static void __iomem *tegra_ictlr_base = IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE);
@@ -56,14 +56,14 @@ static void __iomem *tegra_ictlr_base = IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE);
 static void tegra_mask(unsigned int irq)
 {
 	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(irq));
-	gic_mask_irq(irq);
+	tegra_gic_mask_irq(irq);
 	writel(1<<(irq&31), addr+ICTLR_CPU_IER_CLR);
 }
 
 static void tegra_unmask(unsigned int irq)
 {
 	void __iomem *addr = ictlr_to_virt(irq_to_ictlr(irq));
-	gic_unmask_irq(irq);
+	tegra_gic_unmask_irq(irq);
 	writel(1<<(irq&31), addr+ICTLR_CPU_IER_SET);
 }
 
@@ -98,8 +98,8 @@ void __init tegra_init_irq(void)
 	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
 
 	gic = get_irq_chip(29);
-	gic_unmask_irq = gic->unmask;
-	gic_mask_irq = gic->mask;
+	tegra_gic_unmask_irq = gic->unmask;
+	tegra_gic_mask_irq = gic->mask;
 	tegra_irq.ack = gic->ack;
 #ifdef CONFIG_SMP
 	tegra_irq.set_affinity = gic->set_affinity;
-- 
1.7.3.1
