From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Tue, 20 Mar 2012 16:23:16 +0530
Subject: [PATCH v4 RESEND 4/7] gpio/omap: fix missing dataout context save in
 _set_gpio_dataout_reg
In-Reply-To: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1332240799-6748-5-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
which writes to dataout register and the dataout context must be saved.
It is missing in the first function, _set_gpio_dataout_reg(). Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8901d57..bbe9648 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -120,10 +120,13 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 	void __iomem *reg = bank->base;
 	u32 l = GPIO_BIT(bank, gpio);
 
-	if (enable)
+	if (enable) {
 		reg += bank->regs->set_dataout;
-	else
+		bank->context.dataout |= l;
+	} else {
 		reg += bank->regs->clr_dataout;
+		bank->context.dataout &= ~l;
+	}
 
 	__raw_writel(l, reg);
 }
-- 
1.7.0.4
