From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 3 Oct 2014 09:24:23 +0200
Subject: [PATCH v6 5/6] sched: replace capacity_factor by usage
In-Reply-To: <20141002165745.GA28662@e103034-lin>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
 <20141002165745.GA28662@e103034-lin>
Message-ID: <CAKfTPtA5XTwT0fTqXZJWWwfUQ8SfVxiqmQwSWqFKpbb1XpriRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2014 18:57, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Tue, Sep 23, 2014 at 05:08:04PM +0100, Vincent Guittot wrote:
>> Below are two examples to illustrate the problem that this patch solves:
>>
>> 1 - capacity_factor makes the assumption that max capacity of a CPU is
>> SCHED_CAPACITY_SCALE and the load of a thread is always is
>> SCHED_LOAD_SCALE. It compares the output of these figures with the sum
>> of nr_running to decide if a group is overloaded or not.
>>
>> But if the default capacity of a CPU is less than SCHED_CAPACITY_SCALE
>> (640 as an example), a group of 3 CPUS will have a max capacity_factor
>> of 2 ( div_round_closest(3x640/1024) = 2) which means that it will be
>> seen as overloaded if we have only one task per CPU.
>
> I did some testing on TC2 which has the setup you describe above on the
> A7 cluster when the clock-frequency property is set in DT. The two A15s
> have max capacities above 1024. When using sysbench with five threads I
> still get three tasks on the two A15s and two tasks on the three A7
> leaving one cpu idle (on average).
>
> Using cpu utilization (usage) does correctly identify the A15 cluster as
> overloaded and it even gets as far as selecting the A15 running two
> tasks as the source cpu in load_balance(). However, load_balance() bails
> out without pulling the task due to calculate_imbalance() returning a
> zero imbalance. calculate_imbalance() bails out just before the hunk you
> changed due to comparison of the sched_group avg_loads. sgs->avg_load is
> basically the sum of load in the group divided by its capacity. Since
> load isn't scaled the avg_load of the overloaded A15 group is slightly
> _lower_ than the partially idle A7 group. Hence calculate_imbalance()
> bails out, which isn't what we want.
>
> I think we need to have a closer look at the imbalance calculation code
> and any other users of sgs->avg_load to get rid of all code making
> assumptions about cpu capacity.

We already had this discussion during the review of a previous version
https://lkml.org/lkml/2014/6/3/422
and my answer has not changed; This patch is necessary to solve the 1
task per CPU issue of the HMP system but is not enough. I have a patch
for solving the imbalance calculation issue and i have planned to send
it once this patch will be in a good shape for being accepted by
Peter.

I don't want to mix this patch and the next one because there are
addressing different problem: this one is how evaluate the capacity of
a system and detect when a group is overloaded and the next one will
handle the case when the balance of the system can't rely on the
average load figures of the group because we have a significant
capacity difference between groups. Not that i haven't specifically
mentioned HMP for the last patch because SMP system can also take
advantage of it

Regards,
Vincent

>
> Morten
