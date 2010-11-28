From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:31:55 +0200
Subject: [PATCH 10/10] RTC S3C: Fix type of s3c_rtc_setaie()
Message-ID: <1290969115-10291-1-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change s3c_rtc_setaie() declaration in accordance with rtc_class_ops
structure declaration.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 arch/arm/mach-s3c2412/Kconfig  |    7 +++++++
 arch/arm/mach-s3c2412/Makefile |    3 ++-
 arch/arm/mach-s3c2416/Kconfig  |    1 +
 drivers/rtc/rtc-s3c.c          |    8 +++++---
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index fa2e5bf..6983cb4 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -28,9 +28,16 @@ config S3C2412_DMA
 
 config S3C2412_PM
 	bool
+	select S3C2412_PM_SLEEP
 	help
 	  Internal config node to apply S3C2412 power management
 
+config S3C2412_PM_SLEEP
+	bool
+	help
+	  Internal config node to apply sleep for S3C2412 power management.
+	  Can be selected by another SoCs with similar sleep procedure.
+
 # Note, the S3C2412 IOtiming support is in plat-s3c24xx
 
 config S3C2412_CPUFREQ
diff --git a/arch/arm/mach-s3c2412/Makefile b/arch/arm/mach-s3c2412/Makefile
index 530ec46..6c48a91 100644
--- a/arch/arm/mach-s3c2412/Makefile
+++ b/arch/arm/mach-s3c2412/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_CPU_S3C2412)	+= irq.o
 obj-$(CONFIG_CPU_S3C2412)	+= clock.o
 obj-$(CONFIG_CPU_S3C2412)	+= gpio.o
 obj-$(CONFIG_S3C2412_DMA)	+= dma.o
-obj-$(CONFIG_S3C2412_PM)	+= pm.o sleep.o
+obj-$(CONFIG_S3C2412_PM)	+= pm.o
+obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep.o
 obj-$(CONFIG_S3C2412_CPUFREQ)	+= cpu-freq.o
 
 # Machine support
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 2eaadcf..69b48a7 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -27,6 +27,7 @@ config S3C2416_DMA
 
 config S3C2416_PM
 	bool
+	select S3C2412_PM_SLEEP
 	help
 	  Internal config node to apply S3C2416 power management
 
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index cf953ec..4101522 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -77,7 +77,7 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
 }
 
 /* Update control registers */
-static void s3c_rtc_setaie(int to)
+static int s3c_rtc_setaie(struct device *dev, unsigned int to)
 {
 	unsigned int tmp;
 
@@ -89,6 +89,8 @@ static void s3c_rtc_setaie(int to)
 		tmp |= S3C2410_RTCALM_ALMEN;
 
 	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
+
+	return 0;
 }
 
 static int s3c_rtc_setpie(struct device *dev, int enabled)
@@ -308,7 +310,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	writeb(alrm_en, base + S3C2410_RTCALM);
 
-	s3c_rtc_setaie(alrm->enabled);
+	s3c_rtc_setaie(dev, alrm->enabled);
 
 	return 0;
 }
@@ -440,7 +442,7 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 	rtc_device_unregister(rtc);
 
 	s3c_rtc_setpie(&dev->dev, 0);
-	s3c_rtc_setaie(0);
+	s3c_rtc_setaie(&dev->dev, 0);
 
 	clk_disable(rtc_clk);
 	clk_put(rtc_clk);
-- 
1.7.2.3
