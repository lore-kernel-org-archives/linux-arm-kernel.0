From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Sun, 25 May 2014 16:03:50 +0530
Subject: [PATCH v2 01/11] sched: fix imbalance flag reset
In-Reply-To: <1400860385-14555-2-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <5381C70E.3030605@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 05/23/2014 09:22 PM, Vincent Guittot wrote:
> The imbalance flag can stay set whereas there is no imbalance.
> 
> Let assume that we have 3 tasks that run on a dual cores /dual cluster system.
> We will have some idle load balance which are triggered during tick.
> Unfortunately, the tick is also used to queue background work so we can reach
> the situation where short work has been queued on a CPU which already runs a
> task. The load balance will detect this imbalance (2 tasks on 1 CPU and an idle
> CPU) and will try to pull the waiting task on the idle CPU. The waiting task is
> a worker thread that is pinned on a CPU so an imbalance due to pinned task is
> detected and the imbalance flag is set.
> Then, we will not be able to clear the flag because we have at most 1 task on
> each CPU but the imbalance flag will trig to useless active load balance
> between the idle CPU and the busy CPU.

Why do we do active balancing today when there is at-most 1 task on the
busiest cpu? Shouldn't we be skipping load balancing altogether? If we
do active balancing when the number of tasks = 1, it will lead to a ping
pong right?

Regards
Preeti U Murthy
