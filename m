From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 4 Aug 2011 16:34:46 +0530
Subject: [PATCH v5 15/22] gpio/omap: use readl in irq_handler for all access
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1312455893-14922-16-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Charulatha V <charu@ti.com>

Even when bank->width is 16, all the OMAP1 registers are 4-byte aligned, so just
use a 4-byte read.  The 'enabled' mask is already taking care to mask for bank width.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3d18cdf..ba20e42 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -572,8 +572,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
-			isr &= 0x0000ffff;
 
 		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
-- 
1.7.0.4
