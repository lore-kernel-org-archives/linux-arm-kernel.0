From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:34 +0100
Subject: [RFC PATCH 3/7] gpio: gpiolib: save GPIO flags in
 of_get_named_gpiod_flags
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-4-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we get a GPIO descriptor from the device device, the flags
are updated for the caller to know if the GPIO is active low or
high. After calling of_get_named_gpio_flags the next step is
usually calling gpiod_request which doesn't take flags as a
parameter.
Updating the flags of the GPIO descriptor will allow to configure
the GPIO when it will be requested.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4a2b8d3397c7..67b1a7ff1e97 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -97,6 +97,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		 __func__, propname, np, index,
 		 PTR_ERR_OR_ZERO(desc));
 
+	gpiod_configure_flags(desc, propname, *flags, 0);
+
 out:
 	of_node_put(gpiospec.np);
 
-- 
2.12.2
