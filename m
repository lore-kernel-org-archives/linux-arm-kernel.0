From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Jul 2014 20:24:32 +0200
Subject: [PATCHv3 3/7] clk: mvebu: extend clk-cpu for dynamic frequency
 scaling
In-Reply-To: <20140724175251.3823.74667@quantum>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140723235358.6419.26311@quantum>
 <20140724083325.0c578091@free-electrons.com>
 <20140724175251.3823.74667@quantum>
Message-ID: <20140724202432.6d242c82@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Turquette,

On Thu, 24 Jul 2014 10:52:51 -0700, Mike Turquette wrote:

> > > This is racy. You don't hold the clk_enable lock so it could be enable
> > > between the conditional check and executing clk_cpu_on_set_rate.
> > 
> > Right.
> > 
> > > How do you ensure that secondary CPU clocks are not enabled/disabled
> > > when changing rates?
> > 
> > In practice, this currently cannot happen: we enable the secondary CPU
> > clocks before starting the secondary CPUs, and we never ever disable or
> > re-enable again those clocks. So with the present code, I believe there
> > is no problem. Even when we do CPU hotplug, we don't turn off the CPU
> > clocks, simply because they cannot be turned off: the enable/disable
> > state is only used here as an indication so that the clock driver knows
> > which frequency change strategy it should apply.
> > 
> > But you're anyway right, I'll send a followup patch adding the lock.
> > Would that be OK for you?
> 
> Sounds good. Can you also fix up the changelog in patch #2? After that
> I am happy with this series. I guess Jason will take it in and send it
> for his PR?

The fixup for the commit log in patch #2 cannot be done, because the
commit has already been merged in arm-soc, if I understood correctly.
Jason said:

"""
> The commit log of this commit was not adjusted consequently, and this
> is my fault. Jason, is it still time to change this commit log?  

If there are no code changes, I'd prefer not to.  We're rather late in
the game.

Even though it's not ideal, the commit in question does have a Link: tag
pointing at the patch email on which this conversation is based.  So a
frustrated future developer won't be frustrated long. :)
"""

I'll do the lock patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
