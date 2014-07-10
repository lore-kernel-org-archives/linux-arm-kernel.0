From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 10 Jul 2014 15:16:46 +0200
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140710131646.GB3935@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:40PM +0200, Vincent Guittot wrote:
> This reverts commit f5f9739d7a0ccbdcf913a0b3604b134129d14f7e.
> 
> We are going to use runnable_avg_sum and runnable_avg_period in order to get
> the utilization of the CPU. This statistic includes all tasks that run the CPU
> and not only CFS tasks.

But this rq->avg is not the one that is migration aware, right? So why
use this?

We already compensate cpu_capacity for !fair tasks, so I don't see why
we can't use the migration aware one (and kill this one as Yuyang keeps
proposing) and compensate with the capacity factor.
