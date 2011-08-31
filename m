From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 31 Aug 2011 19:12:30 +0530
Subject: [PATCH v6 14/25] gpio/omap: remove unnecessary bit-masking for read
	access
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1314798161-19523-15-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove un-necessary bit masking. Since the register are 4 byte aligned
and readl would work as is. The 'enabled' mask is already taking care
to mask for bank width.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e2a8b09..08c7991 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -567,8 +567,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
 
 		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
-- 
1.7.0.4
