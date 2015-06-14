From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 14 Jun 2015 12:42:21 +0200
Subject: [PATCH] input: axp20x-pek: Fix reporting button state as inverted
Message-ID: <1434278541-21355-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are reporting the button state as inverted on all boards with
an axp209 pmic, tested on a ba10-tvbox, bananapi, bananapro, cubietruck and
utoo-p66 tablet.

The axp209 datasheet clearly states that the power button must be connected
between the PWRON key and ground. Which means that on a press we will get
a falling edge (dbf) irq not a rising one, and likewise on release we will
get a rising edge (dbr) irq, not a falling one.

This commit swaps the check for the 2 irqs fixing the inverted reporting of
the power button state.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index f1c8447..10e140a 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -167,9 +167,13 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 	struct input_dev *idev = pwr;
 	struct axp20x_pek *axp20x_pek = input_get_drvdata(idev);
 
-	if (irq == axp20x_pek->irq_dbr)
+	/*
+	 * The power-button is connected to ground so a falling edge (dbf)
+	 * means it is pressed.
+	 */
+	if (irq == axp20x_pek->irq_dbf)
 		input_report_key(idev, KEY_POWER, true);
-	else if (irq == axp20x_pek->irq_dbf)
+	else if (irq == axp20x_pek->irq_dbr)
 		input_report_key(idev, KEY_POWER, false);
 
 	input_sync(idev);
-- 
2.4.3
