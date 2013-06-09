From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  9 Jun 2013 21:51:25 +0400
Subject: [PATCH v3 2/2] leds: leds-mc13783: Add MC13892 LED support
In-Reply-To: <1370800285-18432-1-git-send-email-shc_work@mail.ru>
References: <1370800285-18432-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370800285-18432-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/leds/leds-mc13783.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/mc13xxx.h |  7 ++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index 5d0b23c..33e9322 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -1,5 +1,5 @@
 /*
- * LEDs driver for Freescale MC13783
+ * LEDs driver for Freescale MC13783/MC13892
  *
  * Copyright (C) 2010 Philippe R?tornaz
  *
@@ -85,6 +85,34 @@ static void mc13xxx_led_work(struct work_struct *work)
 		value = led->new_brightness >> 3;
 		mask = 0x1f;
 		break;
+	case MC13892_LED_MD:
+		reg = MC13XXX_REG_LED_CONTROL(0);
+		shift = 3;
+		mask = 0x3f;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_AD:
+		reg = MC13XXX_REG_LED_CONTROL(0);
+		shift = 15;
+		mask = 0x3f;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_KP:
+		reg = MC13XXX_REG_LED_CONTROL(1);
+		shift = 3;
+		mask = 0x3f;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_R:
+	case MC13892_LED_G:
+	case MC13892_LED_B:
+		off = led->id - MC13892_LED_R;
+		bank = off / 2;
+		reg = MC13XXX_REG_LED_CONTROL(2) + bank;
+		shift = (off - bank * 2) * 12 + 3;
+		value = led->new_brightness >> 2;
+		mask = 0x3f;
+		break;
 	default:
 		BUG();
 	}
@@ -138,6 +166,29 @@ static int __init mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 		shift = ((led->id - MC13783_LED_R1) - bank * 3) * 2;
 		mask = 0x03;
 		break;
+	case MC13892_LED_MD:
+		reg = MC13XXX_REG_LED_CONTROL(0);
+		shift = 9;
+		mask = 0x07;
+		break;
+	case MC13892_LED_AD:
+		reg = MC13XXX_REG_LED_CONTROL(0);
+		shift = 21;
+		mask = 0x07;
+		break;
+	case MC13892_LED_KP:
+		reg = MC13XXX_REG_LED_CONTROL(1);
+		shift = 9;
+		mask = 0x07;
+		break;
+	case MC13892_LED_R:
+	case MC13892_LED_G:
+	case MC13892_LED_B:
+		bank = (led->id - MC13892_LED_R) / 2;
+		reg = MC13XXX_REG_LED_CONTROL(2) + bank;
+		shift = ((led->id - MC13892_LED_R) - bank * 2) * 12 + 9;
+		mask = 0x07;
+		break;
 	default:
 		BUG();
 	}
@@ -273,8 +324,15 @@ static const struct mc13xxx_led_devtype mc13783_led_devtype = {
 	.num_regs	= 6,
 };
 
+static const struct mc13xxx_led_devtype mc13892_led_devtype = {
+	.led_min	= MC13892_LED_MD,
+	.led_max	= MC13892_LED_B,
+	.num_regs	= 4,
+};
+
 static const struct platform_device_id mc13xxx_led_id_table[] = {
 	{ "mc13783-led", (kernel_ulong_t)&mc13783_led_devtype, },
+	{ "mc13892-led", (kernel_ulong_t)&mc13892_led_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, mc13xxx_led_id_table);
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 016c684..2fd59d1 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -92,6 +92,13 @@ enum {
 	MC13783_LED_R3,
 	MC13783_LED_G3,
 	MC13783_LED_B3,
+	/* MC13892 LED IDs */
+	MC13892_LED_MD,
+	MC13892_LED_AD,
+	MC13892_LED_KP,
+	MC13892_LED_R,
+	MC13892_LED_G,
+	MC13892_LED_B,
 };
 
 struct mc13xxx_led_platform_data {
-- 
1.8.1.5
