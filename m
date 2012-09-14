From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:46 +0200
Subject: [PATCH 18/24] ARM: samsung: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-samsung/s5p-irq-gpioint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/s5p-irq-gpioint.c b/arch/arm/plat-samsung/s5p-irq-gpioint.c
index f9431fe..23557d3 100644
--- a/arch/arm/plat-samsung/s5p-irq-gpioint.c
+++ b/arch/arm/plat-samsung/s5p-irq-gpioint.c
@@ -24,7 +24,7 @@
 
 #include <asm/mach/irq.h>
 
-#define GPIO_BASE(chip)		(((unsigned long)(chip)->base) & 0xFFFFF000u)
+#define GPIO_BASE(chip)		((void __iomem *)((unsigned long)((chip)->base) & 0xFFFFF000u))
 
 #define CON_OFFSET		0x700
 #define MASK_OFFSET		0x900
@@ -153,7 +153,7 @@ static __init int s5p_gpioint_add(struct samsung_gpio_chip *chip)
 	bank->chips[group - bank->start] = chip;
 
 	gc = irq_alloc_generic_chip("s5p_gpioint", 1, chip->irq_base,
-				    (void __iomem *)GPIO_BASE(chip),
+				    GPIO_BASE(chip),
 				    handle_level_irq);
 	if (!gc)
 		return -ENOMEM;
-- 
1.7.10
