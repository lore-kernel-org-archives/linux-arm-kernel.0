From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 9 Dec 2011 10:50:55 +0100
Subject: [PATCH 3/4] rtc-s3c: add variants for S3C2443 and S3C2416
In-Reply-To: <201112091046.26563.heiko@sntech.de>
References: <201112091046.26563.heiko@sntech.de>
Message-ID: <201112091050.55775.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Especially the TICNT registers are different from the two rtc types
that currently exists.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/include/plat/regs-rtc.h |   24 +++++++++++++
 drivers/rtc/rtc-s3c.c                         |   44 ++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-rtc.h b/arch/arm/plat-samsung/include/plat/regs-rtc.h
index d9d9bdc..fa6066a 100644
--- a/arch/arm/plat-samsung/include/plat/regs-rtc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-rtc.h
@@ -23,14 +23,33 @@
 #define S3C2410_RTCCON_CLKSEL	(1 << 1)
 #define S3C2410_RTCCON_CNTSEL	(1 << 2)
 #define S3C2410_RTCCON_CLKRST	(1 << 3)
+#define S3C2443_RTCCON_TICSEL	(1 << 4)
 #define S3C64XX_RTCCON_TICEN	(1 << 8)
 
 #define S3C64XX_RTCCON_TICMSK	(0xF << 7)
 #define S3C64XX_RTCCON_TICSHT	(7)
 
+#define S3C2416_RTCCON_TICMSK	(0x1F << 7)
+
 #define S3C2410_TICNT		S3C2410_RTCREG(0x44)
 #define S3C2410_TICNT_ENABLE	(1 << 7)
 
+/* S3C2443: tick count is 15 bit wide
+ * TICNT[6:0] contains upper 7 bits
+ * TICNT1[7:0] contains lower 8 bits
+ */
+#define S3C2443_TICNT_PART(x)	((x & 0x7f00) >> 8)
+#define S3C2443_TICNT1		S3C2410_RTCREG(0x4C)
+#define S3C2443_TICNT1_PART(x)	(x & 0xff)
+
+/* S3C2416: tick count is 32 bit wide
+ * TICNT[6:0] contains bits [14:8]
+ * TICNT1[7:0] contains lower 8 bits
+ * TICNT2[16:0] contains upper 17 bits
+ */
+#define S3C2416_TICNT2		S3C2410_RTCREG(0x48)
+#define S3C2416_TICNT2_PART(x)	((x & 0xffff8000) >> 15)
+
 #define S3C2410_RTCALM		S3C2410_RTCREG(0x50)
 #define S3C2410_RTCALM_ALMEN	(1 << 6)
 #define S3C2410_RTCALM_YEAREN	(1 << 5)
@@ -63,4 +82,9 @@
 #define S3C2410_RTCMON		S3C2410_RTCREG(0x84)
 #define S3C2410_RTCYEAR		S3C2410_RTCREG(0x88)
 
+#define S3C2443_TICKCNT		S3C2410_RTCREG(0x90)
+
+#define S3C2443_RTCLBAT		S3C2410_RTCREG(0x94)
+#define S3C2443_RTCLBAT_CLEAR	(1 << 0)
+
 #endif /* __ASM_ARCH_REGS_RTC_H */
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 71807a6..2a0692e 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -35,6 +35,8 @@
 
 enum s3c_cpu_type {
 	TYPE_S3C2410,
+	TYPE_S3C2443,
+	TYPE_S3C2416,
 	TYPE_S3C64XX,
 };
 
@@ -132,6 +134,7 @@ static int s3c_rtc_setfreq(struct device *dev, int freq)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_device *rtc_dev = platform_get_drvdata(pdev);
 	unsigned int tmp = 0;
+	int val;
 
 	if (!is_power_of_2(freq))
 		return -EINVAL;
@@ -139,12 +142,23 @@ static int s3c_rtc_setfreq(struct device *dev, int freq)
 	clk_enable(rtc_clk);
 	spin_lock_irq(&s3c_rtc_pie_lock);
 
