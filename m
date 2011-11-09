From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:30 +0800
Subject: [PATCH v7 10/11] ARM: mmp: clear gpio edge detect
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-11-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append code to clear gpio edge detect in gpio-pxa driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/gpio/gpio-pxa.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 079f97f..bfd7555 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -46,6 +46,7 @@
 #define GFER_OFFSET	0x3C
 #define GEDR_OFFSET	0x48
 #define GAFR_OFFSET	0x54
+#define ED_MASK_OFFSET	0x9C	/* GPIO edge detection for AP side */
 
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
@@ -496,6 +497,9 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 		writel_relaxed(0, c->regbase + GFER_OFFSET);
 		writel_relaxed(0, c->regbase + GRER_OFFSET);
 		writel_relaxed(~0,c->regbase + GEDR_OFFSET);
+		/* unmask GPIO edge detect for AP side */
+		if (gpio_is_mmp_type(gpio_type))
+			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
 	}
 
 #ifdef CONFIG_ARCH_PXA
-- 
1.7.4.1
