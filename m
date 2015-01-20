From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:26:40 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: Instantiate GIC from C board code
 in legacy builds
In-Reply-To: <cover.1421716614.git.horms+renesas@verge.net.au>
References: <cover.1421716614.git.horms+renesas@verge.net.au>
Message-ID: <1fbbc3f0c5440a4c674b3d6de0a9dd447666b508.1421716614.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), Bock-W legacy hangs during boot with:

Unable to handle kernel paging request at virtual address cf86a128
pgd = c0004000
[cf86a128] *pgd=6f80041e(bad)
Internal error: Oops: 8000000d [#1] SMP ARM
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4 #1
Hardware name: bockw
task: cf823b40 ti: cf824000 task.ti: cf824000
PC is at 0xcf86a128
LR is at request_threaded_irq+0xbc/0x124

This happens because the IRQ numbers of the GIC are now virtual, and no
longer match the hardcoded hardware IRQ numbers in the platform board
code.

To fix this, instantiate the GIC from platform board code when compiling
a legacy kernel, like is done for the sh73a0 and r8a7740 legacy code.

Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
thanks to him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 85fe016..5d7a009 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -586,11 +586,18 @@ void __init r8a7778_init_delay(void)
 void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	void __iomem *gic_dist_base = ioremap_nocache(0xfe438000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xfe430000, 0x1000);
+#endif
 
 	BUG_ON(!base);
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+#else
 	irqchip_init();
-
+#endif
 	/* route all interrupts to ARM */
 	__raw_writel(0x73ffffff, base + INT2NTSR0);
 	__raw_writel(0xffffffff, base + INT2NTSR1);
-- 
2.1.4
