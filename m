From: davem@davemloft.net (David Miller)
Date: Thu, 13 Sep 2018 09:07:12 -0700 (PDT)
Subject: [PATCH] knav: qmss: Introduce queue descriptors monitor
In-Reply-To: <20180911211549.12092-1-gomonovych@gmail.com>
References: <20180911211549.12092-1-gomonovych@gmail.com>
Message-ID: <20180913.090712.1849966692069488441.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasyl Gomonovych <gomonovych@gmail.com>
Date: Tue, 11 Sep 2018 23:15:47 +0200

> Monitor and record available descriptors in knav_qmss queues
> Get amount of available descriptors in free-descriptor queue
> base on event-triggered RX traffic.
> Also monitor free-descriptor queue base on periodic time interval
> in kernel thread.
> To start monitoring available descriptors in queue earlyi,
> module parameters, enable start monitoring in boottime
> 
> This queue descriptor monitor helps debugging starvation issue.
> The monitor should help debug queue under traffic pressure
> and can describe the shape of this pressure when a queue
> faced descriptors starvation.
> Monitor helpful for IP blocks which do not have dedicated
> descriptor starvation interrupt like RapidIO IP.
> 
> Registration and enable file in debugfs hierarchy
> 
> |-/sys/kernel/debug
> |-- knav_qmssm_soc:hwqueue at 2a40000
> |   |-- 8710
> |   |   |-- buffer_size
> |   |   |-- enable
> |   |   |-- monitor_stats
> |   |   -- unregister
> 
> ---
> 
> The current implementation is the first iteration
> and require additional work.
> By this patch I would like to know does this could be
> helpful for other components and continue my work in a right way.
> 
> Signed-off-by: Vasyl Gomonovych <vasyl.gomonovych@nokia.com>

This is way over engineered for just keeping some statistics around.

Just have a periodic timer or a workqueue that does the necessary
sampling.
