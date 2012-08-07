From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Aug 2012 18:03:34 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120807170129.GA3759@gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
 <20120806160226.GF29272@sirena.org.uk>
 <20120807170129.GA3759@gmail.com>
Message-ID: <20120807170333.GV16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 06:01:30PM +0100, Lee Jones wrote:

> Okay, so I've just spent a small amount of time looking at this. I think
> the best place for this would be in *_get_virq(), using the same logic that
> selected a *_legacy or *_linear domain in the first place. The only thing 
> the domain can test for is the 'type' of domain and the requested IRQ. This
> is where the issue lies. If a hwirq to virq conversion is requested, but a
> virq is passed (which happens in the non-DT case) a WARN() is triggered
> because the irq passed is bigger than first_irq + size. I think *_get_virq()
> should ensure that only a hwirq is passed to irq_create_mapping().

> Let me know if you had other ideas.

I'd expect your driver to always pass a hwirq into _get_virq() here.
