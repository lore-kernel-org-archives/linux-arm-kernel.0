From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 11 Jan 2011 17:16:50 -0600
Subject: [PATCH 5/5 v2] ARM: pxa: Fix recursive call of
	pxa_(un)mask_low_gpio()
In-Reply-To: <1294699993-4712-5-git-send-email-marek.vasut@gmail.com>
References: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
	<1294699993-4712-5-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTikOUHOC2nrfKpcO=rE=CbdthvU0JxbCtOc1piSK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original intention is to re-use pxa_{mask,unmask}_irq(), will
the change below looks better? The move of irq_base() is to avoid
the error of function not declared.

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a7deff5..6107253 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -53,6 +53,17 @@ static inline int cpu_has_ipr(void)
 	return !cpu_is_pxa25x();
 }

+static inline void __iomem *irq_base(int i)
+{
+	static unsigned long phys_base[] = {
+		0x40d00000,
+		0x40d0009c,
+		0x40d00130,
+	};
+
+	return (void __iomem *)io_p2v(phys_base[i]);
+}
+
 static void pxa_mask_irq(unsigned int irq)
 {
 	void __iomem *base = get_irq_chip_data(irq);
@@ -108,25 +119,11 @@ static void pxa_ack_low_gpio(unsigned int irq)
 	GEDR0 = (1 << (irq - IRQ_GPIO0));
 }

-static void pxa_mask_low_gpio(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	desc->chip->mask(irq);
-}
-
-static void pxa_unmask_low_gpio(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	desc->chip->unmask(irq);
-}
-
 static struct irq_chip pxa_low_gpio_chip = {
 	.name		= "GPIO-l",
 	.ack		= pxa_ack_low_gpio,
-	.mask		= pxa_mask_low_gpio,
-	.unmask		= pxa_unmask_low_gpio,
+	.mask		= pxa_mask_irq,
+	.unmask		= pxa_unmask_irq,
 	.set_type	= pxa_set_low_gpio_type,
 };

@@ -141,6 +138,7 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)

 	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
 		set_irq_chip(irq, &pxa_low_gpio_chip);
+		set_irq_chip_data(irq, irq_base(0));
 		set_irq_handler(irq, handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
@@ -148,17 +146,6 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
 	pxa_low_gpio_chip.set_wake = fn;
 }

-static inline void __iomem *irq_base(int i)
-{
-	static unsigned long phys_base[] = {
-		0x40d00000,
-		0x40d0009c,
-		0x40d00130,
-	};
-
-	return (void __iomem *)io_p2v(phys_base[i]);
-}
-
 void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 {
 	int irq, i, n;

On Mon, Jan 10, 2011 at 4:53 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> v2: Remove dead code as proposed by Sergei
>
> ?arch/arm/mach-pxa/irq.c | ? ?8 ++------
> ?1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index a7deff5..76e69cf 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -110,16 +110,12 @@ static void pxa_ack_low_gpio(unsigned int irq)
>
> ?static void pxa_mask_low_gpio(unsigned int irq)
> ?{
> - ? ? ? struct irq_desc *desc = irq_to_desc(irq);
> -
> - ? ? ? desc->chip->mask(irq);
> + ? ? ? pxa_mask_irq(irq);
> ?}
>
> ?static void pxa_unmask_low_gpio(unsigned int irq)
> ?{
> - ? ? ? struct irq_desc *desc = irq_to_desc(irq);
> -
> - ? ? ? desc->chip->unmask(irq);
> + ? ? ? pxa_unmask_irq(irq);
> ?}
>
> ?static struct irq_chip pxa_low_gpio_chip = {
> --
> 1.7.2.3
>
>
