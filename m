From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 4 Jan 2018 15:56:32 -0500 (EST)
Subject: [PATCH v2 0/8] ARM: sun9i: SMP support with Multi-Cluster Power
 Management
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <nycvar.YSQ.7.76.1801041517410.3310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jan 2018, Chen-Yu Tsai wrote:

> Nicolas mentioned that the MCPM framework is likely overkill in our
> case [4]. However the framework does provide cluster/core state tracking
> and proper sequencing of cache related operations. We could rework
> the code to use standard smp_ops, but I would like to actually get
> a working version in first.
> 
> [...] For now however I'm using a
> dedicated single thread workqueue. CPU and cluster power off work is
> queued from the .{cpu,cluster}_powerdown_prepare callbacks. This solution
> is somewhat heavy, as I have a total of 10 static work structs. It might
> also be a bit racy, as nothing prevents the system from bringing a core
> back before the asynchronous work shuts it down. This would likely
> happen under a heavily loaded system with a scheduler that brings cores
> in and out of the system frequently. In simple use-cases it performs OK.

If you know up front your code is racy then this doesn't fully qualify 
as a "working version". Furthermore you're trading custom cluster/core 
state tracking for workqueue handling which doesn't look like a winning 
tradeoff to me. Especially given you can't have asynchronous CPU wakeups 
in hardware from an IRQ to deal with then the state tracking becomes 
very simple.

If you hook into struct smp_operations directly, you'll have direct 
access to both .cpu_die and .cpu_kill methods which are executed on the 
target CPU and on a different CPU respectively, which is exactly what 
you need. Those calls are already serialized with .smp_boot_secondary so 
you don't have to worry about races. The only thing you need to protect 
against races is your cluster usage count. Your code will end up being 
simpler than what you have now. See arch/arm/mach-hisi/platmcpm.c for 
example.


Nicolas
