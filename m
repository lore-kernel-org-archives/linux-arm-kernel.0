From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 26 Apr 2013 15:08:35 +0200
Subject: [PATCH 07/14] sched: agressively pack at wake/fork/exec
In-Reply-To: <1366910611-20048-8-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20130426130835.GA13964@dyad.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:23:23PM +0200, Vincent Guittot wrote:
> According to the packing policy, the scheduler can pack tasks at different
> step:
> -SCHED_PACKING_NONE level: we don't pack any task.
> -SCHED_PACKING_DEFAULT: we only pack small tasks at wake up when system is not
> busy.
> -SCHED_PACKING_FULL: we pack tasks at wake up until a CPU becomes full. During
> a fork or a exec, we assume that the new task is a full running one and we
> look for an idle CPU close to the buddy CPU.

This changelog is very short on explaining how it will go about achieving these
goals.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 98166aa..874f330 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3259,13 +3259,16 @@ static struct sched_group *
>  find_idlest_group(struct sched_domain *sd, struct task_struct *p,


So for packing into power domains, wouldn't you typically pick the busiest non-
full domain to fill from other non-full?

Picking the idlest non-full seems like it would generate a ping-pong or not
actually pack anything.
