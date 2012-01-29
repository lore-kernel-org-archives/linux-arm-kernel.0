From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:33:25 +1100
Subject: [PATCH 3/6] mfd: mc13xxx-core: ADC conv: setup readout for single
 channel
In-Reply-To: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1327876408-22528-4-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC always does 8 conversions, for single channel mode one channel
is converted 8 times and the results are placed in the channels 0..7
This change resets the channel indexes to 0 and 4 so that the 8 individual
samples are read out correctly.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index afff892..56e09ea 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -583,13 +583,26 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
 
-	if (!ret)
+	if (!ret) {
+		if (mode == MC13XXX_ADC_MODE_SINGLE_CHAN) {
+			/*
+			 * Set the channels for read back same as for multi
+			 * channel. Don't use adc1 var from above, or another
+			 * conversion would be started.
+			 */
+			u32 mask = (0x7 << MC13XXX_ADC1_CHAN0_SHIFT) |
+					(0x7 << MC13XXX_ADC1_CHAN1_SHIFT);
+			mc13xxx_reg_rmw(mc13xxx, MC13XXX_ADC1, mask,
+					4 << MC13XXX_ADC1_CHAN1_SHIFT);
+		}
+
 		for (i = 0; i < 4; ++i) {
 			ret = mc13xxx_reg_read(mc13xxx,
 					MC13XXX_ADC2, &sample[i]);
 			if (ret)
 				break;
 		}
+	}
 
 	if (mode == MC13XXX_ADC_MODE_TS)
 		/* restore TSMOD */
-- 
1.7.3.4
