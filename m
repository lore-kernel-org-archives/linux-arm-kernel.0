From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 15 Feb 2014 21:15:22 +0100
Subject: [PATCH 1/2] rtc: rtc-ds1307: fix sysfs wakealarm attribute creation
In-Reply-To: <1392495323-22875-1-git-send-email-simon.guinot@sequanux.org>
References: <1392495323-22875-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1392495323-22875-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow the creation of the sysfs attribute wakealarm, this
patch moves the device_set_wakeup_capable() call above the RTC device
registration.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4e75345a559a..8c70b2238e88 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -927,6 +927,7 @@ read_rtc:
 				bin2bcd(tmp));
 	}
 
+	device_set_wakeup_capable(&client->dev, want_irq);
 	ds1307->rtc = devm_rtc_device_register(&client->dev, client->name,
 				&ds13xx_rtc_ops, THIS_MODULE);
 	if (IS_ERR(ds1307->rtc)) {
@@ -945,7 +946,6 @@ read_rtc:
 			goto exit;
 		}
 
-		device_set_wakeup_capable(&client->dev, 1);
 		set_bit(HAS_ALARM, &ds1307->flags);
 		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
 	}
-- 
1.8.5.3
