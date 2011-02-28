From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Feb 2011 13:33:42 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use EOI in
	parent chip
In-Reply-To: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
Message-ID: <1298900022-21516-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chained GPIO IRQ handler for the nomadik platform can be called
with the GIC as its host chip on the mach-ux500 machines.

This patch updates the code to use ->irq_eoi when it is available.

Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 1e88ecb..51cc71b 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -538,6 +538,8 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 
 	host_chip->irq_unmask(&desc->irq_data);
+	if (host_chip->irq_eoi)
+		host_chip->irq_eoi(&desc->irq_data);
 }
 
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
-- 
1.7.0.4
