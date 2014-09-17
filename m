From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 17 Sep 2014 13:53:17 +0530
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20ARM=3A=20imx=3A=20vf610-adc=3A=20Add=20temperature=20sensor=20support?=
In-Reply-To: <cover.1410873422.git.maitysanchayan@gmail.com>
References: <cover.1410873422.git.maitysanchayan@gmail.com>
Message-ID: <0cd6b1bdf146a0c9024a804742078ce77a38e184.1410873422.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vybrid ADC module includes a temperature sensor which
is connected to channel number 26. This patch adds
support for the sensor. The raw value is read and the
temperature calculated in degree Celsius which is
returned using the IIO_CHAN_INFO_PROCESSED option.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/iio/adc/vf610_adc.c |   34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 44799eb5..aa682aa 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -91,7 +91,7 @@
 #define VF610_ADC_CAL			0x80
 
 /* Other field define */
-#define VF610_ADC_ADCHC(x)		((x) & 0xF)
+#define VF610_ADC_ADCHC(x)		((x) & 0x1F)
 #define VF610_ADC_AIEN			(0x1 << 7)
 #define VF610_ADC_CONV_DISABLE		0x1F
 #define VF610_ADC_HS_COCO0		0x1
@@ -137,7 +137,7 @@ struct vf610_adc {
 	struct clk *clk;
 
 	u32 vref_uv;
-	u32 value;
+	int value;
 	struct regulator *vref;
 	struct vf610_adc_feature adc_feature;
 
@@ -153,6 +153,15 @@ struct vf610_adc {
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 }
 
+#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {		\
+	.type = (_chan_type),					\
+	.indexed = 1,							\
+	.channel = (_idx),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
 static const struct iio_chan_spec vf610_adc_iio_channels[] = {
 	VF610_ADC_CHAN(0, IIO_VOLTAGE),
 	VF610_ADC_CHAN(1, IIO_VOLTAGE),
@@ -170,6 +179,7 @@ static const struct iio_chan_spec vf610_adc_iio_channels[] = {
 	VF610_ADC_CHAN(13, IIO_VOLTAGE),
 	VF610_ADC_CHAN(14, IIO_VOLTAGE),
 	VF610_ADC_CHAN(15, IIO_VOLTAGE),
+	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
 	/* sentinel */
 };
 
@@ -451,6 +461,7 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&indio_dev->mlock);
 		reinit_completion(&info->completion);
 
@@ -468,7 +479,24 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 
-		*val = info->value;
+		switch (chan->type)	{
+		case IIO_VOLTAGE:
+			*val = info->value;
+			break;
+		case IIO_TEMP:
+			/*
+			* Calculate in degree celsius times 1000
+			* Using sensor slope of 1.84 mV/?C and
+			* V at 25?C of 696mv
+			*/
+			info->value -= 864;
+			info->value = 25000 - info->value * 1000000 / 1840;
+			*val = info->value;
+			break;
+		default:
+			break;
+		}
+
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 
-- 
1.7.9.5
