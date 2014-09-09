From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 14:37:02 +0200
Subject: [PATCH v3 2/2] rtc: pcf8563: fix pcf8563_irq error return value
In-Reply-To: <540DCEB0.6030108@cogentembedded.com>
References: <2750370.rlMuFcoBUA@wuerfel> <540DCEB0.6030108@cogentembedded.com>
Message-ID: <3249459.KnxQRYTdsz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pointed out by Sergei Shtylyov, the pcf8563_irq function
contains a bug in the error handling: an interrupt handler
is not supposed to return an errno value but an 'enum
irqreturn'.

Let's fix this by returning IRQ_NONE in case of a communication error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 3a6f994c4da8..c2ef0a22ee94 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -168,7 +168,7 @@ static irqreturn_t pcf8563_irq(int irq, void *dev_id)
 
 	err = pcf8563_get_alarm_mode(pcf8563->client, NULL, &pending);
 	if (err)
-		return err;
+		return IRQ_NONE;
 
 	if (pending) {
 		rtc_update_irq(pcf8563->rtc, 1, RTC_IRQF | RTC_AF);
