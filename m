From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 3 Nov 2014 11:59:12 +0100
Subject: [PATCH v8 07/10] sched: replace capacity_factor by usage
In-Reply-To: <54572852.7040304@gmail.com>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
 <1414745252-4895-8-git-send-email-vincent.guittot@linaro.org>
 <54572852.7040304@gmail.com>
Message-ID: <CAKfTPtC64X+FoKXkVmNE=wntjzhK=P9F4N08a-WNGdan1oX65w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2014 08:01, Wanpeng Li <kernellwp@gmail.com> wrote:
> Hi Vincent,
> On 14/10/31 ??4:47, Vincent Guittot wrote:
>>
>> The scheduler tries to compute how many tasks a group of CPUs can handle
>> by
>> assuming that a task's load is SCHED_LOAD_SCALE and a CPU's capacity is
>> SCHED_CAPACITY_SCALE. group_capacity_factor divides the capacity of the
>> group
>> by SCHED_LOAD_SCALE to estimate how many task can run in the group. Then,
>> it
>> compares this value with the sum of nr_running to decide if the group is
>> overloaded or not. But the group_capacity_factor is hardly working for SMT
>>   system, it sometimes works for big cores but fails to do the right thing
>> for
>>   little cores.
>>
>> Below are two examples to illustrate the problem that this patch solves:
>>
>> 1- If the original capacity of a CPU is less than SCHED_CAPACITY_SCALE
>> (640 as an example), a group of 3 CPUS will have a max capacity_factor of
>> 2
>> (div_round_closest(3x640/1024) = 2) which means that it will be seen as
>> overloaded even if we have only one task per CPU.
>>
>> 2 - If the original capacity of a CPU is greater than SCHED_CAPACITY_SCALE
>> (1512 as an example), a group of 4 CPUs will have a capacity_factor of 4
>> (at max and thanks to the fix [0] for SMT system that prevent the
>> apparition
>
>
> What's the story of 'fix [0] for SMT system' here?

The [0] url has disappeared. please find it below:
[0] https://lkml.org/lkml/2013/8/28/194

Let me know if your need more explanation than my answer of your
previous question for the cover letter

Regards,
Vincent

>
> Regards,
> Wanpeng Li
>
>
>> of ghost CPUs) but if one CPU is fully used by rt tasks (and its capacity
>> is
>> reduced to nearly nothing), the capacity factor of the group will still be
>> 4
>> (div_round_closest(3*1512/1024) = 5 which is cap to 4 with [0]).
>>

[snip]
