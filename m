From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 2 Feb 2012 23:00:39 +0530
Subject: [PATCH v9 13/25] gpio/omap: remove unnecessary bit-masking for read
 access
In-Reply-To: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1328203851-20435-14-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove un-necessary bit masking. Since the register are 4 byte aligned
and readl would work as is. The 'enabled' mask is already taking care
to mask for bank width.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 485b6b2..38beccc 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -576,9 +576,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
-
 		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
 
-- 
1.7.0.4
