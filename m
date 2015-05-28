From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 15:48:28 -0700
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <55679085.6040402@wwwdotorg.org>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
 <55679085.6040402@wwwdotorg.org>
Message-ID: <20150528224828.GI24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28, Stephen Warren wrote:
> On 05/18/2015 01:43 PM, Eric Anholt wrote:
> > Unfortunately, the clock manager's registers are not accessible by the
> > ARM, so we have to request that the firmware modify our clocks for us.
> > 
> > This driver only registers the clocks at the point they are requested
> > by a client driver.  This is partially to support returning
> > -EPROBE_DEFER when the firmware driver isn't supported yet, but it
> > also avoids issues with disabling "unused" clocks due to them not yet
> > being connected to their consumers in the DT.
> 
> It looks like you forgot to CC the clock subsystem maintainers:
> 
> M:      Mike Turquette <mturquette@linaro.org>
> M:      Stephen Boyd <sboyd@codeaurora.org>
> 

Thanks, except I don't have the full patch context here to review
the patch.

> The description above sounds like a neat solution, but has the
> disadvantage that the clocks without a client won't show up in debugfs.
> I wonder if the clock maintainers know of a better way?

Can you mark them as CLK_IGNORE_UNUSED? The probe defer problem
has a solution in sight (see more below).

> > +static long rpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> > +			       unsigned long *parent_rate)
> > +{
> > +	/*
> > +	 * The firmware will end up rounding our rate to something,
> > +	 * but we don't have an interface for it.  Just return the
> > +	 * requested value, and it'll get updated after the clock gets
> > +	 * set.
> > +	 */
> > +	return rate;
> > +}
> 
> Hmm. I wonder if that will confuse things; I thought the purpose of
> round_rate() was so code could know exactly what would happen ahead of time?

We have to do the same thing on Qualcomm platforms for FW
controlled clocks. We don't have any insight to what the rate is
going to be. We can only ask the firmware to set a rate and the
firmware guarantees it will be at least that rate.

> 
> > +	init.flags = CLK_IS_ROOT;
> 
> Is it possible to add clock parent information to the driver, so the
> clocks are all hooked together into the correct tree, rather than all
> looking like root clocks?
> 
> One of the many reasons I didn't do anything FW-wise for the kernel was
> the hope that such information would be forthcoming, and hence we could
> have complete kernel drivers.
> 
> > +void __init rpi_firmware_init_clock_provider(struct device_node *node)
> > +{
> > +	/* We delay construction of our struct clks until get time,
> > +	 * because we need to be able to return -EPROBE_DEFER if the
> > +	 * firmware driver isn't up yet.  clk core doesn't support
> > +	 * re-probing on -EPROBE_DEFER, but callers of clk_get can.
> 
> Oh, that's nasty. What would it take to fix the clock core to support
> deferred probe? It really should.

There are patches to support probe defer from clk_get() but they
stalled because sunxi is needs to keep clocks on from their
providing driver (termed "critical clocks"). If we can resolve
the "critical clocks" thing then we should be able to support
probe defer, unless we find other users of orphaned clk
pointers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
