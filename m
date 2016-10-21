From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Oct 2016 18:46:42 +0100
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580A4460.2090306@free.fr>
References: <580A4460.2090306@free.fr>
Message-ID: <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/16 17:37, Mason wrote:
> Hello,
> 
> On my platform, one HW block pulls the interrupt line high
> as long as it remains idle, and low when it is busy.
> 
> The device tree node is:
> 
> 		test at 22222 {
> 			compatible = "vendor,testme";
> 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
> 		};

I assume that this is for the sake of the discussion, and that you do
not actually intend to put together such a monstrosity.

> 
> I wrote a minimal driver which registers the irq.
> And in the interrupt handler, I disable said irq.
> 
> Since the irq is IRQ_TYPE_LEVEL_HIGH, it will fire as soon as
> it is registered (because the block is idle).
> 
> Here is the code I've been running, request_irq doesn't return.

[...]

> And here's what I get when I try to load the module:
> (I'm using the default CONFIG_RCU_CPU_STALL_TIMEOUT=21)

[...]

> Are we not supposed to disable the irq in the handler?

You can. It then depends on what your interrupt controller does to
actually ensure that the interrupt is disabled. Only you can trace it on
your HW to find out.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