-	if (s3c_rtc_cpu_type == TYPE_S3C2410) {
+	if (s3c_rtc_cpu_type != TYPE_S3C64XX) {
 		tmp = readb(s3c_rtc_base + S3C2410_TICNT);
 		tmp &= S3C2410_TICNT_ENABLE;
 	}
 
-	tmp |= (rtc_dev->max_user_freq / freq)-1;
+	val = (rtc_dev->max_user_freq / freq) - 1;
+
+	if (s3c_rtc_cpu_type == TYPE_S3C2443) {
+		tmp |= S3C2443_TICNT_PART(val);
+		writel(S3C2443_TICNT1_PART(val), s3c_rtc_base + S3C2443_TICNT1);
+	} else if (s3c_rtc_cpu_type == TYPE_S3C2416) {
+		tmp |= S3C2443_TICNT_PART(val);
+		writel(S3C2443_TICNT1_PART(val), s3c_rtc_base + S3C2443_TICNT1);
+		writel(S3C2416_TICNT2_PART(val), s3c_rtc_base + S3C2416_TICNT2);
+	} else {
+		tmp |= val;
+	}
 
 	writel(tmp, s3c_rtc_base + S3C2410_TICNT);
 	spin_unlock_irq(&s3c_rtc_pie_lock);
@@ -371,7 +385,9 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
 		tmp &= ~S3C2410_RTCCON_RTCEN;
 		writew(tmp, base + S3C2410_RTCCON);
 
-		if (s3c_rtc_cpu_type == TYPE_S3C2410) {
+		if (s3c_rtc_cpu_type == TYPE_S3C2410 ||
+		    s3c_rtc_cpu_type == TYPE_S3C2443 ||
+		    s3c_rtc_cpu_type == TYPE_S3C2416) {
 			tmp = readb(base + S3C2410_TICNT);
 			tmp &= ~S3C2410_TICNT_ENABLE;
 			writeb(tmp, base + S3C2410_TICNT);
@@ -441,6 +457,7 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 #endif
 	int ret;
+	int tmp;
 
 	pr_debug("%s: probe=%p\n", __func__, pdev);
 
@@ -543,11 +560,18 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "warning: invalid RTC value so initializing it\n");
 	}
 
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
+	if (s3c_rtc_cpu_type != TYPE_S3C2410)
 		rtc->max_user_freq = 32768;
 	else
 		rtc->max_user_freq = 128;
 
+	if (s3c_rtc_cpu_type == TYPE_S3C2443 ||
+	     s3c_rtc_cpu_type == TYPE_S3C2416) {
+		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
+		tmp |= S3C2443_RTCCON_TICSEL;
+		writew(tmp, s3c_rtc_base + S3C2410_RTCCON);
+	}
+
 	platform_set_drvdata(pdev, rtc);
 
 	s3c_rtc_setfreq(&pdev->dev, 1);
@@ -652,6 +676,12 @@ static const struct of_device_id s3c_rtc_dt_match[] = {
 		.compatible = "samsung,s3c2410-rtc"
 		.data = TYPE_S3C2410,
 	}, {
+		.compatible = "samsung,s3c2443-rtc"
+		.data = TYPE_S3C2443,
+	}, {
+		.compatible = "samsung,s3c2416-rtc"
+		.data = TYPE_S3C2416,
+	}, {
 		.compatible = "samsung,s3c6410-rtc"
 		.data = TYPE_S3C64XX,
 	},
@@ -667,6 +697,12 @@ static struct platform_device_id s3c_rtc_driver_ids[] = {
 		.name		= "s3c2410-rtc",
 		.driver_data	= TYPE_S3C2410,
 	}, {
+		.name		= "s3c2443-rtc",
+		.driver_data	= TYPE_S3C2443,
+	}, {
+		.name		= "s3c2416-rtc",
+		.driver_data	= TYPE_S3C2416,
+	}, {
 		.name		= "s3c64xx-rtc",
 		.driver_data	= TYPE_S3C64XX,
 	},
-- 
1.7.5.4
