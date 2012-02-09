From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Feb 2012 15:36:04 -0800
Subject: [PATCH v6] irq: add irq_domain support to generic-chip
In-Reply-To: <4F344928.1060804@gmail.com>
References: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
 <1328741722-1254-1-git-send-email-robherring2@gmail.com>
 <20120209194806.GA2493@r65073-Latitude-D630>
 <4F344928.1060804@gmail.com>
Message-ID: <20120209233602.GA3135@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 04:31:04PM -0600, Rob Herring wrote:
> On 02/09/2012 01:48 PM, Shawn Guo wrote:
> > On Wed, Feb 08, 2012 at 04:55:22PM -0600, Rob Herring wrote:
...
> >> +	if (node)
> >> +		d = irq_domain_add_linear(node, hwirq_cnt,
> >> +					  &irq_gc_irq_domain_ops, gc);
> >> +	else
> >> +		d = irq_domain_add_legacy(node, hwirq_cnt, irq_base, 0,
> >> +					  &irq_gc_irq_domain_ops, gc);
> >> +
> > I do not think it's good to make this decision based on whether it's
> > dt or non-dt case.  That said, it's fairly valid and actually
> > encouraged that non-dt users use linear domain too, and also the
> > irqdomain core has no limit on dt users to use legacy domain.  Instead,
> > it's much more reasonable to make this decision based on if irq_base,
> > something like you did in your v3 patch.
> > 
> >  
> > -       if (node)
> > +       if ((int) irq_base < 0)
> > 
> 
> Really, we want to discourage/limit the use of legacy domains.

That's exactly the point I want to make.  Your current code forces
non-dt users to use legacy domain, since they always get 'node' as
NULL.  We should check irq_base, so that non-dt users can chose to
use linear domain by passing irq_base as something like -1.

Regards,
Shawn

> This is
> only used for ISA irqs on powerpc. Unfortunately, there's not really a
> way to use linear domains for non-DT ATM. But maybe we can fix that.
> 
