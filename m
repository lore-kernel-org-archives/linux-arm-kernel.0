From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:09 +0000
Subject: [PATCH 67/75] ARM: l2c: vexpress ca9x4: move L2 cache initialisation
 earlier
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZl-0007HN-38@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is beneficial to have the L2 cache up and running earlier in the
system boot.  Not only will this allow for simpler code when we come to
enable some features, but it also means that we get a more accurate
bogomips value for the udelay() loop.  Calibrating the loop with the
L2 cache off, and then running with the L2 cache on is not the best
idea.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/ct-ca9x4.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6c4ffb6c5ad8..204038ef3795 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -45,6 +45,23 @@ static void __init ct_ca9x4_map_io(void)
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
+static void __init ca9x4_l2_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);
+
+	if (l2x0_base) {
+		/* set RAM latencies to 1 cycle for this core tile. */
+		writel(0, l2x0_base + L310_TAG_LATENCY_CTRL);
+		writel(0, l2x0_base + L310_DATA_LATENCY_CTRL);
+
+		l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
+	} else {
+		pr_err("L2C: unable to map L2 cache controller\n");
+	}
+#endif
+}
+
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, IRQ_LOCALTIMER);
 
@@ -63,6 +80,7 @@ static void __init ct_ca9x4_init_irq(void)
 	gic_init(0, 29, ioremap(A9_MPCORE_GIC_DIST, SZ_4K),
 		 ioremap(A9_MPCORE_GIC_CPU, SZ_256));
 	ca9x4_twd_init();
+	ca9x4_l2_init();
 }
 
 static int ct_ca9x4_clcd_setup(struct clcd_fb *fb)
@@ -141,16 +159,6 @@ static void __init ct_ca9x4_init(void)
 {
 	int i;
 
-#ifdef CONFIG_CACHE_L2X0
-	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);
-
-	/* set RAM latencies to 1 cycle for this core tile. */
-	writel(0, l2x0_base + L310_TAG_LATENCY_CTRL);
-	writel(0, l2x0_base + L310_DATA_LATENCY_CTRL);
-
-	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
-#endif
-
 	for (i = 0; i < ARRAY_SIZE(ct_ca9x4_amba_devs); i++)
 		amba_device_register(ct_ca9x4_amba_devs[i], &iomem_resource);
 
-- 
1.8.3.1
