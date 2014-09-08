From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 17:26:26 +0200
Subject: [PATCHv2] rtc: pcf8563: fix uninitialized use warning
Message-ID: <2750370.rlMuFcoBUA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-4.9 found a potential condition under which the 'pending'
variable may be used uninitialized:

drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_irq':
drivers/rtc/rtc-pcf8563.c:173:5: warning: 'pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

This is because in the pcf8563_get_alarm_mode() function, we
check any nonzero return of pcf8563_read_block_data, but
in the irq function we only check for negative values, so
a possible positive value does not get detected if the compiler
chooses not to inline the entire call chain.

Checking for any non-zero value in the interrupt handler as well
is just as correct and lets the compiler know what we are doing,
without needing a bogus initialization.

As pointed out by Sergei Shtylyov, the same code section contains
another bug: an interrupt handler is not supposed to return
an errno value. Let's fix this as well by returning IRQ_NONE
in case of a communication error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 5a197d9dc7e7..c2ef0a22ee94 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -167,8 +167,8 @@ static irqreturn_t pcf8563_irq(int irq, void *dev_id)
 	char pending;
 
 	err = pcf8563_get_alarm_mode(pcf8563->client, NULL, &pending);
-	if (err < 0)
-		return err;
+	if (err)
+		return IRQ_NONE;
 
 	if (pending) {
 		rtc_update_irq(pcf8563->rtc, 1, RTC_IRQF | RTC_AF);
