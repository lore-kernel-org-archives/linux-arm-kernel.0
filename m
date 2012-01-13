From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 10:35:54 +0000
Subject: [PATCH 1/2] versatile: sic: add device tree bindings
In-Reply-To: <20120113022932.GB25999@ponder.secretlab.ca>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
 <20120113022932.GB25999@ponder.secretlab.ca>
Message-ID: <20120113103554.GE14007@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 07:29:32PM -0700, Grant Likely wrote:
> On Fri, Jan 13, 2012 at 12:44:00AM +0000, Jamie Iles wrote:
> > @@ -53,6 +59,10 @@ void __init fpga_irq_init(int parent_irq, u32 
> > valid, struct fpga_irq_data *f)
> >  	f->chip.irq_ack = fpga_irq_mask;
> >  	f->chip.irq_mask = fpga_irq_mask;
> >  	f->chip.irq_unmask = fpga_irq_unmask;
> > +	f->domain.irq_base = f->irq_start;
> > +	f->domain.nr_irq = 32;
> > +	f->domain.ops = &irq_domain_simple_ops;
> > +	irq_domain_add(&f->domain);
> >  
> >  	if (parent_irq != -1) {
> >  		irq_set_handler_data(parent_irq, f);
> > @@ -70,3 +80,40 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
> >  		}
> >  	}
> >  }
> 
> There is a loop in fpga_irq_init() that sets up all the irqs, but with
> the introduction of the full irq_domain, that can be moved out to the
> .map irq_domain ops function.  The irq_domain will call it to set up
> each irq when it is requested.

That's not quite working for me - I have the following .map() function:

static int sic_irq_map(struct irq_domain *d, unsigned int virq,
		       irq_hw_number_t hw)
{
	struct fpga_irq_data *f = d->host_data;

	irq_set_chip_data(virq, f);
	irq_set_chip_and_handler(virq, &f->chip, handle_level_irq);
	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);

	return 0;
}

but when irq_domain_add_legacy() iterates over the irq's I haven't had 
chance to set the host_data.  The patch below works for me, not sure 
what you think.

I've also exported irq_domain_simple_xlate() so I can use that for the 
sic ops, I'll post that patch later.

Jamie

8<----

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 92928e2..e948490 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -121,11 +121,23 @@ struct irq_domain {
 };
 
 #ifdef CONFIG_IRQ_DOMAIN
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 struct irq_domain_ops *ops);
+struct irq_domain *irq_domain_add_legacy_data(struct device_node *of_node,
+					      unsigned int size,
+					      unsigned int first_irq,
+					      irq_hw_number_t first_hwirq,
+					      struct irq_domain_ops *ops,
+					      void *host_data);
+static inline struct irq_domain *
+irq_domain_add_legacy(struct device_node *of_node,
+		      unsigned int size,
+		      unsigned int first_irq,
+		      irq_hw_number_t first_hwirq,
+		      struct irq_domain_ops *ops)
+{
+	return irq_domain_add_legacy_data(of_node, size, first_irq,
+					  first_hwirq, ops, NULL);
+}
+
 struct irq_domain *irq_domain_add_linear(struct device_node *of_node,
 					 unsigned int size,
 					 struct irq_domain_ops *ops);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 67b28f6..2fd00a4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -75,11 +75,12 @@ static struct irq_domain *irq_domain_add(struct device_node *of_node,
  * for all legacy interrupts except 0 (which is always the invalid irq for
  * a legacy controller).
  */
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 struct irq_domain_ops *ops)
+struct irq_domain *irq_domain_add_legacy_data(struct device_node *of_node,
+					      unsigned int size,
+					      unsigned int first_irq,
+					      irq_hw_number_t first_hwirq,
+					      struct irq_domain_ops *ops,
+					      void *host_data)
 {
 	struct irq_domain *domain;
 	unsigned int i;
@@ -87,6 +88,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 	domain = irq_domain_alloc(of_node, IRQ_DOMAIN_MAP_LEGACY, ops);
 	if (!domain)
 		return NULL;
+	domain->host_data = host_data;
 
 	mutex_lock(&irq_domain_mutex);
 	/* Verify that all the irqs are available */
