From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Sep 2012 12:10:08 +0800
Subject: [PATCH 2/2] ARM: tegra: cpu-tegra: explicitly manage re-parenting
In-Reply-To: <20120911044530.20289.8165@nucleus>
References: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
 <1347318758-7954-2-git-send-email-swarren@wwwdotorg.org>
 <20120911044530.20289.8165@nucleus>
Message-ID: <20120912041001.GB3402@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 09:45:30PM -0700, Mike Turquette wrote:
> > To solve this, have the Tegra cpufreq driver explicitly perform the
> > reparenting operations itself. This is probably reasonable anyway,
> > since such reparenting is somewhat a matter of policy (e.g. which
> > alternate clock source to use, whether to leave the CPU clock a child
> > of the alternate clock source if it's running at the desired rate),
> > and hence is something more appropriate for the cpufreq driver than
> > the core clock driver anyway.
> > 
> 
> I definitely agree about the policy.  Just FYI I'm hacking on an RFC to
> make reparenting clocks from a call to clk_set_rate even easier, but
> perhaps in your case it is better the cpufreq driver knows the clock
> tree topology details.
> 
I disagree.  The whole point of clock framework is to hide clock details
like tree topology behind clock API, so that we do not need every single
clock client driver to handle those details on their own.  It's
definitely desired to have clk_set_rate call handle reparenting nicely.

>From what I see, if tegra clock driver can handle the dependency between
cpu_clk and emc_clk that is currently handled in cpufreq driver.  It's
likely that the generic cpufreq driver (cpufreq-cpu0) would work for
tegra.  But with this patch, the driver moves to the opposite direction.

Regards,
Shawn
