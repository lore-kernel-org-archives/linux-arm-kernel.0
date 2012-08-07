From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Aug 2012 18:01:30 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120806160226.GF29272@sirena.org.uk>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
 <20120806160226.GF29272@sirena.org.uk>
Message-ID: <20120807170129.GA3759@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 05:02:26PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2012 at 04:37:52PM +0100, Lee Jones wrote:
> > On Mon, Aug 06, 2012 at 01:19:15AM -0700, Dmitry Torokhov wrote:
> 
> > > > +	ponkey->irq_dbf = (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) : irq_dbf;
> > > > +	ponkey->irq_dbr = (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) : irq_dbr;
> 
> > > Why this isn't done inside ab8500_irq_get_virq()?
> 
> > There's no reason why it can't be.
> 
> > My first version of the patch did just that in fact.
> 
> > Would that be your preference?
> 
> Restating my comment elsewhere...  why do we even need to do this in
> _get_virq() - I'd *really* expect this to be handled by the irq domain
> code.

Okay, so I've just spent a small amount of time looking at this. I think
the best place for this would be in *_get_virq(), using the same logic that
selected a *_legacy or *_linear domain in the first place. The only thing 
the domain can test for is the 'type' of domain and the requested IRQ. This
is where the issue lies. If a hwirq to virq conversion is requested, but a
virq is passed (which happens in the non-DT case) a WARN() is triggered
because the irq passed is bigger than first_irq + size. I think *_get_virq()
should ensure that only a hwirq is passed to irq_create_mapping().

Let me know if you had other ideas.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
