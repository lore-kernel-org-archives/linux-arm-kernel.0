From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jul 2015 11:32:44 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
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
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d120c3..9f402b159cbe 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -798,7 +798,8 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
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
