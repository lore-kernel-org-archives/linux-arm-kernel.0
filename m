From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 16 Mar 2012 19:35:50 +0530
Subject: [PATCH v4 02/12] gpio/omap: fix wakeup_en register update in
 _set_gpio_wakeup()
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331906760-5259-3-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two ways through which wakeup_en register can be programmed
using gpiolib APIs as shown below. It is seen that in the second case
in _set_gpio_wakeup(), even though bank->suspend_wakeup is updated
correctly, its value is not programmed in wakeup_en register. Fix this.

chip.irq_set_type()->gpio_irq_type()->_set_gpio_triggering()->set_gpio_trigger()
chip.irq_set_wake()->gpio_wake_enable()->_set_gpio_wakeup()

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0c1c529..171f951 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -509,6 +509,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	else
 		bank->suspend_wakeup &= ~gpio_bit;
 
+	__raw_writel(bank->suspend_wakeup, bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4
