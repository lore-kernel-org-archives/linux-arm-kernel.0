From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:58 -0600
Subject: [PATCH 05/11] gpio: tegra: configure pins during irq_set_type
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

When a Tegra GPIO is used as an IRQ, it should be enabled as a GPIO (so
the pinmux module isn't driving it as an output) and configured as a GPIO
input (so the GPIO module isn't driving it as an output). Set this up
automatically whenever an IRQ is requested, so that users of IRQs don't
need to do this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 12f349b..4383a72 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -224,6 +224,9 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	spin_unlock_irqrestore(&bank->lvl_lock[port], flags);
 
+	tegra_gpio_mask_write(GPIO_MSK_OE(gpio), gpio, 0);
+	tegra_gpio_enable(gpio);
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
-- 
1.7.0.4
