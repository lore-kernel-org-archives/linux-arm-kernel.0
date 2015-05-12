From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 23:27:02 +0200
Subject: [PATCH] rtc: pfc8563: fix uninitialized variable warning
Message-ID: <2293546.ekQV1ek12O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gcc is unable to prove that alm_pending is always initialized
when it is used, so it prints a harmless warning:

drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_probe':
drivers/rtc/rtc-pcf8563.c:449:5: warning: 'alm_pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

This uses the same conditional expression that is used inside of
the pcf8563_get_alarm_mode() function, to help gcc figure it out
and shut up that warning, and make the ARM defconfigs build again
with no warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a45d528aab8b ("rtc: pcf8563: clear expired alarm at boot time")

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0ba7e59929be..8e52c029cf1a 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -437,7 +437,7 @@ static int pcf8563_probe(struct i2c_client *client,
 	}
 
 	err = pcf8563_get_alarm_mode(client, NULL, &alm_pending);
-	if (err < 0) {
+	if (err) {
 		dev_err(&client->dev, "%s: read error\n", __func__);
 		return err;
 	}
