From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 10 Mar 2010 11:11:45 -0600
Subject: [PATCH] locomo.c: spi register offset bugfix
Message-ID: <0D753D10438DA54287A00B027084269763683A71C0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The locomo spi registers are all defined in locomo.h as offsets
from the first spi register LOCOMO_SPI (0x60), which is itself
an offset from the locomo base address.  To correctly access
these registers LOCOMO_SPI must always be included in the
address calculation.

There are two places in locomo.c where this is not done.  The
first one, in locomo_suspend, actually results in a write to
LOCOMO_ST instead of LOCOMO_SPICT.  The second is in __locomo_probe
and results in a write to LOCOMO_MCSX2 instead of LOCOMO_SPIIE.

Fix these by including LOCOMO_SPI in the calculation.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Eric Miao <eric.y.miao@gmail.com>

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 90ae00b..4f9ccf6 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -290,7 +290,7 @@ static int locomo_suspend(struct platform_device *dev, pm_message_t state)
 	save->LCM_GPO     = locomo_readl(lchip->base + LOCOMO_GPO);	/* GPIO */
 	locomo_writel(0x00, lchip->base + LOCOMO_GPO);
 	save->LCM_SPICT   = locomo_readl(lchip->base + LOCOMO_SPI + LOCOMO_SPICT);	/* SPI */
-	locomo_writel(0x40, lchip->base + LOCOMO_SPICT);
+	locomo_writel(0x40, lchip->base + LOCOMO_SPI + LOCOMO_SPICT);
 	save->LCM_GPE     = locomo_readl(lchip->base + LOCOMO_GPE);	/* GPIO */
 	locomo_writel(0x00, lchip->base + LOCOMO_GPE);
 	save->LCM_ASD     = locomo_readl(lchip->base + LOCOMO_ASD);	/* ADSTART */
@@ -418,7 +418,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 	/* Longtime timer */
 	locomo_writel(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */
-	locomo_writel(0, lchip->base + LOCOMO_SPIIE);
+	locomo_writel(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
 
 	locomo_writel(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
 	r = locomo_readl(lchip->base + LOCOMO_ASD);
