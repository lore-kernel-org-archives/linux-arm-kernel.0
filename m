From: gbean@codeaurora.org (Gregory Bean)
Date: Wed,  1 Sep 2010 16:39:40 -0700
Subject: [PATCH 2/2 v2] msm: gpio: Add gpiomux calls to request and free.
In-Reply-To: <1283384380-24997-1-git-send-email-gbean@codeaurora.org>
References: <1283384380-24997-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1283384380-24997-2-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpiomux get and put calls to msmgpio request and free,
in order to allow gpio lines to be properly reference-counted
and power-managed.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/gpio.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index 89c857b..3c2443f 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include "gpio_hw.h"
+#include "gpiomux.h"
 #include "proc_comm.h"
 #include "smd_private.h"
 
@@ -46,6 +47,8 @@
 			.direction_input = msm_gpio_direction_input,	\
 			.direction_output = msm_gpio_direction_output,	\
 			.to_irq = msm_gpio_to_irq,			\
+			.request = msm_gpio_request,			\
+			.free = msm_gpio_free,				\
 		}							\
 	}
 
@@ -180,6 +183,21 @@ static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return MSM_GPIO_TO_INT(chip->base + offset);
 }
 
+#ifdef CONFIG_MSM_GPIOMUX
+static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+        return msm_gpiomux_get(chip->base + offset);
+}
+
+static void msm_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+        msm_gpiomux_put(chip->base + offset);
+}
+#else
+#define msm_gpio_request NULL
+#define msm_gpio_free NULL
+#endif
+
 struct msm_gpio_chip msm_gpio_chips[] = {
 #if defined(CONFIG_ARCH_MSM7X00A)
 	MSM_GPIO_BANK(0,   0,  15),
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
