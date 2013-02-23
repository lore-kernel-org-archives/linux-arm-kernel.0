From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 23 Feb 2013 18:56:34 +0100
Subject: [PATCH] pinctrl: return real error codes when pinctrl is not included
In-Reply-To: <201302231855.47560.heiko@sntech.de>
References: <201302231855.47560.heiko@sntech.de>
Message-ID: <201302231856.35083.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the fallback functions when pinctrl is not being built do
return either NULL or 0, either no pinctrl handle or no error,
making them fail silently.

All drivers using pinctrl do only test for error conditions, which
made for example the i2c-s3c2410 driver fail on a devicetree based
machine without pinctrl, as the conditional
	if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
did not reach the second part to initialize the gpios from dt.

Therefore let the fallback pinctrl functions return -ENOTSUPP
or the equivalent ERR_PTR to indicate that pinctrl is not supported.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pinctrl/consumer.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4aad3ce..69d145f 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -44,7 +44,7 @@ extern void devm_pinctrl_put(struct pinctrl *p);
 
 static inline int pinctrl_request_gpio(unsigned gpio)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 
 static inline void pinctrl_free_gpio(unsigned gpio)
@@ -53,17 +53,17 @@ static inline void pinctrl_free_gpio(unsigned gpio)
 
 static inline int pinctrl_gpio_direction_input(unsigned gpio)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 
 static inline int pinctrl_gpio_direction_output(unsigned gpio)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 
 static inline struct pinctrl * __must_check pinctrl_get(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline void pinctrl_put(struct pinctrl *p)
@@ -74,18 +74,18 @@ static inline struct pinctrl_state * __must_check pinctrl_lookup_state(
 							struct pinctrl *p,
 							const char *name)
 {
-	return NULL;
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline int pinctrl_select_state(struct pinctrl *p,
 				       struct pinctrl_state *s)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 
 static inline struct pinctrl * __must_check devm_pinctrl_get(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline void devm_pinctrl_put(struct pinctrl *p)
-- 
1.7.2.3
