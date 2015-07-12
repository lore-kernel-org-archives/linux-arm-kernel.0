From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:40 -0500
Subject: [PATCH v2 02/13] clk: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
---
 drivers/clk/at91/pmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 39be2be..d1844f1 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -125,7 +125,6 @@ static int pmc_irq_map(struct irq_domain *h, unsigned int virq,
 
 	irq_set_chip_and_handler(virq, &pmc_irq,
 				 handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID);
 	irq_set_chip_data(virq, pmc);
 
 	return 0;
-- 
2.1.0
