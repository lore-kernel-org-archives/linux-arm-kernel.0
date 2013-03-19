From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 19:07:30 +0100
Subject: [PATCH 2/4] leds: leds-ns2: fix devm_gpio_request_one() flags
 parameter
In-Reply-To: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1363716452-18870-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression introduced by commit 31c3dc7488
("leds: leds-ns2: use gpio_request_one").

gpio_request_one is called with a wrong flag value: The initial GPIO
state is used to configure the direction (bit 0) instead of the value
(bit 1). As a result, if the initial GPIO state is non null then the
GPIO will be configured as input.

This patch fixes the issue by using the dedicated macros
GPIOF_OUT_INIT_{LOW,HIGH} to configure the initial GPIO value.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/leds/leds-ns2.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 81af8e9..70137b1 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -193,7 +193,8 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	enum ns2_led_modes mode;
 
 	ret = devm_gpio_request_one(&pdev->dev, template->cmd,
-			GPIOF_DIR_OUT | gpio_get_value(template->cmd),
+			gpio_get_value(template->cmd) ?
+			GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
 			template->name);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: failed to setup command GPIO\n",
@@ -202,7 +203,8 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	}
 
 	ret = devm_gpio_request_one(&pdev->dev, template->slow,
-			GPIOF_DIR_OUT | gpio_get_value(template->slow),
+			gpio_get_value(template->slow) ?
+			GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
 			template->name);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: failed to setup slow GPIO\n",
-- 
1.7.10.4
