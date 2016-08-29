From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:29 +0100
Subject: [PATCH 28/33] ARM: sa1100/neponset: add GPIOs for PCMCIA
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJlt-0000oR-2p@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the gpiod table for Neponset PCMCIA power control.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 75d758ca6799..790d8da233da 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -3,6 +3,7 @@
  */
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio-reg.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -95,6 +96,19 @@ struct neponset_drvdata {
 	struct gpio_chip *gpio[4];
 };
 
+static struct gpiod_lookup_table neponset_pcmcia_table = {
+	.dev_id = "1800",
+	.table = {
+		GPIO_LOOKUP("sa1111", 1, "a0vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 0, "a1vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("neponset-ncr", 5, "a0vpp", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("neponset-ncr", 6, "a1vpp", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 2, "b0vcc", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 3, "b1vcc", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct neponset_drvdata *nep;
 
 void neponset_ncr_frob(unsigned int mask, unsigned int val)
@@ -370,6 +384,8 @@ static int neponset_probe(struct platform_device *dev)
 			   d->base + AUD_CTL, AUD_NGPIO, false,
 			   neponset_aud_names);
 
+	gpiod_add_lookup_table(&neponset_pcmcia_table);
+
 	/*
 	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
 	 * something on the Neponset activates this IRQ on sleep (eth?)
@@ -423,6 +439,9 @@ static int neponset_remove(struct platform_device *dev)
 		platform_device_unregister(d->sa1111);
 	if (!IS_ERR(d->smc91x))
 		platform_device_unregister(d->smc91x);
+
+	gpiod_remove_lookup_table(&neponset_pcmcia_table);
+
 	irq_set_chained_handler(irq, NULL);
 	irq_free_descs(d->irq_base, NEP_IRQ_NR);
 	nep = NULL;
-- 
2.1.0
