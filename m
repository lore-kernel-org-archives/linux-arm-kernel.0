From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:33:27 +1100
Subject: [PATCH 5/6] mfd: mc13xxx-core: ADC conv: only preserve TSMOD if TS in
 interrupt mode.
In-Reply-To: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1327876408-22528-6-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change keeps the TS touch interrupt enabled only if the TS is in
interrupt mode (ie only TSMOD0 is set).
This ensures we never inadvertently allow a touchscreen reading in place
of a regular single or multi channel reading (if TSMOD1 is somehow already
set for example).

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 61a767d..09d03f5 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -535,24 +535,34 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
 
+	/*
+	 * For the mc13892 not in TS mode the touchscreen inputs
+	 * are being sampled, but channels [8..11] will read 0
+	 */
 	if (channel > 7)
 		adc1 |= MC13XXX_ADC1_ADSEL;
 
 	switch (mode) {
 	case MC13XXX_ADC_MODE_TS:
+		/*
+		 * for mc13873 this uses position mode,
+		 * mc13892 doesn't care about TSMOD0 when TSMOD1 is set
+		 */
 		adc0 |= MC13XXX_ADC0_ADREFEN | MC13XXX_ADC0_TSMOD0 |
 			MC13XXX_ADC0_TSMOD1;
 		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
 		break;
 
 	case MC13XXX_ADC_MODE_SINGLE_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		if ((old_adc0 & MC13XXX_ADC0_TSMOD_MASK) == MC13XXX_ADC0_TSMOD0)
+			adc0 |= MC13XXX_ADC0_TSMOD0;
 		adc1 |= (channel & 0x7) << MC13XXX_ADC1_CHAN0_SHIFT;
 		adc1 |= MC13XXX_ADC1_RAND;
 		break;
 
 	case MC13XXX_ADC_MODE_MULT_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		if ((old_adc0 & MC13XXX_ADC0_TSMOD_MASK) == MC13XXX_ADC0_TSMOD0)
+			adc0 |= MC13XXX_ADC0_TSMOD0;
 		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
 		break;
 
-- 
1.7.3.4
