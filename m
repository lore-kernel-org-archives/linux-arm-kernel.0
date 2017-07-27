From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 27 Jul 2017 13:19:23 -0500
Subject: [PATCH 1/3] gliolib: request the gpio before querying its direction
In-Reply-To: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
Message-ID: <1501179565-26466-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before querying a GPIO to determine its direction, the GPIO should be
formally requested.  This allows the GPIO driver to block access to
unavailable GPIOs, which makes it easier for some drivers to support
sparse GPIO maps.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/gpio/gpiolib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9568708..3b4e1e8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1202,6 +1202,14 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 		struct gpio_desc *desc = &gdev->descs[i];
 
 		desc->gdev = gdev;
+
+		if (chip->request) {
+			status = chip->request(chip, i);
+			if (status < 0)
+				/* The GPIO is unavailable, so skip it */
+				continue;
+		}
+
 		/*
 		 * REVISIT: most hardware initializes GPIOs as inputs
 		 * (often with pullups enabled) so power usage is
@@ -1227,6 +1235,9 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 			 */
 			set_bit(FLAG_IS_OUT, &desc->flags);
 		}
+
+		if (chip->free)
+			chip->free(chip, i);
 	}
 
 #ifdef CONFIG_PINCTRL
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
