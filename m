From: robin@protonic.nl (Robin van der Gracht)
Date: Thu, 24 Nov 2011 11:56:00 +0100
Subject: [PATCH] mfd: Fixed unconditional reset of the ADC reading enable bits
Message-ID: <1322132160-7451-1-git-send-email-robin@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ADC is being prepared for a single or multiple channel reading,
the adc0 register is reconfigured without taking the lithium cell, charge
current and battery current reading enable bits into account. Which results
in clearing the bits.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/mfd/mc13xxx-core.c  |    6 ++++--
 include/linux/mfd/mc13xxx.h |    8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 3582f15..201a678 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -618,13 +618,15 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 		break;
 
 	case MC13XXX_ADC_MODE_SINGLE_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		adc0 |= old_adc0 & (MC13XXX_ADC0_TSMOD_MASK |
+			MC13XXX_ADC0_EN_READING_MASK);
 		adc1 |= (channel & 0x7) << MC13XXX_ADC1_CHAN0_SHIFT;
 		adc1 |= MC13XXX_ADC1_RAND;
 		break;
 
 	case MC13XXX_ADC_MODE_MULT_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		adc0 |= old_adc0 & (MC13XXX_ADC0_TSMOD_MASK |
+			MC13XXX_ADC0_EN_READING_MASK);
 		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
 		break;
 
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index f6bd08b..676e07e 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -252,6 +252,9 @@ struct mc13xxx_platform_data {
 
 
 #define MC13XXX_ADC0		43
+#define MC13XXX_ADC0_LICELLCON		(1 << 0)
+#define MC13XXX_ADC0_CHRGICON		(1 << 1)
+#define MC13XXX_ADC0_BATICON		(1 << 2)
 #define MC13XXX_ADC0_ADREFEN		(1 << 10)
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
@@ -263,4 +266,9 @@ struct mc13xxx_platform_data {
 					MC13XXX_ADC0_TSMOD1 | \
 					MC13XXX_ADC0_TSMOD2)
 
+#define MC13XXX_ADC0_EN_READING_MASK	(MC13XXX_ADC0_LICELLCON | \
+					MC13XXX_ADC0_CHRGICON | \
+					MC13XXX_ADC0_BATICON)
+
+
 #endif /* ifndef __LINUX_MFD_MC13XXX_H */
-- 
1.7.4.1
