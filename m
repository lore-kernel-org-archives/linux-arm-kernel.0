From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:48 +0200
Subject: [PATCH v6 04/14] irqchip/irq-mvebu-icu: clarify the reset operation
 of configured interrupts
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-5-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rewrite a small section to clarify the reset operation of interrupts
already configured by ATF that we want to handle in the driver. This
will simplify the introduction of System Error Interrupts support.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index a2a3acd74491..0f2655d7f19e 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -258,8 +258,12 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
-		u32 icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
-		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
+		u32 icu_int, icu_grp;
+
+		icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
+		icu_grp = icu_int >> ICU_GROUP_SHIFT;
+
+		if (icu_grp == ICU_GRP_NSR)
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
 
-- 
2.17.1
