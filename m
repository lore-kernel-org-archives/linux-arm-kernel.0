From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:53 +0000
Subject: [PATCH 04/12] regulator: gpio-regulator: gpio_set_value should use
 cansleep
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If it's possible for gpio_set_value to sleep, we should be using
the *_cansleep call instead. This patch fixes multiple warnings
from gpiolib.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/gpio-regulator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 5462c28..90f5221 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -82,7 +82,7 @@ static int gpio_regulator_set_voltage(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value(data->gpios[ptr].gpio, state);
+		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
 	}
 	data->state = target;
 
@@ -119,7 +119,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value(data->gpios[ptr].gpio, state);
+		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
 	}
 	data->state = target;
 
-- 
1.7.9.5
