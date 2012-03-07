From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 7 Mar 2012 16:46:00 +0530
Subject: [PATCH v3 10/13] gpio/omap: fix missing dataout context save in
 _set_gpio_dataout_reg
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
which writes to dataout register and the dataout context must be saved.
It is missing in the first function, _set_gpio_dataout_reg(). Fix this.

Reported-by: Govindraj Raja <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8b4a7ba..04c2677 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -115,6 +115,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 		reg += bank->regs->clr_dataout;
 
 	__raw_writel(l, reg);
+	bank->context.dataout = l;
 }
 
 /* set data out value using mask register */
-- 
1.7.0.4
