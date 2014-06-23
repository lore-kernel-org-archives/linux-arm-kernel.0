From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 13:50:41 -0400
Subject: [PATCH v3 1/7] genirq: generic chip: export
 irq_map_generic_chip function
In-Reply-To: <53A842C3.6060606@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140621235108.GJ21711@titan.lakedaemon.net>
 <53A68CF0.8040303@free-electrons.com>
 <20140623130705.GM21711@titan.lakedaemon.net>
 <53A842C3.6060606@free-electrons.com>
Message-ID: <20140623175041.GB10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 05:07:47PM +0200, Boris BREZILLON wrote:
> 
> On 23/06/2014 15:07, Jason Cooper wrote:
> > On Sun, Jun 22, 2014 at 09:59:44AM +0200, Boris BREZILLON wrote:
> >> On 22/06/2014 01:51, Jason Cooper wrote:
> >>> On Fri, Jun 20, 2014 at 05:01:21PM +0200, Boris BREZILLON wrote:
> >>>> Export the generic irq map function in order to provide irq_domain ops with
> >>>> generic mapping and specific of xlate function (needed by the new atmel
> >>>> AIC driver).
> >>>>
> >>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> >>>> ---
> >>>>  include/linux/irq.h       | 2 ++
> >>>>  kernel/irq/generic-chip.c | 5 +++--
> >>>>  2 files changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/irq.h b/include/linux/irq.h
> >>>> index 0d998d8..62af592 100644
> >>>> --- a/include/linux/irq.h
> >>>> +++ b/include/linux/irq.h
> >>>> @@ -771,6 +771,8 @@ void irq_gc_eoi(struct irq_data *d);
> >>>>  int irq_gc_set_wake(struct irq_data *d, unsigned int on);
> >>>>  
> >>>>  /* Setup functions for irq_chip_generic */
> >>>> +int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> >>>> +			 irq_hw_number_t hw_irq);
> >>>>  struct irq_chip_generic *
> >>>>  irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
> >>>>  		       void __iomem *reg_base, irq_flow_handler_t handler);
> >>>> diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
> >>>> index 452d6f2..cf80e7b 100644
> >>>> --- a/kernel/irq/generic-chip.c
> >>>> +++ b/kernel/irq/generic-chip.c
> >>>> @@ -341,8 +341,8 @@ static struct lock_class_key irq_nested_lock_class;
> >>>>  /*
> >>>>   * irq_map_generic_chip - Map a generic chip for an irq domain
> >>>>   */
> >>>> -static int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> >>>> -				irq_hw_number_t hw_irq)
> >>>> +int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> >>>> +			 irq_hw_number_t hw_irq)
> >>>>  {
> >>>>  	struct irq_data *data = irq_get_irq_data(virq);
> >>>>  	struct irq_domain_chip_generic *dgc = d->gc;
> >>>> @@ -394,6 +394,7 @@ static int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
> >>>>  	irq_modify_status(virq, dgc->irq_flags_to_clear, dgc->irq_flags_to_set);
> >>>>  	return 0;
> >>>>  }
> >>>> +EXPORT_SYMBOL_GPL(irq_map_generic_chip);
> >>>>  
> >>>>  struct irq_domain_ops irq_generic_chip_ops = {
> >>>>  	.map	= irq_map_generic_chip,
> >>> Why can't you use irq_generic_chip_ops.map in your code and avoid this
> > s/code/declaration/, sorry for the misunderstanding.
> >
> >>> patch entirely?
> >> Because in this case I'll have to remove constness from my
> >> irq_domain_ops struct and initialize it in my init function.
> >> This is not a big concern, but in general I tend to declare ops struct
> >> with a const constraint.
> > /*
> >  * We're the only user of irq_map_generic_chip() who
> >  * doesn't also use irq_domain_xlate_onetwocell()
> >  */
> > static const struct irq_domain_ops aic_irq_ops = {
> > 	.map    = irq_generic_chip_ops.map,
> >         .xlate  = aic_irq_domain_xlate,
> > };
> >
> > Wouldn't work?
> 
> No, it fails  with :
> 
> "error: initializer element is not constant"

Gah!  Of course.  That's what I get for pseudo-coding without sufficient
coffee. :)

I won't have a chance to dig deeper into this until tonight or the next
few days.  But my primary concern is that they chose to export the
struct for a reason.  I'd like to dig through the history and find out
why.

Assuming there's no big reason not to export the function(s) directly,
I'm fine with exporting them.  But it would be nice to get Thomas' Ack
before I take the original patch since it touches core code.

thx,

Jason.
