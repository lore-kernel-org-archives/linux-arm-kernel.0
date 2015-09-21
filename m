From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:02:46 +0200
Subject: [PATCH v6 06/22] gpio: Probe pinctrl devices on demand
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a pin controller through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9a439dab7a87..05da9a56608d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -359,6 +359,8 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (ret)
 			break;
 
+		of_device_probe(pinspec.np);
+
 		pctldev = of_pinctrl_get(pinspec.np);
 		if (!pctldev)
 			return -EPROBE_DEFER;
-- 
2.4.3
