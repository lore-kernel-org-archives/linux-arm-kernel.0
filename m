From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:33:28 +1100
Subject: [PATCH 6/6] mfd: mc13xxx-core: ADC conversion with extra capabilities
In-Reply-To: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1327876408-22528-7-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows extra flags to be given at conversion time. This will allow
other drivers to utilize the special channel readings and tweak the adc
operation to their specific needs.
Bit definitions for the ADC0 and ADC0 registers common to both mc13892
and mc13783 are added to include/linux/mfd/mc13xxx.h.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/mc13xxx-core.c  |   23 +++++++++++++++++++++--
 include/linux/mfd/mc13xxx.h |   12 ++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 09d03f5..431d324 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -508,8 +508,9 @@ static irqreturn_t mc13xxx_handler_adcdone(int irq, void *data)
 
 #define MC13XXX_ADC_WORKING (1 << 0)
 
-int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
-		unsigned int channel, unsigned int *sample)
+int mc13xxx_adc_do_conversion_ex(struct mc13xxx *mc13xxx, unsigned int mode,
+		unsigned int channel, unsigned int *sample,
+		u32 adc0mask, u32 adc0val, u32 adc1mask, u32 adc1val)
 {
 	u32 adc0, adc1, old_adc0;
 	int i, ret;
@@ -535,6 +536,16 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
 
+	if (adc0mask) {
+		adc0 &= ~(adc0mask & ~adc0val);
+		adc0 |= (adc0mask & adc0val);
+	}
+
+	if (adc1mask) {
+		adc1 &= ~(adc1mask & ~adc1val);
+		adc1 |= (adc1mask & adc1val);
+	}
+
 	/*
 	 * For the mc13892 not in TS mode the touchscreen inputs
 	 * are being sampled, but channels [8..11] will read 0
@@ -626,6 +637,14 @@ out:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mc13xxx_adc_do_conversion_ex);
+
+int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
+		unsigned int channel, unsigned int *sample)
+{
+	return mc13xxx_adc_do_conversion_ex(mc13xxx, mode, channel, sample,
+			0, 0, 0, 0);
+}
 EXPORT_SYMBOL_GPL(mc13xxx_adc_do_conversion);
 
 static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index df91dd9..0d3d7b3 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -38,6 +38,10 @@ int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
 int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx,
 		unsigned int mode, unsigned int channel, unsigned int *sample);
 
+int mc13xxx_adc_do_conversion_ex(struct mc13xxx *mc13xxx,
+		unsigned int mode, unsigned int channel, unsigned int *sample,
+		u32 adc0mask, u32 adc0val, u32 adc1mask, u32 adc1val);
+
 #define MC13XXX_IRQ_ADCDONE	0
 #define MC13XXX_IRQ_ADCBISDONE	1
 #define MC13XXX_IRQ_TS		2
@@ -171,10 +175,14 @@ struct mc13xxx_platform_data {
 #define MC13XXX_ADC_MODE_MULT_CHAN	3
 
 #define MC13XXX_ADC0		43
+#define MC13XXX_ADC0_LICELLCON		(1 << 0)
+#define MC13XXX_ADC0_CHRGICON		(1 << 1)
+#define MC13XXX_ADC0_BATTICON		(1 << 2)
 #define MC13XXX_ADC0_ADREFEN		(1 << 10)
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
 #define MC13XXX_ADC0_TSMOD2		(1 << 14)
+#define MC13XXX_ADC0_CHRGRAWDIV		(1 << 15)
 #define MC13XXX_ADC0_ADINC1		(1 << 16)
 #define MC13XXX_ADC0_ADINC2		(1 << 17)
 
@@ -182,4 +190,8 @@ struct mc13xxx_platform_data {
 					MC13XXX_ADC0_TSMOD1 | \
 					MC13XXX_ADC0_TSMOD2)
 
+#define MC13XXX_ADC1_ATO_SHIFT		11
+#define MC13XXX_ADC1_ATO_MASK		(0xff << MC13XXX_ADC1_ATO_SHIFT)
+#define MC13XXX_ADC1_ATOX		(1 << 19)
+
 #endif /* ifndef __LINUX_MFD_MC13XXX_H */
-- 
1.7.3.4
