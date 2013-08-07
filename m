From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:38 +0900
Subject: [GIT PULL 17/19] ARM: shmobile: marzen: Use DT for GIC
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <693ac41df314289d655123e6ded519244fa1d951.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Marzen is using DT booting,
and r8a7779.dtsi already has GIC settings.

So, we can remove the C version of the GIC setup code,
instead rely on GIC information provided by DT.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c         |  3 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  1 -
 arch/arm/mach-shmobile/intc-r8a7779.c         | 22 ++++------------------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index bcd07c0..f302729 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -247,8 +247,7 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
-	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= r8a7779_init_irq,
+	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= marzen_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index fc47073..c62252f 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -25,7 +25,6 @@ static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 }
 
 extern void r8a7779_init_delay(void);
-extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index b86dc89..8a082f0 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -90,15 +90,18 @@ void __init r8a7779_init_irq_extpin(int irlm)
 		pr_warn("r8a7779: unable to setup external irq pin mode\n");
 }
 
+#ifdef CONFIG_OF
 static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 {
 	return 0; /* always allow wakeup */
 }
 
-static void __init r8a7779_init_irq_common(void)
+void __init r8a7779_init_irq_dt(void)
 {
 	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
 
+	irqchip_init();
+
 	/* route all interrupts to ARM */
 	__raw_writel(0xffffffff, INT2NTSR0);
 	__raw_writel(0x3fffffff, INT2NTSR1);
@@ -109,23 +112,6 @@ static void __init r8a7779_init_irq_common(void)
 	__raw_writel(0xfffbffdf, INT2SMSKCR2);
 	__raw_writel(0xbffffffc, INT2SMSKCR3);
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
-}
-
-void __init r8a7779_init_irq(void)
-{
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
-	r8a7779_init_irq_common();
-}
-
-#ifdef CONFIG_OF
-void __init r8a7779_init_irq_dt(void)
-{
-	irqchip_init();
-	r8a7779_init_irq_common();
 }
 #endif
-- 
1.8.3.2
