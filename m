From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Jan 2013 14:30:14 +0200
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
In-Reply-To: <50D4D44F.2080203@wwwdotorg.org>
References: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
 <50D4D44F.2080203@wwwdotorg.org>
Message-ID: <20130102123014.GU19766@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 10:27:43PM +0100, Stephen Warren wrote:
> On 12/21/2012 03:09 AM, Richard Zhao wrote:
> > tegra_cpu_init/exit will be called every time one cpu core is online or
> > offline. And all cpu cores share same clocks, redundant clk_get/put
> > wast time,  so I move them out.
> 
> I think this is reasonable.
> 
> Prashant, Peter, any comments?
> 
> Is any other work in tegra_cpu_init() redundant? Is tegra_cpu_init()
> supposed to be called due to hotplug, or is that a bug in the cpufreq core?

I think we want to keep target_cpu_speed[] as a possible input for the
(to be upstreamed) cluster switching logic. Yes, tegra_cpu_init() should be
called due to hotplug. Some systems might need specific initialization for
cpufreq when a new CPU comes online. Also the available frequencies might
be different per CPU. So this information needs to be provided for each
CPU.

Cheers,

Peter.
