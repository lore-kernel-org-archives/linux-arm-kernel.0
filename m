From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 30 Oct 2017 15:50:00 -0500
Subject: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
References: <1509396602-1936-1-git-send-email-timur@codeaurora.org>
Message-ID: <1509396602-1936-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for specifying that some GPIOs within a range are unavailable.
Some systems have a sparse list of GPIOs, where a range of GPIOs is
specified (usually 0 to n-1), but some subset within that range is
absent or unavailable for whatever reason.

To support this, allow drivers to specify a bitmask of GPIOs that
are present or absent.  Gpiolib will then block access to those that
are absent.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/gpio/gpiolib.c      | 43 +++++++++++++++++++++++++++++++++++--------
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 60553af4c004..c32387936cdd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1481,22 +1481,36 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 
 static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gpiochip)
 {
-	if (!gpiochip->irq_need_valid_mask)
-		return 0;
+	if (gpiochip->irq_need_valid_mask) {
+		gpiochip->irq_valid_mask =
+			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
+				sizeof(long), GFP_KERNEL);
+		if (!gpiochip->irq_valid_mask)
+			return -ENOMEM;
 
-	gpiochip->irq_valid_mask = kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
-					   sizeof(long), GFP_KERNEL);
-	if (!gpiochip->irq_valid_mask)
-		return -ENOMEM;
+		/* Assume by default all GPIOs are valid */
+		bitmap_fill(gpiochip->irq_valid_mask, gpiochip->ngpio);
+	}
 
-	/* Assume by default all GPIOs are valid */
-	bitmap_fill(gpiochip->irq_valid_mask, gpiochip->ngpio);
+	if (gpiochip->line_need_valid_mask) {
+		gpiochip->line_valid_mask =
+			kcalloc(BITS_TO_LONGS(gpiochip->ngpio),
+				sizeof(long), GFP_KERNEL);
+		if (!gpiochip->line_valid_mask)
+			return -ENOMEM;
+
+		/* Assume by default all GPIOs are valid */
+		bitmap_fill(gpiochip->line_valid_mask, gpiochip->ngpio);
+	}
 
 	return 0;
 }
 
 static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gpiochip)
 {
+	kfree(gpiochip->line_valid_mask);
+	gpiochip->line_valid_mask = NULL;
+
 	kfree(gpiochip->irq_valid_mask);
 	gpiochip->irq_valid_mask = NULL;
 }
@@ -1510,6 +1524,15 @@ static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
 	return test_bit(offset, gpiochip->irq_valid_mask);
 }
 
+static bool gpiochip_irqchip_line_valid(const struct gpio_chip *gpiochip,
+					unsigned int offset)
+{
+	/* No mask means all valid */
+	if (likely(!gpiochip->line_valid_mask))
+		return true;
+	return test_bit(offset, gpiochip->line_valid_mask);
+}
+
 /**
  * gpiochip_set_cascaded_irqchip() - connects a cascaded irqchip to a gpiochip
  * @gpiochip: the gpiochip to set the irqchip chain to
@@ -3320,6 +3343,10 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 		return desc;
 	}
 
+	/* Make sure the GPIO is valid before we request it. */
+	if (!gpiochip_irqchip_line_valid(desc->gdev->chip, idx))
+		return ERR_PTR(-EACCES);
+
 	status = gpiod_request(desc, con_id);
 	if (status < 0)
 		return ERR_PTR(status);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c97f8325e8bf..83df2934bdf7 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -172,6 +172,8 @@ struct gpio_chip {
 	bool			irq_nested;
 	bool			irq_need_valid_mask;
 	unsigned long		*irq_valid_mask;
+	bool			line_need_valid_mask;
+	unsigned long		*line_valid_mask;
 	struct lock_class_key	*lock_key;
 #endif
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
