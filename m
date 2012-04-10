From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 Apr 2012 17:32:44 +0200
Subject: [PATCH 1/1] ARM: at91: fix at91sam9261ek dm9000 irq
Message-ID: <1334071964-18990-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You need now to set the irq via gpio_to_irq.
since d0fbda9add (ARM: at91/gpio: drop PIN_BASE)

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable at vger.kernel.org
---
Hi Greg,

	this bug is present in 3.2 & 3.3

Best Regards,
J.
 arch/arm/mach-at91/board-sam9261ek.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 065b5ee..2736453 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -76,8 +76,6 @@ static struct resource dm9000_resource[] = {
 		.flags	= IORESOURCE_MEM
 	},
 	[2] = {
-		.start	= AT91_PIN_PC11,
-		.end	= AT91_PIN_PC11,
 		.flags	= IORESOURCE_IRQ
 			| IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE,
 	}
@@ -121,6 +119,8 @@ static struct sam9_smc_config __initdata dm9000_smc_config = {
 
 static void __init ek_add_device_dm9000(void)
 {
+	struct resource *r = &dm9000_resource[2];
+
 	/* Configure chip-select 2 (DM9000) */
 	sam9_smc_configure(0, 2, &dm9000_smc_config);
 
@@ -130,6 +130,7 @@ static void __init ek_add_device_dm9000(void)
 	/* Configure Interrupt pin as input, no pull-up */
 	at91_set_gpio_input(AT91_PIN_PC11, 0);
 
+	r->start = r->end = gpio_to_irq(AT91_PIN_PC11);
 	platform_device_register(&dm9000_device);
 }
 #else
-- 
1.7.9.1
