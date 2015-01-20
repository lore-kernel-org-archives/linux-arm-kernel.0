From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:26:41 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7779: Instantiate GIC from C board code
 in legacy builds
In-Reply-To: <cover.1421716614.git.horms+renesas@verge.net.au>
References: <cover.1421716614.git.horms+renesas@verge.net.au>
Message-ID: <f469cde20a7ee342070b4a459b6fce469a3186db.1421716614.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), Marzen legacy hangs during boot with:

   Image Name:   'Linux-3.19.0-rc4'
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3445880 Bytes = 3.3 MiB
   Load Address: 60008000
   Entry Point:  60008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Enabling DEBUG_LL does not seem to change the situation, however this
patch by itself fixes this issue and re-enables normal boot.

This issue happens because the IRQ numbers of the GIC are now virtual,
and no longer match the hardcoded hardware IRQ numbers in the platform
board code.

To fix this, instantiate the GIC from platform board code when compiling
a legacy kernel, like is done for the sh73a0, r8a7740 and r8a7778 legacy code.

Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
thanks to him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 434d150..ca60683 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -724,10 +724,17 @@ static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 
 void __init r8a7779_init_irq_dt(void)
 {
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	void __iomem *gic_dist_base = ioremap_nocache(0xf0001000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xf0000100, 0x1000);
+#endif
 	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+#else
 	irqchip_init();
-
+#endif
 	/* route all interrupts to ARM */
 	__raw_writel(0xffffffff, INT2NTSR0);
 	__raw_writel(0x3fffffff, INT2NTSR1);
-- 
2.1.4
