From: wangnan0@huawei.com (Wangnan (F))
Date: Mon, 26 Dec 2016 17:17:08 +0800
Subject: coresight: Problem caused by resetting enable_sink
Message-ID: <6598d4c2-bbfb-1792-d216-a15ab0e841e0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

I meet problems caused by your commit d52c9750f150 ('coresight:
reset "enable_sink" flag when need be'). Not only the one I
posted in the previous patch.

My use case is a simple 'perf record -e cs_etm// ls'. It works
properly before this commit, and failed when allocating aux buffer
after your commit. I can't fully understand your code, but the
problem I meet seems caused by inappropriately reseting sink.

My device is connected like this (use two etfs):

Core0--+
Core1--+-- funnel0 --> etf0
Core2--|
Core3--+

Core0--+
Core1--+-- funnel1 --> etf1
Core2--|
Core3--+

Before running perf, two etfs are activated using sysfs
enable_sink interface.

During etm_setup_aux, coresight_get_enabled_sink() finds
etf0 for core0, and automatically deactivates it.

For core1, coresight_get_enabled_sink() returns etf1.
However, etf1 is not on the link of core1, so following
coresight_build_path() fails.

I guess your commit is based on the assumption that all
sinks are in the patch for each cores. Like this:


Core0--+
Core1--+-- funnel0 --> etf0 ++
Core2--|                     |            +--- etr
Core3--+                     |            |
                              + replicator +
Core0--+                     |            |
Core1--+-- funnel1 --> etf1 ++            +--- etb
Core2--|
Core3--+

But it is not true, at least for some hisilicon board.

I have to revert your patch to make CoreSight on my board
work. Please reconsider this patch, or please give some
suggestion if you think I misunderstood your patch.

Thank you.
