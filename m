From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 23 Mar 2011 22:00:02 +0100
Subject: [PATCH] leds: leds-regulator.c,
	fix handling already enabled regulators
Message-ID: <1300914002-17760-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the driver aware of the initial status of the regulator.

The leds-regulator driver was ignoring the initial status of the
regulator; this resulted in rdev->use_count incremented up to 2 after
calling regulator_led_set_value() in the .probe method when a regulator
was already enabled at insmod time, and this made impossible to ever
disable the regulator.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

This problem was anticipated by Mark Brown on the very first submission 
of the driver but my knowledge about regulators at the time made me 
overlook what he was asking for, now that I have actually experienced 
the problem I've finally figured out what Mark was really referring to.

NOTE: initially I thought about CC-ing stable at kernel.org as well on 
this, as it is an actual fix, but then I checked that there are 
currently no users of the driver in mainline linux and I dropped it, is 
that how it should be?

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/leds/leds-regulator.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/leds/leds-regulator.c b/drivers/leds/leds-regulator.c
index 3790816..8497f56 100644
--- a/drivers/leds/leds-regulator.c
+++ b/drivers/leds/leds-regulator.c
@@ -178,6 +178,10 @@ static int __devinit regulator_led_probe(struct platform_device *pdev)
 	led->cdev.flags |= LED_CORE_SUSPENDRESUME;
 	led->vcc = vcc;
 
+	/* to handle correctly an already enabled regulator */
+	if (regulator_is_enabled(led->vcc))
+		led->enabled = 1;
+
 	mutex_init(&led->mutex);
 	INIT_WORK(&led->work, led_work);
 
-- 
1.7.4.1
