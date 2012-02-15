From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Feb 2012 14:20:22 -0700
Subject: [PATCH 1/8] irq: choose irq_domain type for generic-chip based
 on irq_base
In-Reply-To: <4F3982F2.2030301@gmail.com>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
 <1328980472-11923-2-git-send-email-shawn.guo@linaro.org>
 <4F3982F2.2030301@gmail.com>
Message-ID: <20120215212022.GK25779@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:38:58PM -0600, Rob Herring wrote:
> On 02/11/2012 11:14 AM, Shawn Guo wrote:
> > Choosing irq_domain type for generic-chip based on device_node forces
> > non-DT users to use legacy irq_domain, which makes no sense, because
> > linear irq_domain is actually encouraged to be used by both DT and
> > non-DT users.
> 
> NAK
> 
> Encouraged by who? As we discussed in person at Connect, I said you
> should use legacy domain for non-DT case. Grant and I have discussed
> this as well and agree.

Yes.  I'd *like* for everyone (DT and non-DT) to be able to use the
linear revmap, but I can't see any nice way to do it as long as
devices are registered with hard coded #define irq numbers.

> 
> > The patch changes it to make the decision based on irq_base.  If users
> > pass in a negative irq_base value, a linear irq_domain will be created,
> > otherwise a legacy irq_domain will be created.
> 
> This allows DT users to decide as well and possibly use legacy domains
> which is explicitly what I was trying to prevent. DT users must use
> linear domains and non-DT must use legacy. Otherwise, we'll get more
> half done DT conversions like mx5 is.
> 
> Getting linear domains to work for non-DT to work would be a worthwhile
> goal if we didn't plan to remove non-DT boards. I don't think we really
> need linear to work for non-DT case.

I agree with that.

> 
> Rob
> 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/irq/generic-chip.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
> > index 3ac7fa1..839f882 100644
> > --- a/kernel/irq/generic-chip.c
> > +++ b/kernel/irq/generic-chip.c
> > @@ -346,7 +346,7 @@ int irq_setup_generic_chip_domain(const char *name, struct device_node *node,
> >  		irq_setup_generic_chip(gc[i], 0, flags, clr, set);
> >  	}
> >  
> > -	if (node)
> > +	if ((int) irq_base < 0)
> >  		d = irq_domain_add_linear(node, hwirq_cnt,
> >  					  &irq_gc_irq_domain_ops, gc);
> >  	else
> 
