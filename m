From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Sep 2014 16:02:23 +0200
Subject: [PATCH 1/2] ARM: at91: Revert "ARM: at91: PIT: Convert to an
 early_platform_device"
In-Reply-To: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1410789744-23975-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit e3304055287e7e620439e89db9e3fdf107684de2.

The early_platform_device mechanism shouldn't be used anymore, and since that
code is supposed to be removed soon, let's just rely on the
at91sam926x_pit_init function.

Eventually, we will be able to kill the last global variable from this driver
when we will remove at91sam926x_ioremap_pit and at91sam926x_pit_init.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260.c      | 30 ++------------------------
 arch/arm/mach-at91/at91sam9261.c      | 30 ++------------------------
 arch/arm/mach-at91/at91sam9263.c      | 30 ++------------------------
 arch/arm/mach-at91/at91sam9g45.c      | 30 ++------------------------
 arch/arm/mach-at91/at91sam9rl.c       | 30 ++------------------------
 arch/arm/mach-at91/generic.h          |  2 ++
 drivers/clocksource/timer-atmel-pit.c | 40 +++++++++++++++--------------------
 7 files changed, 29 insertions(+), 163 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d9aa4a3adab8..b61a255d4141 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -343,6 +343,7 @@ static void __init at91sam9260_map_io(void)
 static void __init at91sam9260_ioremap_registers(void)
 {
 	at91_ioremap_ramc(0, AT91SAM9260_BASE_SDRAMC, 512);
+	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9260_BASE_MATRIX);
 	at91_pm_set_standby(at91sam9_sdram_standby);
@@ -439,36 +440,9 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-static struct resource pit_resources[] = {
-	[0] = {
-		.start	= AT91SAM9260_BASE_PIT,
-		.end	= AT91SAM9260_BASE_PIT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.end	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device pit_device = {
-	.name		= "at91_pit",
-	.resource	= pit_resources,
-	.num_resources	= ARRAY_SIZE(pit_resources),
-};
-
-static struct platform_device *at91sam9260_early_devices[] __initdata = {
-	&pit_device,
-};
-
 static void __init at91sam9260_init_time(void)
 {
-	early_platform_add_devices(at91sam9260_early_devices,
-				   ARRAY_SIZE(at91sam9260_early_devices));
-
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 1, 0);
+	at91sam926x_pit_init();
 }
 
 AT91_SOC_START(at91sam9260)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 492149d8f177..badf20c2cd67 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -302,6 +302,7 @@ static void __init at91sam9261_map_io(void)
 static void __init at91sam9261_ioremap_registers(void)
 {
 	at91_ioremap_ramc(0, AT91SAM9261_BASE_SDRAMC, 512);
+	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9261_BASE_MATRIX);
 	at91_pm_set_standby(at91sam9_sdram_standby);
@@ -398,36 +399,9 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-static struct resource pit_resources[] = {
-	[0] = {
-		.start	= AT91SAM9261_BASE_PIT,
-		.end	= AT91SAM9261_BASE_PIT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.end	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device pit_device = {
-	.name		= "at91_pit",
-	.resource	= pit_resources,
-	.num_resources	= ARRAY_SIZE(pit_resources),
-};
-
-static struct platform_device *at91sam9261_early_devices[] __initdata = {
-	&pit_device,
-};
-
 static void __init at91sam9261_init_time(void)
 {
-	early_platform_add_devices(at91sam9261_early_devices,
-				   ARRAY_SIZE(at91sam9261_early_devices));
-
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 1, 0);
+	at91sam926x_pit_init();
 }
 
 AT91_SOC_START(at91sam9261)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index e8278b507f16..ebb413e7f653 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -323,6 +323,7 @@ static void __init at91sam9263_ioremap_registers(void)
 {
 	at91_ioremap_ramc(0, AT91SAM9263_BASE_SDRAMC0, 512);
 	at91_ioremap_ramc(1, AT91SAM9263_BASE_SDRAMC1, 512);
+	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
 	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
 	at91_ioremap_matrix(AT91SAM9263_BASE_MATRIX);
@@ -421,36 +422,9 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ1) */
 };
 
-static struct resource pit_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_PIT,
-		.end	= AT91SAM9263_BASE_PIT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.end	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device pit_device = {
-	.name		= "at91_pit",
-	.resource	= pit_resources,
-	.num_resources	= ARRAY_SIZE(pit_resources),
-};
-
-static struct platform_device *at91sam9263_early_devices[] __initdata = {
-	&pit_device,
-};
-
 static void __init at91sam9263_init_time(void)
 {
-	early_platform_add_devices(at91sam9263_early_devices,
-				   ARRAY_SIZE(at91sam9263_early_devices));
-
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 1, 0);
+	at91sam926x_pit_init();
 }
 
 AT91_SOC_START(at91sam9263)
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e45cce63b26c..f725814c556d 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -374,6 +374,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 {
 	at91_ioremap_ramc(0, AT91SAM9G45_BASE_DDRSDRC1, 512);
 	at91_ioremap_ramc(1, AT91SAM9G45_BASE_DDRSDRC0, 512);
+	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9G45_BASE_MATRIX);
 	at91_pm_set_standby(at91_ddr_standby);
