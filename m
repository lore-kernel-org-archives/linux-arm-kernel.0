From: vazejai90@gmail.com (Jai Vaze)
Date: Thu, 13 Jun 2013 21:40:24 +0800
Subject: [PATCH 314/314] ARM: fix kernel hang at boot time on zeus board
Message-ID: <1371130824-3299-1-git-send-email-jai.vaze@simantinee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio irq configuration should be done after pxa-gpio platform
driver is loaded. Moved all gpio irq configuration from init_irq
to init_machine to fix kernel hang at boot time.

Signed-off-by: Jai Vaze <jai.vaze@simantinee.com>
---
 arch/arm/mach-pxa/zeus.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index f5d4364..5af7d50 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -133,8 +133,6 @@ static void __init zeus_init_irq(void)
 	int level;
 	int isa_irq;
 
-	pxa27x_init_irq();
-
 	/* Peripheral IRQs. It would be nice to move those inside driver
 	   configuration, but it is not supported at the moment. */
 	irq_set_irq_type(gpio_to_irq(ZEUS_AC97_GPIO), IRQ_TYPE_EDGE_RISING);
@@ -722,7 +720,7 @@ static int zeus_get_pcb_info(struct i2c_client *client, unsigned gpio,
 			continue;
 		}
 
-		pcb_info |= !!gpio_get_value(pcb_bit) << i;
+		pcb_info |= !!gpio_get_value_cansleep(pcb_bit) << i;
 
 		gpio_free(pcb_bit);
 	}
@@ -841,6 +839,8 @@ static void __init zeus_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(zeus_pin_config));
 
+	zeus_init_irq();
+
 	platform_add_devices(zeus_devices, ARRAY_SIZE(zeus_devices));
 
 	pxa_set_ohci_info(&zeus_ohci_platform_data);
@@ -908,7 +908,7 @@ MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	.atag_offset	= 0x100,
 	.map_io		= zeus_map_io,
 	.nr_irqs	= ZEUS_NR_IRQS,
-	.init_irq	= zeus_init_irq,
+	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.init_time	= pxa_timer_init,
 	.init_machine	= zeus_init,
-- 
1.7.0.4
