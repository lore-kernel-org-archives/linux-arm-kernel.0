From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 15:06:38 +0200
Subject: [PATCH 06/13] AT91: PIT: Use consistent exit path in probe
In-Reply-To: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1403701605-26678-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current probe code is, whenever it fails to retrieve a resource, either
panicing, silently returning, or returning and displaying an error.

Make the code consistent by always panicing whenever it fails to grab any
resource.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam926x_time.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index e953197e5a5c..c2262988f638 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -208,7 +208,7 @@ static void __init at91sam926x_pit_common_init(void)
 	/* Set up irq handler */
 	ret = setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
 	if (ret)
-		pr_crit("AT91: PIT: Unable to setup IRQ\n");
+		panic("AT91: PIT: Unable to setup IRQ\n");
 
 	/* Set up and register clockevents */
 	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
@@ -222,7 +222,7 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 
 	pit_base_addr = of_iomap(node, 0);
 	if (!pit_base_addr)
-		return;
+		panic("AT91: PIT: Could not map PIT address\n");
 
 	mck = of_clk_get(node, 0);
 	if (IS_ERR(mck))
@@ -234,18 +234,12 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 
 	/* Get the interrupts property */
 	irq = irq_of_parse_and_map(node, 0);
-	if (!irq) {
-		pr_crit("AT91: PIT: Unable to get IRQ from DT\n");
-		goto clk_err;
-	}
+	if (!irq)
+		panic("AT91: PIT: Unable to get IRQ from DT\n");
 
 	at91sam926x_pit_irq.irq = irq;
 
 	at91sam926x_pit_common_init();
-
-clk_err:
-	clk_put(mck);
-	iounmap(pit_base_addr);
 }
 CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
@@ -256,7 +250,7 @@ void __init at91sam926x_pit_init(void)
 	if (IS_ERR(mck))
 		panic("AT91: PIT: Unable to get mck clk\n");
 
-	at91sam926x_pit_irq.irq = NR_IRQS_LEGACY + AT91_ID_SYS,
+	at91sam926x_pit_irq.irq = NR_IRQS_LEGACY + AT91_ID_SYS;
 
 	at91sam926x_pit_common_init();
 }
-- 
2.0.0
