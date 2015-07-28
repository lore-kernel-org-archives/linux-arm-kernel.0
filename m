From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:39 +0200
Subject: [PATCH v2 08/22] gpio: Probe pinctrl devices on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a pin controller through its firmware node, probe it if
it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 31a6b18a6542..2a6379c1fea7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -358,6 +358,8 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (ret)
 			break;
 
+		fwnode_ensure_device(&pinspec.np->fwnode);
+
 		pctldev = of_pinctrl_get(pinspec.np);
 		if (!pctldev)
 			return -EPROBE_DEFER;
-- 
2.4.3
