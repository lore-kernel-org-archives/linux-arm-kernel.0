From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  2 Dec 2010 16:39:42 -0800
Subject: [PATCH 1/4] msm: trout: add gpio_to_irq
Message-ID: <1291336785-29108-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trout has gpiolib support and interrupt support, but was
missing the gpio_to_irq function. This adds that functions
which should allow proper translation.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/board-trout-gpio.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index c50f3af..f8c09ef 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -72,6 +72,13 @@ static int msm_gpiolib_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int trout_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct msm_gpio_chip *msm_gpio = to_msm_gpio_chip(chip);
+
+	return TROUT_GPIO_TO_INT(offset + chip->base);
+}
+
 #define TROUT_GPIO_BANK(name, reg_num, base_gpio, shadow_val)		\
 	{								\
 		.chip = {						\
@@ -80,6 +87,7 @@ static int msm_gpiolib_direction_output(struct gpio_chip *chip,
 			.direction_output = msm_gpiolib_direction_output, \
 			.get		  = msm_gpiolib_get,		\
 			.set		  = msm_gpiolib_set,		\
+			.to_irq		  = trout_gpio_to_irq,		\
 			.base		  = base_gpio,			\
 			.ngpio		  = 8,				\
 		},							\
-- 
1.7.1

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
