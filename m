From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Jan 2016 14:04:31 -0800
Subject: [PATCH v3 04/13] clk: at91: make IRQ optional and register them
 later
In-Reply-To: <20160116134558.716ef7d5@bbrezillon>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20160115020237.GJ22188@codeaurora.org>
 <20160115103901.1b987f53@bbrezillon>
 <20160116012612.GA20466@codeaurora.org>
 <20160116134558.716ef7d5@bbrezillon>
Message-ID: <20160120220431.GB12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16, Boris Brezillon wrote:
> Actually the PMC is not only exposing clocks. You have a bit in one of
> its registers that is used by a USB driver to enable a BIAS, and
> probably other things that are not directly related to clocks. Hence
> the idea to declare the PMC as an MFD/syscon device (which is in turn
> providing an IRQ chip).
> 
> Note that the irq problem we're talking about cannot be addressed by
> simply moving everything into the ->probe() function of the platform
> driver: we need the clock quite early in the boot process (it's
> required for the initial clocksource device), in the other hand you
> can't request threaded irqs when you're so early in the boot process,
> and this becomes a problem when you apply the preempt-RT patch which
> moves all standard irqs to threaded ones.
> So the idea was to use polling instead of the irq event until we are
> able to register threaded irqs, and then switch to an irq-able approach
> once everything is in place (platform devices are probed after the
> thread infrastructure has been setup, which is why we used this trick).

Just one more thought. If we had one platform driver for the
entire PMC could we also have an OF_CLK_DECLARE for it as well?
Then that OF_CLK_DECLARE could run early, register whatever
clocks are essential for the clocksource to work, and defer the
rest of the clock registration to when the device driver probes?
We'd still need some sort of global list of clocks that we
registered early, and this list might need to be per PMC if
there's more than one PMC, but we'd have all the clk_hw pointers
available when the platform driver probed. Oh and we'd need
clk_get() to return PROBE_DEFER too so that consumer drivers
could be deferred until the PMC driver probes.

I suppose this would be making more global variables, which isn't
preferred, so let's worry about this clk_hw vs clk pointer
problem later. We'll have to keep this driver in mind when we're
converting over clk providers to registering clk_hw pointers with
the of clk provider layer.

 Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
