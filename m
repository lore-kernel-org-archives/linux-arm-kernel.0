From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 29 Sep 2014 14:39:21 +0100
Subject: [PATCH v6 5/6] sched: replace capacity_factor by usage
In-Reply-To: <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
Message-ID: <54296109.7020205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/14 17:08, Vincent Guittot wrote:
> The scheduler tries to compute how many tasks a group of CPUs can handle by
> assuming that a task's load is SCHED_LOAD_SCALE and a CPU capacity is
> SCHED_CAPACITY_SCALE but the capacity_factor is hardly working for SMT system,
> it sometimes works for big cores but fails to do the right thing for little
> cores.
> 
> Below are two examples to illustrate the problem that this patch solves:
> 
> 1 - capacity_factor makes the assumption that max capacity of a CPU is
> SCHED_CAPACITY_SCALE and the load of a thread is always is
> SCHED_LOAD_SCALE. It compares the output of these figures with the sum
> of nr_running to decide if a group is overloaded or not.
> 
> But if the default capacity of a CPU is less than SCHED_CAPACITY_SCALE
> (640 as an example), a group of 3 CPUS will have a max capacity_factor
> of 2 ( div_round_closest(3x640/1024) = 2) which means that it will be
> seen as overloaded if we have only one task per CPU.
> 
> 2 - Then, if the default capacity of a CPU is greater than
> SCHED_CAPACITY_SCALE (1512 as an example), a group of 4 CPUs will have
> a capacity_factor of 4 (at max and thanks to the fix[0] for SMT system
> that prevent the apparition of ghost CPUs) but if one CPU is fully
> used by a rt task (and its capacity is reduced to nearly nothing), the
> capacity factor of the group will still be 4
> (div_round_closest(3*1512/1024) = 5).
> 
> So, this patch tries to solve this issue by removing capacity_factor
> and replacing it with the 2 following metrics :
> -The available CPU's capacity for CFS tasks which is the already used by
> load_balance.
> -The usage of the CPU by the CFS tasks. For the latter, I have
> re-introduced the utilization_avg_contrib which is in the range
> [0..SCHED_CPU_LOAD] whatever the capacity of the CPU is.

IMHO, this last sentence is misleading. The usage of a cpu can be
temporally unbounded (in case a lot of tasks have just been spawned on
this cpu, testcase: hackbench) but it converges very quickly towards a
value between [0..1024]. Your implementation is already handling this
case by capping usage to cpu_rq(cpu)->capacity_orig + 1 .
BTW, couldn't find the definition of SCHED_CPU_LOAD.

[...]
