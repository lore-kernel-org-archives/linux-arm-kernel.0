From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue,  4 Aug 2015 11:27:04 +0200
Subject: [PATCH v2] gpio: Allow hogged gpios to be requested
Message-ID: <1438680424-698-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be useful to claim hogged gpios later, for example from
userspace. This allows to set defaults for GPIOs using the hogging
mechanism and override the setup later from userspace or a kernel driver.

This patch adds a check for hogged gpios to allow requesting them. If
the gpio is not hogged but marked as requested, it still fails with
-EBUSY.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Only change is, that it is separated from the other series now.

 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 926a1507431f..0f1d1f5faf5d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -830,7 +830,8 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
 
-	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
+	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0 ||
+	    test_and_clear_bit(FLAG_IS_HOGGED, &desc->flags) == 1) {
 		desc_set_label(desc, label ? : "?");
 		status = 0;
 	} else {
-- 
2.1.4
