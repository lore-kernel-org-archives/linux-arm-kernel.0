From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 12 Dec 2017 14:50:56 -0600
Subject: [PATCH 1/3] [v2] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <1513111858-6251-1-git-send-email-timur@codeaurora.org>
References: <1513111858-6251-1-git-send-email-timur@codeaurora.org>
Message-ID: <1513111858-6251-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 72d3200061776264941be1b5a9bb8e926b3b30a5.

We cannot blindly query the direction of all GPIOs when the pins are
first registered.  The get_direction callback normally triggers a
read/write to hardware, but we shouldn't be touching the hardware for
an individual GPIO until after it's been properly claimed.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/gpio/gpiolib.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 641a5eb552cb..168dd831551d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1207,31 +1207,14 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 		struct gpio_desc *desc = &gdev->descs[i];
 
 		desc->gdev = gdev;
-		/*
-		 * REVISIT: most hardware initializes GPIOs as inputs
-		 * (often with pullups enabled) so power usage is
-		 * minimized. Linux code should set the gpio direction
-		 * first thing; but until it does, and in case
-		 * chip->get_direction is not set, we may expose the
-		 * wrong direction in sysfs.
-		 */
-
-		if (chip->get_direction) {
-			/*
-			 * If we have .get_direction, set up the initial
-			 * direction flag from the hardware.
-			 */
-			int dir = chip->get_direction(chip, i);
 
-			if (!dir)
-				set_bit(FLAG_IS_OUT, &desc->flags);
-		} else if (!chip->direction_input) {
-			/*
-			 * If the chip lacks the .direction_input callback
-			 * we logically assume all lines are outputs.
-			 */
-			set_bit(FLAG_IS_OUT, &desc->flags);
-		}
+		/* REVISIT: most hardware initializes GPIOs as inputs (often
+		 * with pullups enabled) so power usage is minimized. Linux
+		 * code should set the gpio direction first thing; but until
+		 * it does, and in case chip->get_direction is not set, we may
+		 * expose the wrong direction in sysfs.
+		 */
+		desc->flags = !chip->direction_input ? (1 << FLAG_IS_OUT) : 0;
 	}
 
 #ifdef CONFIG_PINCTRL
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
