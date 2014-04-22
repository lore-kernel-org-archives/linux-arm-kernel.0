From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:42 +0200
Subject: [PATCH v2 38/38] ARM: orion: remove no longer needed gpio DT code
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-39-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the move to pure DT-based probing of the GPIO controllers on
Orion5x, some code in plat-orion/orion-gpio.c can be removed as it is
no longer used.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/gpio.c                    | 48 ---------------------------
 arch/arm/plat-orion/include/plat/orion-gpio.h |  1 -
 2 files changed, 49 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 6816192..b61a3bc 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -597,51 +597,3 @@ void __init orion_gpio_init(struct device_node *np,
 
 	orion_gpio_chip_count++;
 }
-
-#ifdef CONFIG_OF
-static void __init orion_gpio_of_init_one(struct device_node *np,
-					  int irq_gpio_base)
-{
-	int ngpio, gpio_base, mask_offset;
-	void __iomem *base;
-	int ret, i;
-	int irqs[4];
-	int secondary_irq_base;
-
-	ret = of_property_read_u32(np, "ngpio", &ngpio);
-	if (ret)
-		goto out;
-	ret = of_property_read_u32(np, "mask-offset", &mask_offset);
-	if (ret == -EINVAL)
-		mask_offset = 0;
-	else
-		goto out;
-	base = of_iomap(np, 0);
-	if (!base)
-		goto out;
-
-	secondary_irq_base = irq_gpio_base + (32 * orion_gpio_chip_count);
-	gpio_base = 32 * orion_gpio_chip_count;
-
-	/* Get the interrupt numbers. Each chip can have up to 4
-	 * interrupt handlers, with each handler dealing with 8 GPIO
-	 * pins. */
-
-	for (i = 0; i < 4; i++)
-		irqs[i] = irq_of_parse_and_map(np, i);
-
-	orion_gpio_init(np, gpio_base, ngpio, base, mask_offset,
-			secondary_irq_base, irqs);
-	return;
-out:
-	pr_err("%s: %s: missing mandatory property\n", __func__, np->name);
-}
-
-void __init orion_gpio_of_init(int irq_gpio_base)
-{
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "marvell,orion-gpio")
-		orion_gpio_of_init_one(np, irq_gpio_base);
-}
-#endif
diff --git a/arch/arm/plat-orion/include/plat/orion-gpio.h b/arch/arm/plat-orion/include/plat/orion-gpio.h
index 614dcac..e763988 100644
--- a/arch/arm/plat-orion/include/plat/orion-gpio.h
+++ b/arch/arm/plat-orion/include/plat/orion-gpio.h
@@ -33,5 +33,4 @@ void __init orion_gpio_init(struct device_node *np,
 			    int secondary_irq_base,
 			    int irq[4]);
 
-void __init orion_gpio_of_init(int irq_gpio_base);
 #endif
-- 
1.9.2
