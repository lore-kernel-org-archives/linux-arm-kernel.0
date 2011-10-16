From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:09:13 +0200
Subject: [PATCH 04/11] ARM: at91/pata: use gpio_is_valid to check the gpio
In-Reply-To: <20111016190528.GI1459@game.jcrosoft.org>
References: <20111016190528.GI1459@game.jcrosoft.org>
Message-ID: <1318792160-23279-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/ata/pata_at91.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 960c725..3915353 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -360,7 +360,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 	ap->pio_mask = ATA_PIO4;
 
-	if (!irq) {
+	if (!gpio_is_valid(irq)) {
 		ap->flags |= ATA_FLAG_PIO_POLLING;
 		ata_port_desc(ap, "no IRQ, using PIO polling");
 	}
@@ -414,8 +414,8 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 
 	host->private_data = info;
 
-	return ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
-			irq ? ata_sff_interrupt : NULL,
+	return ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
+			gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
 			irq_flags, &pata_at91_sht);
 
 err_put:
-- 
1.7.7
