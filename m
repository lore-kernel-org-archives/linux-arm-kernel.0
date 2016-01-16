From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 16 Jan 2016 13:45:58 +0100
Subject: [PATCH v3 04/13] clk: at91: make IRQ optional and register them
 later
In-Reply-To: <20160116012612.GA20466@codeaurora.org>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20160115020237.GJ22188@codeaurora.org>
 <20160115103901.1b987f53@bbrezillon>
 <20160116012612.GA20466@codeaurora.org>
Message-ID: <20160116134558.716ef7d5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jan 2016 17:26:12 -0800
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 01/15, Boris Brezillon wrote:
> > Hi Stephen,
> > 
> > On Thu, 14 Jan 2016 18:02:37 -0800
> > Stephen Boyd <sboyd@codeaurora.org> wrote:
> > > 
> > > Is there any way to get the irq into this probe function without
> > > getting a clk pointer and then unwrapping it to get an irq
> > > value out of the clk_hw wrapper structure? That's a pretty
> > > convoluted design.
> > 
> > Not sure I get what you're suggesting, but the only solution I see to
> > avoid this "get main clk pointer dance" would be to have a global
> > variable storing the clk_main instance (or a list of clk_main
> > instances).
> > The thing is, I'd like to avoid adding new global variables in this
> > clk drivers as much as possible. Moreover, the core is already taking
> > care of keeping the list of all registered clks, with their associated
> > of_node, so, is there a real point in creating a duplicated association
> > list in this driver too?
> 
> Ok I have to admit I'm a little confused. I thought we were
> getting the irq from the clkmain structure so that we could
> request it here in the probe function. But we're really assigning
> the irq so that we can enable/disable/free it later on?
> 
> So my new question is if we can register the clocks at the same
> time as the "platform device" (really a clock) probes. The
> correct design was probably to have pmc be a big platform device
> and have it register clocks that it knows exist inside it based
> on the compatible string. And it would also know which irqs (or
> enforce some ordering of irqs) to assign to which clocks.
> 
> It looks like we totally missed that though.... so now we have
> many DT nodes that are also platform devices. So if we can do it
> at the same time as irq requests then we're good and the clk_hw
> structure is in the same scope. If not, then we should probably
> just let of_clk_hw_get_from_provider() happen (and it needs to
> happen for other reasons anyway) and call it a day.
> 

Actually the PMC is not only exposing clocks. You have a bit in one of
its registers that is used by a USB driver to enable a BIAS, and
probably other things that are not directly related to clocks. Hence
the idea to declare the PMC as an MFD/syscon device (which is in turn
providing an IRQ chip).

Note that the irq problem we're talking about cannot be addressed by
simply moving everything into the ->probe() function of the platform
driver: we need the clock quite early in the boot process (it's
required for the initial clocksource device), in the other hand you
can't request threaded irqs when you're so early in the boot process,
and this becomes a problem when you apply the preempt-RT patch which
moves all standard irqs to threaded ones.
So the idea was to use polling instead of the irq event until we are
able to register threaded irqs, and then switch to an irq-able approach
once everything is in place (platform devices are probed after the
thread infrastructure has been setup, which is why we used this trick).

This whole series was actually made for 2 reasons:
- expose the PMC as a syscon device so that the USB driver can access
  it's register without having to expose a global void __iomem *
  variable
- address the preemt-RT/threaded irq problem I explained above

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
