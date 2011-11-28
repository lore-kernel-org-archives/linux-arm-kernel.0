From: robin@protonic.nl (Robin van der Gracht)
Date: Mon, 28 Nov 2011 12:20:47 +0100
Subject: [PATCH V2] mfd: Fixed mixed up ADC single channel readout
Message-ID: <1322479247-13318-1-git-send-email-robin@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In single channel mode, when reading the ADC result, the index value
is still set to the channel selected for this reading.
This mixes up the order of the values returned. This causes problems when
the converted results are made available in pairs (i.e. battery current reading)
To straighten this up, the index value needs to be reset, so that the
converted values are read at the assigned channel.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---

V2: Resetting the index value at ADA1[2:0] to 0 after the conversion, will ensure that
ADD1[9:0] contains the adc result of channel 0 at first readout. 
We also need to set ADA2[2:0] to 4 before the first readout occures,
so ADD2[9:0] contain the adc result of channel 4. They boath auto increment after each readout.
I removed it from the switch statement becouse ADA2[2:0] is now set to 4 in all modes.

 drivers/mfd/mc13xxx-core.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index e6bb4b3..2e99e83 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -604,7 +604,8 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
-	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
+	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN |
+		MC13XXX_ADC1_ASC | (4 << MC13XXX_ADC1_CHAN1_SHIFT);
 
 	if (channel > 7)
 		adc1 |= MC13XXX_ADC1_ADSEL;
@@ -613,8 +614,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	case MC13XXX_ADC_MODE_TS:
 		adc0 |= MC13XXX_ADC0_ADREFEN | MC13XXX_ADC0_TSMOD0 |
 			MC13XXX_ADC0_TSMOD1;
-		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT | MC13XXX_ADC1_ATOX |
-			(4 << MC13XXX_ADC1_ATO_SHIFT);
+		adc1 |= MC13XXX_ADC1_ATOX | (4 << MC13XXX_ADC1_ATO_SHIFT);
 		break;
 
 	case MC13XXX_ADC_MODE_SINGLE_CHAN:
@@ -625,7 +625,6 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	case MC13XXX_ADC_MODE_MULT_CHAN:
 		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
-		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
 		break;
 
 	default:
@@ -650,6 +649,10 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx_lock(mc13xxx);
 
+	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC1, &adc1);
+	adc1 &= ~(0x7 << MC13XXX_ADC1_CHAN0_SHIFT);
+	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
+
 	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
 
 	if (ret > 0)
-- 
1.7.4.1
