From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 18 May 2010 17:10:40 +0800
Subject: [PATCH] NUC900/rtc: change the waiting for device ready implement
Message-ID: <4BF25990.6070602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alessandro,

This patch is to change the waiting for device ready implement
for winbond nuc900 platform.

Thanks!

Signed-off-by:Wan ZongShun<mcuos.com@gmail.com>

---
 drivers/rtc/rtc-nuc900.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index a351bd5..8684051 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -85,22 +85,21 @@ static irqreturn_t nuc900_rtc_interrupt(int irq, void *_rtc)

 static int *check_rtc_access_enable(struct nuc900_rtc *nuc900_rtc)
 {
-	unsigned int i;
+	unsigned int i, timeout = 0x1000, val;
 	__raw_writel(INIRRESET, nuc900_rtc->rtc_reg + REG_RTC_INIR);

 	mdelay(10);

 	__raw_writel(AERPOWERON, nuc900_rtc->rtc_reg + REG_RTC_AER);

-	for (i = 0; i < 1000; i++) {
-		if (__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB)
-			return 0;
-	}
+	while (!(__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB)
+								&& timeout--)
+		mdelay(1);

-	if ((__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB) == 0x0)
-		return ERR_PTR(-ENODEV);
+	if (timeout == 0x1000)
+		return ERR_PTR(-EPERM);

-	return ERR_PTR(-EPERM);
+	return 0;
 }

 static void nuc900_rtc_bcd2bin(unsigned int timereg,
-- 
1.6.3.3
