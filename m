From: mturquette@ti.com (Mike Turquette)
Date: Tue, 11 Sep 2012 10:20:34 -0700
Subject: [PATCH 2/2] ARM: tegra: cpu-tegra: explicitly manage re-parenting
In-Reply-To: <504F22E6.9040307@nvidia.com>
References: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
 <1347318758-7954-2-git-send-email-swarren@wwwdotorg.org>
 <20120911044530.20289.8165@nucleus> <504ECF89.5050809@wwwdotorg.org>
 <504F22E6.9040307@nvidia.com>
Message-ID: <20120911172034.20289.95189@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Prashant Gaikwad (2012-09-11 04:39:18)
> On Tuesday 11 September 2012 11:13 AM, Stephen Warren wrote:
> 
>     On 09/10/2012 10:45 PM, Mike Turquette wrote:
> 
>         Quoting Stephen Warren (2012-09-10 16:12:38)
> 
>             From: Stephen Warren <swarren@nvidia.com>
> 
>             When changing a PLL's rate, it must have no active children. The CPU
>             clock cannot be stopped, and CPU clock's divider is not used. The old
>             clock driver used to handle this by internally reparenting the CPU clock
>             onto a different PLL when changing the CPU clock rate. However, the new
>             common-clock based clock driver does not do this, and probably cannot do
>             this due to the locking issues it would cause.
> 
> 
>         This is possible today.  Clock drivers can call __clk_reparent to update
>         the common clk bookkeeping to reflect changes in parent muxing.  There
>         are some examples of this out in the wild, and the unmerged OMAP port
>         certainly uses this during the PLL relock sequence.
> 
>     The CPU clock's set_rate needs to both __clk_reparent() /and/ set the
>     rate of the parent PLL. I think a (non-static) __clk_set_rate() is
>     missing? (although perhaps that could be easily solved if desired).
> 
> 
>             To solve this, have the Tegra cpufreq driver explicitly perform the
>             reparenting operations itself. This is probably reasonable anyway,
>             since such reparenting is somewhat a matter of policy (e.g. which
>             alternate clock source to use, whether to leave the CPU clock a child
>             of the alternate clock source if it's running at the desired rate),
>             and hence is something more appropriate for the cpufreq driver than
>             the core clock driver anyway.
> 
>         I definitely agree about the policy.  Just FYI I'm hacking on an RFC to
>         make reparenting clocks from a call to clk_set_rate even easier, but
>         perhaps in your case it is better the cpufreq driver knows the clock
>         tree topology details.
> 
>     OK, sounds fine to me:-)
> 
> 
> Policies can change for Tegra20 and Tegra30. IMO we should implement it in clock driver.
> But it can not be done unless there is a way to call clk_set_rate from clk ops.

OMAP 4460/4470 have a similar constraint to have reparenting operation
depending on the frequency that the ARM runs at.  I'll try to implement
this soon and I will Cc you guys on it.  Hopefully the same method makes
sense for you.

Regards,
Mike
