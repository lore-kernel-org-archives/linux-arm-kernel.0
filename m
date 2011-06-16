From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Jun 2011 10:56:24 -0600
Subject: [RFC PATCH 03/11] dt/irq: add irq_domain_add_simple() helper
In-Reply-To: <4DFA0D83.6070604@gmail.com>
References: <20110616042653.29371.2052.stgit@ponder>
	<20110616044141.29371.76366.stgit@ponder>
	<4DFA0D83.6070604@gmail.com>
Message-ID: <20110616165624.GG3795@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 09:04:51AM -0500, Rob Herring wrote:
> Grant,
> 
> On 06/15/2011 11:41 PM, Grant Likely wrote:
> > irq_domain_add_simple() is an easy way to generate an irq translation
> > domain for simple irq controllers.  It assumes a flat 1:1 mapping from
> > hardware irq number to an offset of the first linux irq number assigned
> > to the controller
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >  include/linux/irq.h    |   11 +++++++++
> >  kernel/irq/irqdomain.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 68 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index a103c01..50830fc 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -797,6 +797,17 @@ extern unsigned int irq_domain_map(struct irq_domain *domain,
> >  				   irq_hw_number_t hwirq);
> >  extern void irq_domain_unmap(struct irq_domain *domain, irq_hw_number_t hw);
> >  
> > +struct of_device_id;
> > +#ifdef CONFIG_OF
> > +extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
> > +extern void irq_domain_generate_simple(struct of_device_id *match,
> 
> match should be const

yup

> 
> > +					u64 phys_base, unsigned int irq_start);
> > +#else
> 
> Empty function for irq_domain_add_simple?

Haven't needed it yet.  I'll add it if it comes up.  Honestly, I'm not
even sure if this patch will survive very long once the IRQ
controllers start using irq_domains directly.  This is more of an easy
way to get an irq_domain registration so that DT translations work.

g.
