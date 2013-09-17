From: john.stultz@linaro.org (John Stultz)
Date: Tue, 17 Sep 2013 11:29:10 -0700
Subject: [RFC][PATCH] rtc: rtc-pl031: Set wakeup flag prior to registering
 rtcdev
Message-ID: <1379442550-24860-1-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some recent testing, I noticed the CLOCK_REALTIME_ALARM clockid
wasn't functioning on my vexpress qemu environment. Looking into it
I noticed the pl031 rtc driver doesn't set the wakeup flag on the
device until after registering the device with the RTC subsystem.

This causes the alarmtimer subsystem to not see the pl031 driver
as a valid backing device, and that resuls in alarm clockids
getting ENOTSUPP errors.

Thus be sure to set the wakeup flag on the device prior to
registering the rtcdev so the pl031 rtc driver can be used as
the backing alarmtimer device.

Let me know if you have any feedback or objections to this.
If it looks ok, I'll queue it for 3.13. I suspect there 
may be other RTC drivers with the same problem.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 0f0609b..e3b2571 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -371,6 +371,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
+	device_init_wakeup(&adev->dev, 1);
 	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
 					THIS_MODULE);
 	if (IS_ERR(ldata->rtc)) {
@@ -384,8 +385,6 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_irq;
 	}
 
-	device_init_wakeup(&adev->dev, 1);
-
 	return 0;
 
 out_no_irq:
-- 
1.8.1.2
