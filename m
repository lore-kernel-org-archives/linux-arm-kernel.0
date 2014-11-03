From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 19:12:07 +0100
Subject: [PATCH v3 4/4] regulator: tps65090: Fix gpio initialization
In-Reply-To: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
References: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1415038327-32616-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config is used for multiple regulators within a for loop. The config
field is not cleared before it is used for the next item. To avoid any
issues this patch adds a proper initialization for the config->ena_gpio
field in case no gpio is available.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/tps65090-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 2e92aa8718cc..f1df4423d361 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -314,6 +314,9 @@ static void tps65090_configure_regulator_config(
 		config->ena_gpio = tps_pdata->gpio;
 		config->ena_gpio_initialized = true;
 		config->ena_gpio_flags = gpio_flag;
+	} else {
+		config->ena_gpio = -EINVAL;
+		config->ena_gpio_initialized = false;
 	}
 }
 
-- 
2.1.1
