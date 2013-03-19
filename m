From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 19:07:32 +0100
Subject: [PATCH 4/4] leds: renesas: fix devm_gpio_request_one() flags parameter
In-Reply-To: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1363716452-18870-5-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression introduced by commit b0053aaa23
("leds: renesas: use gpio_request_one").

gpio_request_one is called with a wrong flag value: The brightness is
used to configure the direction (bit 0) instead of the value (bit 1).

This patch fixes the issue by using the dedicated macros
GPIOF_OUT_INIT_{LOW,HIGH} to configure the initial GPIO value.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-renesas-tpu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-renesas-tpu.c b/drivers/leds/leds-renesas-tpu.c
index d3c2b7e..79cca23 100644
--- a/drivers/leds/leds-renesas-tpu.c
+++ b/drivers/leds/leds-renesas-tpu.c
@@ -205,7 +205,8 @@ static void r_tpu_set_pin(struct r_tpu_priv *p, enum r_tpu_pin new_state,
 		gpio_free(cfg->pin_gpio_fn);
 
 	if (new_state == R_TPU_PIN_GPIO)
-		gpio_request_one(cfg->pin_gpio, GPIOF_DIR_OUT | !!brightness,
+		gpio_request_one(cfg->pin_gpio, brightness ?
+				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
 				cfg->name);
 
 	if (new_state == R_TPU_PIN_GPIO_FN)
-- 
1.7.10.4
