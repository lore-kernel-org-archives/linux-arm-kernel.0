From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:08 +0100
Subject: [PATCH 149/222] imx-drm: ipu-common: add ipu_map_irq to request
 non-IDMAC interrupts
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeY4-0007NE-JA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

This allows to request the DC related interrupts.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |  1 +
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index c4d14ead5837..2966e425990e 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -76,6 +76,7 @@ enum ipu_channel_irq {
 	IPU_IRQ_EOS = 192,
 };
 
+int ipu_map_irq(struct ipu_soc *ipu, int irq);
 int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
 		enum ipu_channel_irq irq);
 
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index ca85d3d70ae3..058551795677 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -933,15 +933,22 @@ static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
-		enum ipu_channel_irq irq_type)
+int ipu_map_irq(struct ipu_soc *ipu, int irq)
 {
-	int irq = irq_linear_revmap(ipu->domain, irq_type + channel->num);
+	int virq;
 
-	if (!irq)
-		irq = irq_create_mapping(ipu->domain, irq_type + channel->num);
+	virq = irq_linear_revmap(ipu->domain, irq);
+	if (!virq)
+		virq = irq_create_mapping(ipu->domain, irq);
+
+	return virq;
+}
+EXPORT_SYMBOL_GPL(ipu_map_irq);
 
-	return irq;
+int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
+		enum ipu_channel_irq irq_type)
+{
+	return ipu_map_irq(ipu, irq_type + channel->num);
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_channel_irq);
 
-- 
1.8.3.1
