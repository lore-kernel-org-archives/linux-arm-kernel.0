From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Mar 2014 10:13:32 +0000
Subject: [PATCH v2 02/19] arm64: initial support for GICv3
In-Reply-To: <CABg9mcucJ_UouRbJ_Urirz6ita5uUvYuQkmeA1-Df00KSjFcnA@mail.gmail.com>
 (Z. Lim's message of "Tue, 25 Mar 2014 06:35:18 +0000")
References: <1395316386-12617-1-git-send-email-marc.zyngier@arm.com>
 <1395316386-12617-3-git-send-email-marc.zyngier@arm.com>
 <CAMDttNew0S7xVVKge7AAR3W6bdQzKdvN9Z7cHPDUCq=jZ98q1A@mail.gmail.com>
 <533012B8.2070303@arm.com>
 <CABg9mcucJ_UouRbJ_Urirz6ita5uUvYuQkmeA1-Df00KSjFcnA@mail.gmail.com>
Message-ID: <871txq7fhv.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25 2014 at  6:35:18 am GMT, Z Lim <zlim.lnx@gmail.com> wrote:

Hi Zi,

> I see this warning :(
> You can trigger it when a device's INT# falls within [gic_irqs-16, gic_irqs),
> which lines up with the -16 above.
>
>     irq_create_of_mapping ?// SPI# from DT
>
>         domain->ops->xlate (gic_irq_domain_xlate) ?// SPI# + 32 = INT# = hwirq
>        
>         irq_create_mapping ?// uses hwirq = INT#
>
>             irq_domain_associate ?// uses hwirq = INT#
>
>                 if (WARN(hwirq >= domain->hwirq_max, "error: hwirq 0x%x is too
>                 large for %s\n", (int)hwirq, domain->name)) ?// hwirq_max was
>                 set to (MAX_INT# - 16) above, uh oh...

I'm about to push out the following fix. Can you give it a go and let me
know if that works for you?

Thanks,

	M.

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 60ef92d..b90ea2c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -552,6 +552,8 @@ static struct irq_chip gic_chip = {
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
+	if (hw < 16)		/* SGIs are private to the core kernel */
+		return -EPERM;
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &gic_chip,
@@ -642,7 +644,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		gic_irqs = 1020;
 	gic_data.irq_nr = gic_irqs;
 
-	gic_data.domain = irq_domain_add_linear(node, gic_irqs - 16,
+	gic_data.domain = irq_domain_add_linear(node, gic_irqs,
 						&gic_irq_domain_ops, &gic_data);
 	gic_data.rdist.rdist = alloc_percpu(typeof(*gic_data.rdist.rdist));
 

-- 
Jazz is not dead. It just smells funny.
