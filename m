From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 20:13:36 +0000
Subject: [GIT PULL] Samsung devel-2 for v3.5
In-Reply-To: <092f01cd332c$00df3c60$029db520$%kim@samsung.com>
References: <092f01cd332c$00df3c60$029db520$%kim@samsung.com>
Message-ID: <201205162013.37031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Kukjin Kim wrote:

> Note, this branch has a dependency on next/cleanup-plat-s5p which is already
> in next/cleanup2 of arm-soc.
> 
> If any problems, please kindly let me know.

I've hit a build problem with exynos4_defconfig, which I fixed using this patch.

	Arnd
 
commit 820f3dd7964f1889baaaaa0c2ba45d05bb619f66
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed May 16 22:10:14 2012 +0200

    ARM: exynos: fix building with CONFIG_OF disabled
    
    irq_of_parse_and_map does not have an empty definition for the
    !CONFIG_OF case, so we should not try to call it then:
    
    arch/arm/mach-exynos/common.c: In function 'combiner_init':
    arch/arm/mach-exynos/common.c:576:3: warning: implicit declaration of function 'irq_of_parse_and_map'
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 9900158..4913471 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -568,7 +568,11 @@ void __init combiner_init(void __iomem *combiner_base, struct device_node *np)
 
 	for (i = 0; i < max_nr; i++) {
 		combiner_init_one(i, combiner_base + (i >> 2) * 0x10);
-		irq = np ? irq_of_parse_and_map(np, i) : IRQ_SPI(i);
+		irq = IRQ_SPI(i);
+#ifdef CONFIG_OF
+		if (np)
+			irq = irq_of_parse_and_map(np, i);
+#endif
 		combiner_cascade_irq(i, irq);
 	}
 }