@@ -476,36 +477,9 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller (IRQ0) */
 };
 
-static struct resource pit_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_PIT,
-		.end	= AT91SAM9G45_BASE_PIT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.end	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device pit_device = {
-	.name		= "at91_pit",
-	.resource	= pit_resources,
-	.num_resources	= ARRAY_SIZE(pit_resources),
-};
-
-static struct platform_device *at91sam9g45_early_devices[] __initdata = {
-	&pit_device,
-};
-
 static void __init at91sam9g45_init_time(void)
 {
-	early_platform_add_devices(at91sam9g45_early_devices,
-				   ARRAY_SIZE(at91sam9g45_early_devices));
-
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 1, 0);
+	at91sam926x_pit_init();
 }
 
 AT91_SOC_START(at91sam9g45)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 20838a498931..361b4a6e7651 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -312,6 +312,7 @@ static void __init at91sam9rl_map_io(void)
 static void __init at91sam9rl_ioremap_registers(void)
 {
 	at91_ioremap_ramc(0, AT91SAM9RL_BASE_SDRAMC, 512);
+	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
 	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
 	at91_ioremap_matrix(AT91SAM9RL_BASE_MATRIX);
 	at91_pm_set_standby(at91sam9_sdram_standby);
@@ -409,36 +410,9 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 	0,	/* Advanced Interrupt Controller */
 };
 
-static struct resource pit_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_PIT,
-		.end	= AT91SAM9RL_BASE_PIT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.end	= NR_IRQS_LEGACY + AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device pit_device = {
-	.name		= "at91_pit",
-	.resource	= pit_resources,
-	.num_resources	= ARRAY_SIZE(pit_resources),
-};
-
-static struct platform_device *at91sam9rl_early_devices[] __initdata = {
-	&pit_device,
-};
-
 static void __init at91sam9rl_init_time(void)
 {
-	early_platform_add_devices(at91sam9rl_early_devices,
-				   ARRAY_SIZE(at91sam9rl_early_devices));
-
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 1, 0);
+	at91sam926x_pit_init();
 }
 
 AT91_SOC_START(at91sam9rl)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 31a738539b52..fb99dabab8f7 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -47,6 +47,8 @@ extern void __init at91_register_devices(void);
 extern void __init at91_init_time(void);
 extern void at91rm9200_ioremap_st(u32 addr);
 extern void at91rm9200_timer_init(void);
+extern void at91sam926x_ioremap_pit(u32 addr);
+extern void at91sam926x_pit_init(void);
 extern void at91x40_timer_init(void);
 
  /* Clocks */
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 6fd97875bb5c..9abb289dce72 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -15,15 +15,15 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <mach/hardware.h>
+
 #define AT91_PIT_MR		0x00			/* Mode Register */
 #define AT91_PIT_PITIEN			BIT(25)			/* Timer Interrupt Enable */
 #define AT91_PIT_PITEN			BIT(24)			/* Timer Enabled */
@@ -265,40 +265,34 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
 CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);
 
-static int __init pit_early_probe(struct platform_device *pdev)
+static void __iomem *pit_base_addr;
+
+void __init at91sam926x_pit_init(void)
 {
 	struct pit_data *data;
-	struct resource *res;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		panic(pr_fmt("Unable to allocate memory\n"));
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!request_mem_region(res->start, resource_size(res),	"at91_pit"))
-		panic(pr_fmt("Unable to request memory region\n"));
-
-	data->base = ioremap(res->start, resource_size(res));
-	if (!data->base)
-		panic(pr_fmt("Impossible to ioremap PIT\n"));
+	data->base = pit_base_addr;
 
 	data->mck = clk_get(NULL, "mck");
 	if (IS_ERR(data->mck))
 		panic(pr_fmt("Unable to get mck clk\n"));
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		panic(pr_fmt("Unable to get IRQ from resources\n"));
+	data->irq = NR_IRQS_LEGACY + AT91_ID_SYS;
 
 	at91sam926x_pit_common_init(data);
-
-	return 0;
 }
 
-static struct platform_driver pit_driver __initdata = {
-	.probe		= pit_early_probe,
-	.driver		= {
-		.name	= "at91_pit",
-	},
-};
-early_platform_init("earlytimer", &pit_driver);
+void __init at91sam926x_ioremap_pit(u32 addr)
+{
+	if (of_have_populated_dt())
+		return;
+
+	pit_base_addr = ioremap(addr, 16);
+
+	if (!pit_base_addr)
+		panic(pr_fmt("Impossible to ioremap PIT\n"));
+}
-- 
2.1.0
