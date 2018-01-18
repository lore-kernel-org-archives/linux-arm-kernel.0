From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 18 Jan 2018 17:02:08 +0100
Subject: [PATCH] pinctrl: at91-pio4: add support for drive-strength property
Message-ID: <20180118160208.16461-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the drive-strength property. Usually its value is
expressed in mA. Since the numeric value depends on VDDIOP voltage,
the controller uses low, medium and high to define the drive-strengh.

The PIO controller accepts two values for the low drive: 0 or 1. Most
of the time, we don't care about the drive strength, there is no need
to change it, so 0 is considered as the default value. The low-drive
value won't be advertised through pinconf-pins file excepted if it
has been set explicitly in the device tree ie if its value is
different from 0.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  5 ++--
 drivers/pinctrl/pinctrl-at91-pio4.c                | 33 ++++++++++++++++++++++
 include/dt-bindings/pinctrl/at91.h                 |  4 +++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 61ac75706cc9..183064bc4bda 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -34,8 +34,8 @@ right representation of the pin.
 
 Optional properties:
 - GENERIC_PINCONFIG: generic pinconfig options to use, bias-disable,
-bias-pull-down, bias-pull-up, drive-open-drain, input-schmitt-enable,
-input-debounce, output-low, output-high.
+bias-pull-down, bias-pull-up, drive-open-drain, drive-strength,
+input-schmitt-enable, input-debounce, output-low, output-high.
 
 Example:
 
@@ -66,6 +66,7 @@ Example:
 			pinmux = <PIN_PB0>,
 				 <PIN_PB5>;
 			bias-pull-up;
+			drive-strength = <ATMEL_PIO_DRVSTR_LO>;
 		};
 
 		pinctrl_sdmmc1_default: sdmmc1_default {
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 4b57a13758a4..857c0a41a905 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <dt-bindings/pinctrl/at91.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 /* FIXME: needed for gpio_to_irq(), get rid of this */
@@ -49,6 +50,8 @@
 #define		ATMEL_PIO_IFSCEN_MASK		BIT(13)
 #define		ATMEL_PIO_OPD_MASK		BIT(14)
 #define		ATMEL_PIO_SCHMITT_MASK		BIT(15)
+#define		ATMEL_PIO_DRVSTR_MASK		GENMASK(17, 16)
+#define		ATMEL_PIO_DRVSTR_OFFSET		16
 #define		ATMEL_PIO_CFGR_EVTSEL_MASK	GENMASK(26, 24)
 #define		ATMEL_PIO_CFGR_EVTSEL_FALLING	(0 << 24)
 #define		ATMEL_PIO_CFGR_EVTSEL_RISING	(1 << 24)
@@ -685,6 +688,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		arg = 1;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		if (!(res & ATMEL_PIO_DRVSTR_MASK))
+			return -EINVAL;
+		arg = (res & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET;
+		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		if (!(res & ATMEL_PIO_SCHMITT_MASK))
 			return -EINVAL;
@@ -737,6 +745,18 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
 			else
 				conf |= ATMEL_PIO_OPD_MASK;
 			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			switch (arg) {
+			case ATMEL_PIO_DRVSTR_LO:
+			case ATMEL_PIO_DRVSTR_ME:
+			case ATMEL_PIO_DRVSTR_HI:
+				conf &= (~ATMEL_PIO_DRVSTR_MASK);
+				conf |= arg << ATMEL_PIO_DRVSTR_OFFSET;
+				break;
+			default:
+				dev_warn(pctldev->dev, "drive strength not updated (incorrect value)\n");
+			}
+			break;
 		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 			if (arg == 0)
 				conf |= ATMEL_PIO_SCHMITT_MASK;
@@ -814,6 +834,19 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, "%s ", "open-drain");
 	if (conf & ATMEL_PIO_SCHMITT_MASK)
 		seq_printf(s, "%s ", "schmitt");
+	if (conf & ATMEL_PIO_DRVSTR_MASK) {
+		switch ((conf & ATMEL_PIO_DRVSTR_MASK) >> ATMEL_PIO_DRVSTR_OFFSET) {
+		case ATMEL_PIO_DRVSTR_LO:
+			seq_printf(s, "%s ", "low-drive");
+			break;
+		case ATMEL_PIO_DRVSTR_ME:
+			seq_printf(s, "%s ", "medium-drive");
+			break;
+		case ATMEL_PIO_DRVSTR_HI:
+			seq_printf(s, "%s ", "high-drive");
+			break;
+		}
+	}
 }
 
 static const struct pinconf_ops atmel_confops = {
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index 2732d6c0fb39..eb81867eac77 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -39,4 +39,8 @@
 #define AT91_PERIPH_C		3
 #define AT91_PERIPH_D		4
 
+#define ATMEL_PIO_DRVSTR_LO	1
+#define ATMEL_PIO_DRVSTR_ME	2
+#define ATMEL_PIO_DRVSTR_HI	3
+
 #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.12.2
