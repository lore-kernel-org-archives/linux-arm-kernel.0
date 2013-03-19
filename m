From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 19:07:31 +0100
Subject: [PATCH 3/4] leds: leds-lt3593: fix devm_gpio_request_one() flags
 parameter
In-Reply-To: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1363716452-18870-4-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression introduced by commit 507d967bc1
("leds: leds-lt3593: use gpio_request_one").

gpio_request_one is called with a wrong flag value: The GPIO default
state is used to configure the direction (bit 0) instead of the value
(bit 1). As a result, if the default GPIO state is non null then the
GPIO will be configured as input.

This patch fixes the issue by using the dedicated macros
GPIOF_OUT_INIT_{LOW,HIGH} to configure the initial GPIO value.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-lt3593.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index c9b9e1f..ca48a7d 100644
--- a/drivers/leds/leds-lt3593.c
+++ b/drivers/leds/leds-lt3593.c
@@ -106,8 +106,9 @@ static int create_lt3593_led(const struct gpio_led *template,
 	if (!template->retain_state_suspended)
 		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
 
-	ret = devm_gpio_request_one(parent, template->gpio,
-				    GPIOF_DIR_OUT | state, template->name);
+	ret = devm_gpio_request_one(parent, template->gpio, state ?
+				    GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+				    template->name);
 	if (ret < 0)
 		return ret;
 
-- 
1.7.10.4
