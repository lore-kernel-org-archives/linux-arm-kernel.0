From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Sep 2014 16:02:24 +0200
Subject: [PATCH 2/2] ARM: at91: Give the PIT irq as an argument of
 at91sam926x_pit_init
In-Reply-To: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1410789744-23975-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to remove the dependency of the timer driver on mach/hardware.h and
having an hardcoded interrupt number in the driver itself.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260.c      | 2 +-
 arch/arm/mach-at91/at91sam9261.c      | 2 +-
 arch/arm/mach-at91/at91sam9263.c      | 2 +-
 arch/arm/mach-at91/at91sam9g45.c      | 2 +-
 arch/arm/mach-at91/at91sam9rl.c       | 2 +-
 arch/arm/mach-at91/generic.h          | 2 +-
 drivers/clocksource/timer-atmel-pit.c | 6 ++----
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index b61a255d4141..aab1f969a7c3 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -442,7 +442,7 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 
 static void __init at91sam9260_init_time(void)
 {
-	at91sam926x_pit_init();
+	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
 }
 
 AT91_SOC_START(at91sam9260)
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index badf20c2cd67..a8bd35963332 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -401,7 +401,7 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 
 static void __init at91sam9261_init_time(void)
 {
-	at91sam926x_pit_init();
+	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
 }
 
 AT91_SOC_START(at91sam9261)
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index ebb413e7f653..fbff228cc63e 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -424,7 +424,7 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 
 static void __init at91sam9263_init_time(void)
 {
-	at91sam926x_pit_init();
+	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
 }
 
 AT91_SOC_START(at91sam9263)
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f725814c556d..405427ec05f8 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -479,7 +479,7 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 
 static void __init at91sam9g45_init_time(void)
 {
-	at91sam926x_pit_init();
+	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
 }
 
 AT91_SOC_START(at91sam9g45)
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 361b4a6e7651..f553e4ea034b 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -412,7 +412,7 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 
 static void __init at91sam9rl_init_time(void)
 {
-	at91sam926x_pit_init();
+	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
 }
 
 AT91_SOC_START(at91sam9rl)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index fb99dabab8f7..189d7c7e7f60 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -48,7 +48,7 @@ extern void __init at91_init_time(void);
 extern void at91rm9200_ioremap_st(u32 addr);
 extern void at91rm9200_timer_init(void);
 extern void at91sam926x_ioremap_pit(u32 addr);
-extern void at91sam926x_pit_init(void);
+extern void at91sam926x_pit_init(int irq);
 extern void at91x40_timer_init(void);
 
  /* Clocks */
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 9abb289dce72..d5289098b3df 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -22,8 +22,6 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 
-#include <mach/hardware.h>
-
 #define AT91_PIT_MR		0x00			/* Mode Register */
 #define AT91_PIT_PITIEN			BIT(25)			/* Timer Interrupt Enable */
 #define AT91_PIT_PITEN			BIT(24)			/* Timer Enabled */
@@ -267,7 +265,7 @@ CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 
 static void __iomem *pit_base_addr;
 
-void __init at91sam926x_pit_init(void)
+void __init at91sam926x_pit_init(int irq)
 {
 	struct pit_data *data;
 
@@ -281,7 +279,7 @@ void __init at91sam926x_pit_init(void)
 	if (IS_ERR(data->mck))
 		panic(pr_fmt("Unable to get mck clk\n"));
 
-	data->irq = NR_IRQS_LEGACY + AT91_ID_SYS;
+	data->irq = irq;
 
 	at91sam926x_pit_common_init(data);
 }
-- 
2.1.0
