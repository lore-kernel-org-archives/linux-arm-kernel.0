From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  8 Oct 2010 08:41:14 +0900
Subject: [PATCH 1/6] rtc: rtc-s3c: Fix access unit from byte to word on RTCCON
In-Reply-To: <1286494879-2932-1-git-send-email-kgene.kim@samsung.com>
References: <1286494879-2932-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1286494879-2932-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

S3C2410_RTCCON of TYPE_S3C64XX RTC should be read/written by
readw and writew, because TYPE_S3C64XX RTC uses bit 8 and 9.
And TYPE_S3C2410 RTC also can access it by readw and writew.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
[atul.dahiya at samsung.com: tested on smdk2416]
Tested-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/rtc/rtc-s3c.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index f57a87f..4a0b875 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -100,7 +100,7 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
 	spin_lock_irq(&s3c_rtc_pie_lock);
 
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
+		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
 		tmp &= ~S3C64XX_RTCCON_TICEN;
 
 		if (enabled)
@@ -318,7 +318,7 @@ static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 	unsigned int ticnt;
 
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt = readb(s3c_rtc_base + S3C2410_RTCCON);
+		ticnt = readw(s3c_rtc_base + S3C2410_RTCCON);
 		ticnt &= S3C64XX_RTCCON_TICEN;
 	} else {
 		ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
@@ -391,11 +391,11 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
 		return;
 
 	if (!en) {
-		tmp = readb(base + S3C2410_RTCCON);
+		tmp = readw(base + S3C2410_RTCCON);
 		if (s3c_rtc_cpu_type == TYPE_S3C64XX)
 			tmp &= ~S3C64XX_RTCCON_TICEN;
 		tmp &= ~S3C2410_RTCCON_RTCEN;
-		writeb(tmp, base + S3C2410_RTCCON);
+		writew(tmp, base + S3C2410_RTCCON);
 
 		if (s3c_rtc_cpu_type == TYPE_S3C2410) {
 			tmp = readb(base + S3C2410_TICNT);
@@ -405,25 +405,25 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
 	} else {
 		/* re-enable the device, and check it is ok */
 
-		if ((readb(base+S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
+		if ((readw(base+S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
 			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
 
-			tmp = readb(base + S3C2410_RTCCON);
-			writeb(tmp|S3C2410_RTCCON_RTCEN, base+S3C2410_RTCCON);
+			tmp = readw(base + S3C2410_RTCCON);
+			writew(tmp|S3C2410_RTCCON_RTCEN, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
+		if ((readw(base + S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
 			dev_info(&pdev->dev, "removing RTCCON_CNTSEL\n");
 
-			tmp = readb(base + S3C2410_RTCCON);
-			writeb(tmp& ~S3C2410_RTCCON_CNTSEL, base+S3C2410_RTCCON);
+			tmp = readw(base + S3C2410_RTCCON);
+			writew(tmp& ~S3C2410_RTCCON_CNTSEL, base+S3C2410_RTCCON);
 		}
 
-		if ((readb(base + S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
+		if ((readw(base + S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
 			dev_info(&pdev->dev, "removing RTCCON_CLKRST\n");
 
-			tmp = readb(base + S3C2410_RTCCON);
-			writeb(tmp & ~S3C2410_RTCCON_CLKRST, base+S3C2410_RTCCON);
+			tmp = readw(base + S3C2410_RTCCON);
+			writew(tmp & ~S3C2410_RTCCON_CLKRST, base+S3C2410_RTCCON);
 		}
 	}
 }
@@ -514,8 +514,8 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	s3c_rtc_enable(pdev, 1);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
-		 readb(s3c_rtc_base + S3C2410_RTCCON));
+	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
+		 readw(s3c_rtc_base + S3C2410_RTCCON));
 
 	device_init_wakeup(&pdev->dev, 1);
 
@@ -578,7 +578,7 @@ static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 	/* save TICNT for anyone using periodic interrupts */
 	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt_en_save = readb(s3c_rtc_base + S3C2410_RTCCON);
+		ticnt_en_save = readw(s3c_rtc_base + S3C2410_RTCCON);
 		ticnt_en_save &= S3C64XX_RTCCON_TICEN;
 	}
 	s3c_rtc_enable(pdev, 0);
@@ -596,8 +596,8 @@ static int s3c_rtc_resume(struct platform_device *pdev)
 	s3c_rtc_enable(pdev, 1);
 	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX && ticnt_en_save) {
-		tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
-		writeb(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
+		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
+		writew(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
 	}
 
 	if (device_may_wakeup(&pdev->dev))
-- 
1.6.2.5
