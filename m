From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 14 Jun 2013 18:40:45 +0200
Subject: [PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get IRQ
 flags
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1371228049-27080-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_get_irq_data(irq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/mfd/twl4030-irq.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index a5f9888..9d2d1ba 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -537,16 +537,13 @@ static void twl4030_sih_bus_sync_unlock(struct irq_data *data)
 		/* Modify only the bits we know must change */
 		while (edge_change) {
 			int		i = fls(edge_change) - 1;
-			struct irq_data	*idata;
 			int		byte = i >> 2;
 			int		off = (i & 0x3) * 2;
 			unsigned int	type;
 
-			idata = irq_get_irq_data(i + agent->irq_base);
-
 			bytes[byte] &= ~(0x03 << off);
 
-			type = irqd_get_trigger_type(idata);
+			type = irq_get_trigger_type(i + agent->irq_base);
 			if (type & IRQ_TYPE_EDGE_RISING)
 				bytes[byte] |= BIT(off + 1);
 			if (type & IRQ_TYPE_EDGE_FALLING)
-- 
1.7.7.6
