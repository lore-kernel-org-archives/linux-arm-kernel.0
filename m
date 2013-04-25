From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:46 +0200
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init unconditionally
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irqchip_init function is only available when building
with CONFIG_OF enabled, which causes this build failure for
bonito_defconfig:

arch/arm/mach-shmobile/built-in.o: In function `r8a7740_init_irq_of':
:(.init.text+0x580): undefined reference to `irqchip_init'

This makes both the OF and the ATAGS portion of the driver
conditional, which avoids the build error and also results
in smaller object code if not both are enabled, without the
need for an #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bastian Hecht <hechtb+renesas@gmail.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/intc-r8a7740.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 8871f77..5dc57f1 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -53,14 +53,23 @@ static void __init r8a7740_init_irq_common(void)
 
 void __init r8a7740_init_irq_of(void)
 {
+	if (!IS_ENABLED(CONFIG_OF))
+		return;
+
 	irqchip_init();
 	r8a7740_init_irq_common();
 }
 
 void __init r8a7740_init_irq(void)
 {
-	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
-	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
+	void __iomem *gic_dist_base;
+	void __iomem *gic_cpu_base;
+
+	if (!IS_ENABLED(CONFIG_ATAGS))
+		return;
+
+	gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
+	gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
 
 	/* initialize the Generic Interrupt Controller PL390 r0p0 */
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-- 
1.8.1.2
