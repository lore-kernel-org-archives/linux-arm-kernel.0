From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 13 Aug 2018 17:11:44 +0200
Subject: [PATCH] irqchip/s3c24xx: Remove unneeded comparison of unsigned long
 to 0
Message-ID: <20180813151144.12407-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_data->hwirq is unsigned long.  This fixes GCC warning:

    drivers/irqchip/irq-s3c24xx.c: In function 's3c_irqext0_type':
    drivers/irqchip/irq-s3c24xx.c:253:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
                       ^~

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/irqchip/irq-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index f6fd57ebe6e6..c19766fe8a1a 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -250,7 +250,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 	void __iomem *gpcon_reg;
 	unsigned long gpcon_offset, extint_offset;
 
-	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+	if (data->hwirq <= 3) {
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
 		gpcon_offset = (data->hwirq) * 2;
-- 
2.14.1
