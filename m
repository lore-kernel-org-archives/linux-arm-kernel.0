From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 28 Oct 2016 15:54:10 +0800
Subject: [PATCH] pinctrl: at91: add support for OUTPUT config
Message-ID: <1477641251-30468-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <b.brezillon@overkiz.com>

Add support for pin output control through the pinctrl config:
 - support enabling/disabling output on a given pin
 - support output level setting (high or low)

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 .../bindings/pinctrl/atmel,at91-pinctrl.txt         |  2 ++
 drivers/pinctrl/pinctrl-at91.c                      | 21 +++++++++++++++++++++
 include/dt-bindings/pinctrl/at91.h                  |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index b7a93e8..9a8a45d 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -98,6 +98,8 @@ DRIVE_STRENGTH (3 << 5): indicate the drive strength of the pin using the
 				01 - Low
 				10 - Medium
 				11 - High
+OUTPUT		(1 << 7): indicate this pin need to be configured as an output.
+OUTPUT_VAL	(1 << 8): output val (1 = high, 0 = low)
 DEBOUNCE	(1 << 16): indicate this pin needs debounce.
 DEBOUNCE_VAL	(0x3fff << 17): debounce value.
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 9f09041..569bc28 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -56,6 +56,9 @@ static int gpio_banks;
 #define DRIVE_STRENGTH_SHIFT	5
 #define DRIVE_STRENGTH_MASK		0x3
 #define DRIVE_STRENGTH   (DRIVE_STRENGTH_MASK << DRIVE_STRENGTH_SHIFT)
+#define OUTPUT		(1 << 7)
+#define OUTPUT_VAL_SHIFT	8
+#define OUTPUT_VAL	(0x1 << OUTPUT_VAL_SHIFT)
 #define DEBOUNCE	(1 << 16)
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
@@ -375,6 +378,19 @@ static void at91_mux_set_pullup(void __iomem *pio, unsigned mask, bool on)
 	writel_relaxed(mask, pio + (on ? PIO_PUER : PIO_PUDR));
 }
 
+static bool at91_mux_get_output(void __iomem *pio, unsigned int pin, bool *val)
+{
+	*val = (readl_relaxed(pio + PIO_ODSR) >> pin) & 0x1;
+	return (readl_relaxed(pio + PIO_OSR) >> pin) & 0x1;
+}
+
+static void at91_mux_set_output(void __iomem *pio, unsigned int mask,
+				bool is_on, bool val)
+{
+	writel_relaxed(mask, pio + (val ? PIO_SODR : PIO_CODR));
+	writel_relaxed(mask, pio + (is_on ? PIO_OER : PIO_ODR));
+}
+
 static unsigned at91_mux_get_multidrive(void __iomem *pio, unsigned pin)
 {
 	return (readl_relaxed(pio + PIO_MDSR) >> pin) & 0x1;
@@ -848,6 +864,7 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	void __iomem *pio;
 	unsigned pin;
 	int div;
+	bool out;
 
 	*config = 0;
 	dev_dbg(info->dev, "%s:%d, pin_id=%d", __func__, __LINE__, pin_id);
@@ -875,6 +892,8 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	if (info->ops->get_drivestrength)
 		*config |= (info->ops->get_drivestrength(pio, pin)
 				<< DRIVE_STRENGTH_SHIFT);
+	if (at91_mux_get_output(pio, pin, &out))
+		*config |= OUTPUT | (out << OUTPUT_VAL_SHIFT);
 
 	return 0;
 }
@@ -907,6 +926,8 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 		if (config & PULL_UP && config & PULL_DOWN)
 			return -EINVAL;
 
+		at91_mux_set_output(pio, mask, config & OUTPUT,
+				    (config & OUTPUT_VAL) >> OUTPUT_VAL_SHIFT);
 		at91_mux_set_pullup(pio, mask, config & PULL_UP);
 		at91_mux_set_multidrive(pio, mask, config & MULTI_DRIVE);
 		if (info->ops->set_deglitch)
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index bbca3d0..2732d6c 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -15,6 +15,8 @@
 #define AT91_PINCTRL_DEGLITCH		(1 << 2)
 #define AT91_PINCTRL_PULL_DOWN		(1 << 3)
 #define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
+#define AT91_PINCTRL_OUTPUT		(1 << 7)
+#define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
 #define AT91_PINCTRL_DEBOUNCE		(1 << 16)
 #define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
 
-- 
2.7.4
