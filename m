From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Aug 2012 09:04:12 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120807170333.GV16861@opensource.wolfsonmicro.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
Message-ID: <20120808080411.GB4728@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 06:03:34PM +0100, Mark Brown wrote:
> On Tue, Aug 07, 2012 at 06:01:30PM +0100, Lee Jones wrote:
> 
> > Okay, so I've just spent a small amount of time looking at this. I think
> > the best place for this would be in *_get_virq(), using the same logic that
> > selected a *_legacy or *_linear domain in the first place. The only thing 
> > the domain can test for is the 'type' of domain and the requested IRQ. This
> > is where the issue lies. If a hwirq to virq conversion is requested, but a
> > virq is passed (which happens in the non-DT case) a WARN() is triggered
> > because the irq passed is bigger than first_irq + size. I think *_get_virq()
> > should ensure that only a hwirq is passed to irq_create_mapping().
> 
> > Let me know if you had other ideas.
> 
> I'd expect your driver to always pass a hwirq into _get_virq() here.

Okay, actually this isn't so easy. Currently we have:

During DT boot:
 - No platform data is passed, hence no IRQ base for AB8500 is either
 - No IRQ base means we register a Linear IRQ Domain
 - MFD sees there is no base and leaves the IRQ resource as a hwirq
 - AB8500 child devices use *_get_virq() to convert the hwirq to a virq

During non-DT boot:
 - Platform data is passed, which contains an IRQ base
 - If an IRQ base is requested we use it to register a Legacy IRQ Domain
 - MFD adds the IRQ base to the hwirq and registers it as a virq
 - AB8500 child devices use *_get_virq() to convert virq to virq - *ERROR*

I guess my suggestion falls-back to placing logic in *_get_virq() to only
call irq_create_mapping() when when !ab8500->irq_base.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
