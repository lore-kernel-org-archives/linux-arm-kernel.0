From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:33:23 +1100
Subject: [PATCH 1/6] mfd: mc13xxx-core: ADC conv: ack existing pending irqs
 before requesting
In-Reply-To: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1327876408-22528-2-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This acks any existing pending ADCDONE irqs before requesting one for the
new conversion, rather than after.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 1fd265d..8cb83ef 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -561,9 +561,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	}
 
 	dev_dbg(mc13xxx->dev, "%s: request irq\n", __func__);
+	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_ADCDONE);
 	mc13xxx_irq_request(mc13xxx, MC13XXX_IRQ_ADCDONE,
 			mc13xxx_handler_adcdone, __func__, &adcdone_data);
-	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_ADCDONE);
 
 	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
 	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
-- 
1.7.3.4
