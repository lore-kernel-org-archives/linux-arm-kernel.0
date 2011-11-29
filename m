From: robin@protonic.nl (Robin van der Gracht)
Date: Tue, 29 Nov 2011 12:09:03 +0100
Subject: [PATCH V3] mfd: Fixed unconditional reset of the ADC reading enable
 bits
Message-ID: <1322564943-17872-1-git-send-email-robin@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ADC is being prepared for a single or multiple channel reading,
the adc0 register is reconfigured without taking the lithium cell, charge
current and battery current reading enable bits into account. Which results
in clearing the bits.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---

V3: Removed the added tabular at the definition of MC13XXX_ADC0,
so the offset equals the idention used in 'drivers/mfd/mc13xxx-core.c'


 drivers/mfd/mc13xxx-core.c  |    4 ++--
 include/linux/mfd/mc13xxx.h |    8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index e9619ac..5315999 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -615,13 +615,13 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 		break;
 
 	case MC13XXX_ADC_MODE_SINGLE_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		adc0 |= old_adc0 & MC13XXX_ADC0_CONFIG_MASK;
 		adc1 |= (channel & 0x7) << MC13XXX_ADC1_CHAN0_SHIFT;
 		adc1 |= MC13XXX_ADC1_RAND;
 		break;
 
 	case MC13XXX_ADC_MODE_MULT_CHAN:
-		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
+		adc0 |= old_adc0 & MC13XXX_ADC0_CONFIG_MASK;
 		adc1 |= 4 << MC13XXX_ADC1_CHAN1_SHIFT;
 		break;
 
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 3816c2f..261fc11 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -173,6 +173,9 @@ struct mc13xxx_platform_data {
 #define MC13XXX_ADC_MODE_MULT_CHAN	3
 
 #define MC13XXX_ADC0		43
+#define MC13XXX_ADC0_LICELLCON		(1 << 0)
+#define MC13XXX_ADC0_CHRGICON		(1 << 1)
+#define MC13XXX_ADC0_BATICON		(1 << 2)
 #define MC13XXX_ADC0_ADREFEN		(1 << 10)
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
@@ -184,4 +187,9 @@ struct mc13xxx_platform_data {
 					MC13XXX_ADC0_TSMOD1 | \
 					MC13XXX_ADC0_TSMOD2)
 
+#define MC13XXX_ADC0_CONFIG_MASK	(MC13XXX_ADC0_TSMOD_MASK | \
+					MC13XXX_ADC0_LICELLCON | \
+					MC13XXX_ADC0_CHRGICON | \
+					MC13XXX_ADC0_BATICON)
+
 #endif /* ifndef __LINUX_MFD_MC13XXX_H */
-- 
1.7.4.1
