From: khilman@ti.com (Kevin Hilman)
Date: Fri, 20 May 2011 17:14:44 +0200
Subject: [PATCH 01/14] GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted
	write
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Message-ID: <1305904497-26013-2-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 78a1a6d3411de1a8b0dc1cb92754b5f12f251912 (ARM: OMAP4: Update
the GPIO support) braces were mistakenly added to included the
register read-back inside the cpu_is_* checking.

Remove the braces, ensuring that a register read-back is done, even
when the IRQSTATUS2 register is not written.

Note that the register read-back might be IRQSTATUS1 or IRQSTATUS2
depending on the CPU, but a read-back of any register in that region
will cause a flush of the posted writes.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 5d55886..b414644 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -708,12 +708,11 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	else if (cpu_is_omap44xx())
 		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		__raw_writel(gpio_mask, reg);
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
-	}
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
-- 
1.7.3.4
