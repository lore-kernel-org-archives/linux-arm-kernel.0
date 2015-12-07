From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:19 +0000
Subject: [PATCH 06/19] mfd: ab8500-gpadc: Squash a whole bunch of Checkpatch
 warnings and one error
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: line over 80 characters
+#define ADC_CH_IBAT_MIN                        (-6000) /* mA range measured by ADC for ib
t*/

WARNING: line over 80 characters
+#define ADC_CH_IBAT_MIN_V              (-60)   /* mV range measured by ADC for ibat*/

WARNING: suspect code indent for conditional statements (16, 20)
+               if (!strcmp(name, dev_name(gpadc->dev)))
+                   return gpadc;

WARNING: suspect code indent for conditional statements (0, 16)
+if (ad_value < 0) {
+               dev_err(gpadc->dev, "GPADC raw value failed ch: %d\n",

WARNING: quoted string split across lines
+               dev_err(gpadc->dev, "GPADC to voltage conversion failed ch:"
+                       " %d AD: 0x%x\n", channel, ad_value);

WARNING: Missing a blank line after declarations
+       int raw_data;
+       raw_data = ab8500_gpadc_double_read_raw(gpadc, channel,

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(10);

ERROR: else should follow close brace '}'
+       }
+       else

WARNING: line over 80 characters
+                       delay_max = 10000; /* large range to optimise sleep mode */

WARNING: line over 80 characters
+                       gpadc->cal_data[ADC_INPUT_IBAT].gain = V_gain * V2A_gain;

WARNING: line over 80 characters
+       gpadc = devm_kzalloc(&pdev->dev, sizeof(struct ab8500_gpadc), GFP_KERNEL);

WARNING: Possible unnecessary 'out of memory' message
+       if (!gpadc) {
+               dev_err(&pdev->dev, "Error: No memory\n");

WARNING: space prohibited before semicolon
+       return ;

WARNING: void function return statements are not generally useful
+       return ;
+}

WARNING: quoted string split across lines
+MODULE_AUTHOR("Arun R Murthy, Daniel Willerud, Johan Palsson,"
+               "M'boumba Cedric Madianga");

total: 1 errors, 14 warnings, 1089 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-gpadc.c | 145 +++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 72 deletions(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index c51c1b1..97dcadc 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -49,61 +49,61 @@
  * OTP register offsets
  * Bank : 0x15
  */
-#define AB8500_GPADC_CAL_1		0x0F
-#define AB8500_GPADC_CAL_2		0x10
-#define AB8500_GPADC_CAL_3		0x11
-#define AB8500_GPADC_CAL_4		0x12
-#define AB8500_GPADC_CAL_5		0x13
-#define AB8500_GPADC_CAL_6		0x14
-#define AB8500_GPADC_CAL_7		0x15
+#define AB8500_GPADC_CAL_1	0x0F
+#define AB8500_GPADC_CAL_2	0x10
+#define AB8500_GPADC_CAL_3	0x11
+#define AB8500_GPADC_CAL_4	0x12
+#define AB8500_GPADC_CAL_5	0x13
+#define AB8500_GPADC_CAL_6	0x14
+#define AB8500_GPADC_CAL_7	0x15
 /* New calibration for 8540 */
 #define AB8540_GPADC_OTP4_REG_7	0x38
 #define AB8540_GPADC_OTP4_REG_6	0x39
 #define AB8540_GPADC_OTP4_REG_5	0x3A
 
 /* gpadc constants */
-#define EN_VINTCORE12			0x04
-#define EN_VTVOUT			0x02
-#define EN_GPADC			0x01
-#define DIS_GPADC			0x00
-#define AVG_1				0x00
-#define AVG_4				0x20
-#define AVG_8				0x40
-#define AVG_16				0x60
-#define ADC_SW_CONV			0x04
-#define EN_ICHAR			0x80
-#define BTEMP_PULL_UP			0x08
-#define EN_BUF				0x40
-#define DIS_ZERO			0x00
-#define GPADC_BUSY			0x01
-#define EN_FALLING			0x10
-#define EN_TRIG_EDGE			0x02
-#define EN_VBIAS_XTAL_TEMP		0x02
+#define EN_VINTCORE12		0x04
+#define EN_VTVOUT		0x02
+#define EN_GPADC		0x01
+#define DIS_GPADC		0x00
+#define AVG_1			0x00
+#define AVG_4			0x20
+#define AVG_8			0x40
+#define AVG_16			0x60
+#define ADC_SW_CONV		0x04
+#define EN_ICHAR		0x80
+#define BTEMP_PULL_UP		0x08
+#define EN_BUF			0x40
+#define DIS_ZERO		0x00
+#define GPADC_BUSY		0x01
+#define EN_FALLING		0x10
+#define EN_TRIG_EDGE		0x02
+#define EN_VBIAS_XTAL_TEMP	0x02
 
 /* GPADC constants from AB8500 spec, UM0836 */
-#define ADC_RESOLUTION			1024
-#define ADC_CH_BTEMP_MIN		0
-#define ADC_CH_BTEMP_MAX		1350
-#define ADC_CH_DIETEMP_MIN		0
-#define ADC_CH_DIETEMP_MAX		1350
-#define ADC_CH_CHG_V_MIN		0
-#define ADC_CH_CHG_V_MAX		20030
-#define ADC_CH_ACCDET2_MIN		0
-#define ADC_CH_ACCDET2_MAX		2500
-#define ADC_CH_VBAT_MIN			2300
-#define ADC_CH_VBAT_MAX			4800
-#define ADC_CH_CHG_I_MIN		0
-#define ADC_CH_CHG_I_MAX		1500
-#define ADC_CH_BKBAT_MIN		0
-#define ADC_CH_BKBAT_MAX		3200
+#define ADC_RESOLUTION		1024
+#define ADC_CH_BTEMP_MIN	0
+#define ADC_CH_BTEMP_MAX	1350
+#define ADC_CH_DIETEMP_MIN	0
+#define ADC_CH_DIETEMP_MAX	1350
+#define ADC_CH_CHG_V_MIN	0
+#define ADC_CH_CHG_V_MAX	20030
+#define ADC_CH_ACCDET2_MIN	0
+#define ADC_CH_ACCDET2_MAX	2500
+#define ADC_CH_VBAT_MIN		2300
+#define ADC_CH_VBAT_MAX		4800
+#define ADC_CH_CHG_I_MIN	0
+#define ADC_CH_CHG_I_MAX	1500
+#define ADC_CH_BKBAT_MIN	0
+#define ADC_CH_BKBAT_MAX	3200
 
 /* GPADC constants from AB8540 spec */
-#define ADC_CH_IBAT_MIN			(-6000) /* mA range measured by ADC for ibat*/
-#define ADC_CH_IBAT_MAX			6000
-#define ADC_CH_IBAT_MIN_V		(-60)	/* mV range measured by ADC for ibat*/
-#define ADC_CH_IBAT_MAX_V		60
-#define IBAT_VDROP_L			(-56)  /* mV */
-#define IBAT_VDROP_H			56
+#define ADC_CH_IBAT_MIN		(-6000) /* mA range measured by ADC for ibat */
+#define ADC_CH_IBAT_MAX		6000
+#define ADC_CH_IBAT_MIN_V	(-60)	/* mV range measured by ADC for ibat */
+#define ADC_CH_IBAT_MAX_V	60
+#define IBAT_VDROP_L		(-56)  /* mV */
+#define IBAT_VDROP_H		56
 
 /* This is used to not lose precision when dividing to get gain and offset */
 #define CALIB_SCALE		1000
@@ -179,7 +179,7 @@ struct ab8500_gpadc *ab8500_gpadc_get(char *name)
 
 	list_for_each_entry(gpadc, &ab8500_gpadc_list, node) {
 		if (!strcmp(name, dev_name(gpadc->dev)))
-		    return gpadc;
+			return gpadc;
 	}
 
 	return ERR_PTR(-ENOENT);
@@ -315,11 +315,12 @@ int ab8500_gpadc_sw_hw_convert(struct ab8500_gpadc *gpadc, u8 channel,
 
 	ad_value = ab8500_gpadc_read_raw(gpadc, channel, avg_sample,
 			trig_edge, trig_timer, conv_type);
-/* On failure retry a second time */
+
+	/* On failure retry a second time */
 	if (ad_value < 0)
 		ad_value = ab8500_gpadc_read_raw(gpadc, channel, avg_sample,
 			trig_edge, trig_timer, conv_type);
-if (ad_value < 0) {
+	if (ad_value < 0) {
 		dev_err(gpadc->dev, "GPADC raw value failed ch: %d\n",
 				channel);
 		return ad_value;
@@ -327,8 +328,9 @@ if (ad_value < 0) {
 
 	voltage = ab8500_gpadc_ad_to_voltage(gpadc, channel, ad_value);
 	if (voltage < 0)
-		dev_err(gpadc->dev, "GPADC to voltage conversion failed ch:"
-			" %d AD: 0x%x\n", channel, ad_value);
+		dev_err(gpadc->dev,
+			"GPADC to voltage conversion failed ch: %d AD: 0x%x\n",
+			channel, ad_value);
 
 	return voltage;
 }
@@ -348,10 +350,9 @@ EXPORT_SYMBOL(ab8500_gpadc_sw_hw_convert);
 int ab8500_gpadc_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
 		u8 avg_sample, u8 trig_edge, u8 trig_timer, u8 conv_type)
 {
-	int raw_data;
-	raw_data = ab8500_gpadc_double_read_raw(gpadc, channel,
-			avg_sample, trig_edge, trig_timer, conv_type, NULL);
-	return raw_data;
+	return ab8500_gpadc_double_read_raw(gpadc, channel, avg_sample,
+					    trig_edge, trig_timer, conv_type,
+					    NULL);
 }
 
 int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
@@ -388,7 +389,7 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
 			goto out;
 		if (!(val & GPADC_BUSY))
 			break;
-		msleep(10);
+		msleep(20);
 	} while (++looplimit < 10);
 	if (looplimit >= 10 && (val & GPADC_BUSY)) {
 		dev_err(gpadc->dev, "gpadc_conversion: GPADC busy");
@@ -421,8 +422,7 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
 		val_reg1 |= EN_TRIG_EDGE;
 		if (trig_edge)
 			val_reg1 |= EN_FALLING;
-	}
-	else
+	} else
 		ret = abx500_set_register_interruptible(gpadc->dev,
 				AB8500_GPADC, AB8500_GPADC_CTRL2_REG, val);
 	if (ret < 0) {
@@ -449,7 +449,7 @@ int ab8500_gpadc_double_read_raw(struct ab8500_gpadc *gpadc, u8 channel,
 			* remove when hardware will be availible
 			*/
 			delay_min = 1000; /* Delay in micro seconds */
-			delay_max = 10000; /* large range to optimise sleep mode */
+			delay_max = 10000; /* large range optimises sleepmode */
 			break;
 		}
 		/* Intentional fallthrough */
@@ -785,9 +785,10 @@ static void ab8500_gpadc_read_calibration_data(struct ab8500_gpadc *gpadc)
 				<< CALIB_SHIFT_IBAT)
 				/ (ADC_CH_IBAT_MAX_V - ADC_CH_IBAT_MIN_V);
 
-			gpadc->cal_data[ADC_INPUT_IBAT].gain = V_gain * V2A_gain;
-			gpadc->cal_data[ADC_INPUT_IBAT].offset = V_offset *
-				V2A_gain + V2A_offset;
+			gpadc->cal_data[ADC_INPUT_IBAT].gain =
+				V_gain * V2A_gain;
+			gpadc->cal_data[ADC_INPUT_IBAT].offset =
+				V_offset * V2A_gain + V2A_offset;
 		} else {
 			gpadc->cal_data[ADC_INPUT_IBAT].gain = 0;
 		}
@@ -923,11 +924,10 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct ab8500_gpadc *gpadc;
 
-	gpadc = devm_kzalloc(&pdev->dev, sizeof(struct ab8500_gpadc), GFP_KERNEL);
-	if (!gpadc) {
-		dev_err(&pdev->dev, "Error: No memory\n");
+	gpadc = devm_kzalloc(&pdev->dev,
+			     sizeof(struct ab8500_gpadc), GFP_KERNEL);
+	if (!gpadc)
 		return -ENOMEM;
-	}
 
 	gpadc->irq_sw = platform_get_irq_byname(pdev, "SW_CONV_END");
 	if (gpadc->irq_sw < 0)
@@ -1072,18 +1072,19 @@ void ab8540_gpadc_get_otp(struct ab8500_gpadc *gpadc,
 	*vmain_h = gpadc->cal_data[ADC_INPUT_VMAIN].otp_calib_hi;
 	*btemp_l = gpadc->cal_data[ADC_INPUT_BTEMP].otp_calib_lo;
 	*btemp_h = gpadc->cal_data[ADC_INPUT_BTEMP].otp_calib_hi;
-	*vbat_l = gpadc->cal_data[ADC_INPUT_VBAT].otp_calib_lo;
-	*vbat_h = gpadc->cal_data[ADC_INPUT_VBAT].otp_calib_hi;
-	*ibat_l = gpadc->cal_data[ADC_INPUT_IBAT].otp_calib_lo;
-	*ibat_h = gpadc->cal_data[ADC_INPUT_IBAT].otp_calib_hi;
-	return ;
+	*vbat_l  = gpadc->cal_data[ADC_INPUT_VBAT].otp_calib_lo;
+	*vbat_h  = gpadc->cal_data[ADC_INPUT_VBAT].otp_calib_hi;
+	*ibat_l  = gpadc->cal_data[ADC_INPUT_IBAT].otp_calib_lo;
+	*ibat_h  = gpadc->cal_data[ADC_INPUT_IBAT].otp_calib_hi;
 }
 
 subsys_initcall_sync(ab8500_gpadc_init);
 module_exit(ab8500_gpadc_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Arun R Murthy, Daniel Willerud, Johan Palsson,"
-		"M'boumba Cedric Madianga");
+MODULE_AUTHOR("Arun R Murthy");
+MODULE_AUTHOR("Daniel Willerud");
+MODULE_AUTHOR("Johan Palsson");
+MODULE_AUTHOR("M'boumba Cedric Madianga");
 MODULE_ALIAS("platform:ab8500_gpadc");
 MODULE_DESCRIPTION("AB8500 GPADC driver");
-- 
1.9.1
