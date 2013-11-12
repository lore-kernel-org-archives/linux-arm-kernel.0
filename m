From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:45 +0100
Subject: [PATCH 7/7] ARM: sa1100: move state to the overall container
Message-ID: <1384264125-6431-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of saving the state of registers in a special struct
across suspend/resume, use some fields in the generic system
controller state container struct.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index a6823f3281e2..ce847939ac65 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -40,6 +40,10 @@
  * @gpio_falling: whether the IRQ for the GPIO corresponding to the
  * bit in this word should trigger on falling edges.
  * @gpio_mask: whether this GPIO is masked off.
+ * @saved: indicates whether we have a saved state.
+ * @icmr: saved state for the ICMR register.
+ * @iclr: saved state for the ICLR register.
+ * @iccr: saved state for the ICCR register.
  */
 struct sa1100_sc {
 	struct irq_domain *domain;
@@ -50,6 +54,10 @@ struct sa1100_sc {
 	u32 gpio_rising;
 	u32 gpio_falling;
 	u32 gpio_mask;
+	bool saved;
+	u32 icmr;
+	u32 iclr;
+	u32 iccr;
 };
 
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
@@ -286,22 +294,14 @@ static struct irq_domain_ops sa1100_sc_high_irqdomain_ops = {
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
-static struct sa1100irq_state {
-	unsigned int	saved;
-	unsigned int	icmr;
-	unsigned int	iclr;
-	unsigned int	iccr;
-} sa1100irq_state;
-
 static int sa1100irq_suspend(void)
 {
 	struct sa1100_sc *sc = &sa1100_sc;
-	struct sa1100irq_state *st = &sa1100irq_state;
 
-	st->saved = 1;
-	st->icmr = ICMR;
-	st->iclr = ICLR;
-	st->iccr = ICCR;
+	sc->saved = true;
+	sc->icmr = ICMR;
+	sc->iclr = ICLR;
+	sc->iccr = ICCR;
 
 	/*
 	 * Disable all GPIO-based interrupts.
@@ -327,16 +327,13 @@ static int sa1100irq_suspend(void)
 static void sa1100irq_resume(void)
 {
 	struct sa1100_sc *sc = &sa1100_sc;
-	struct sa1100irq_state *st = &sa1100irq_state;
-
-	if (st->saved) {
-		ICCR = st->iccr;
-		ICLR = st->iclr;
 
+	if (sc->saved) {
+		ICCR = sc->iccr;
+		ICLR = sc->iclr;
 		GRER = sc->gpio_rising & sc->gpio_mask;
 		GFER = sc->gpio_falling & sc->gpio_mask;
-
-		ICMR = st->icmr;
+		ICMR = sc->icmr;
 	}
 }
 
-- 
1.8.3.1
