From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 03 Jul 2018 10:56:47 +0200
Subject: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
In-Reply-To: <20180703071215.GM4348@dragon>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
 <1527248760.3472.6.camel@pengutronix.de>
 <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7> <20180703071215.GM4348@dragon>
Message-ID: <1530608207.22468.104.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Dienstag, den 03.07.2018, 15:12 +0800 schrieb Shawn Guo:
> On Mon, May 28, 2018 at 04:37:39PM +0530, Viresh Kumar wrote:
> > Hi Lucas,
> > 
> > On 25-05-18, 13:46, Lucas Stach wrote:
> > > This is a lot of duplicate information for what is effectively a shared
> > > ?cluster wide thing. This does absolutely not _feel_ right.
> > 
> > I cannot agree more :)
> > 
> > > What problem are you solving here? Why do we need all this duplicate
> > > information? Why can't we fix it by falling back to looking at cpu0 if
> > > needed?
> > 
> > Let me try explaining one of the problem scenarios to you as your
> > platform is a single cluster one. Make cpufreq driver as module, don't
> > insert it, hotplug out CPU0 and now insert the cpufreq driver. The
> > cpufreq core will try adding the cpufreq policy for CPU1 but wouldn't
> > find the required information in the DT node of CPU1 and so will fail
> > or behave incorrectly.
> > 
> > We can't look at CPU0 as we don't know they are related at all.
> > Nothing tells that to us. The right solution to fix the duplication is
> > to move to OPP-v2 bindings, which allow us to create a single OPP
> > table node and refer to it from all the CPU nodes. Because in case of
> > imx platforms getting updated here, we use the old and some platforms
> > specific frequency tables, we have to duplicate it everywhere.
> > 
> > But looking from DT otherwise, all the device should anyway have all
> > the information required right in their node. That can be simplified
> > with things like phandle to opp-v2 node, but still everything needs to
> > be there. We shouldn't really rely on other CPU nodes to make it work.
> > That would be an incomplete definition of the hardware IMHO.
> 
> Lucas,
> 
> Are you fine with the patch now considering the respond from Viresh?

I still don't like the huge duplication of information in the DT, but I
agree that it's currently necessary for correctness. Long term I hope
we can get away from cpufreq-imx6 and the custom SoC OPPs, which would
allow us to switch over to OPPv2.

So patch is:
Reluctantly-acked-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas
