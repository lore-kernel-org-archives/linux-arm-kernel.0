From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:38 +0200
Subject: [PATCH v2 07/22] gpio: Probe GPIO drivers on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a gpiochip through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fa6e3c8823d6..31a6b18a6542 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -95,6 +95,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
+	fwnode_ensure_device(&gg_data.gpiospec.np->fwnode);
+
 	gpiochip_find(&gg_data, of_gpiochip_find_and_xlate);
 
 	of_node_put(gg_data.gpiospec.np);
-- 
2.4.3
