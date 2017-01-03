From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 3 Jan 2017 11:34:02 -0700
Subject: coresight: Problem caused by resetting enable_sink
In-Reply-To: <6598d4c2-bbfb-1792-d216-a15ab0e841e0@huawei.com>
References: <6598d4c2-bbfb-1792-d216-a15ab0e841e0@huawei.com>
Message-ID: <20170103183402.GA8689@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 05:17:08PM +0800, Wangnan (F) wrote:
> Hi Mathieu,

Hello Wang,

> 
> I meet problems caused by your commit d52c9750f150 ('coresight:
> reset "enable_sink" flag when need be'). Not only the one I
> posted in the previous patch.
> 
> My use case is a simple 'perf record -e cs_etm// ls'. It works
> properly before this commit, and failed when allocating aux buffer
> after your commit. I can't fully understand your code, but the
> problem I meet seems caused by inappropriately reseting sink.
> 
> My device is connected like this (use two etfs):
> 
> Core0--+
> Core1--+-- funnel0 --> etf0
> Core2--|
> Core3--+
> 
> Core0--+
> Core1--+-- funnel1 --> etf1
> Core2--|
> Core3--+

Yes, supporting this topology is a problem I long predicted.

> 
> Before running perf, two etfs are activated using sysfs
> enable_sink interface.
> 
> During etm_setup_aux, coresight_get_enabled_sink() finds
> etf0 for core0, and automatically deactivates it.
> 
> For core1, coresight_get_enabled_sink() returns etf1.
> However, etf1 is not on the link of core1, so following
> coresight_build_path() fails.
> 
> I guess your commit is based on the assumption that all
> sinks are in the patch for each cores. Like this:
> 
> 
> Core0--+
> Core1--+-- funnel0 --> etf0 ++
> Core2--|                     |            +--- etr
> Core3--+                     |            |
>                              + replicator +
> Core0--+                     |            |
> Core1--+-- funnel1 --> etf1 ++            +--- etb
> Core2--|
> Core3--+
> 

Correct - the entire solution is based on the assumption that all cores use the
same sink.  When I wrote the driver not a single system enacted a topology where
cores wouldn't use the same sink for a trace session. 

> But it is not true, at least for some hisilicon board.
> 
> I have to revert your patch to make CoreSight on my board
> work. Please reconsider this patch, or please give some
> suggestion if you think I misunderstood your patch.

You understood the patch corretly but simply reverting it isn't the solution.

Supporting a system where different sinks are used won't be easy - a lot of
things need to be adjusted.  The first and critical part that comes to mind is
the mechanic that fetches the sink definition from the cmd line when using the
perf interface (if I remember correctly the bison/flex parser can handle
multiple sink definition).  From there everything needs to be tailored to handle
more than one sink. 

You will likely have more questions... Get back to me and I'll be happy to help.

Regards,
Mathieu

> 
> Thank you.
> 
> 
