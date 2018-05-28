From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 May 2018 16:37:39 +0530
Subject: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
In-Reply-To: <1527248760.3472.6.camel@pengutronix.de>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
 <1527248760.3472.6.camel@pengutronix.de>
Message-ID: <20180528110739.ewmhlf72sl7u5ju7@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On 25-05-18, 13:46, Lucas Stach wrote:
> This is a lot of duplicate information for what is effectively a shared
>  cluster wide thing. This does absolutely not _feel_ right.

I cannot agree more :)

> What problem are you solving here? Why do we need all this duplicate
> information? Why can't we fix it by falling back to looking at cpu0 if
> needed?

Let me try explaining one of the problem scenarios to you as your
platform is a single cluster one. Make cpufreq driver as module, don't
insert it, hotplug out CPU0 and now insert the cpufreq driver. The
cpufreq core will try adding the cpufreq policy for CPU1 but wouldn't
find the required information in the DT node of CPU1 and so will fail
or behave incorrectly.

We can't look at CPU0 as we don't know they are related at all.
Nothing tells that to us. The right solution to fix the duplication is
to move to OPP-v2 bindings, which allow us to create a single OPP
table node and refer to it from all the CPU nodes. Because in case of
imx platforms getting updated here, we use the old and some platforms
specific frequency tables, we have to duplicate it everywhere.

But looking from DT otherwise, all the device should anyway have all
the information required right in their node. That can be simplified
with things like phandle to opp-v2 node, but still everything needs to
be there. We shouldn't really rely on other CPU nodes to make it work.
That would be an incomplete definition of the hardware IMHO.

-- 
viresh
