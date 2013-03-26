From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 26 Mar 2013 15:03:41 +0100
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <1364302359.5053.21.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
Message-ID: <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2013 13:52, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
>> Look for an idle CPU close to the pack buddy CPU whenever possible.
>> The goal is to prevent the wake up of a CPU which doesn't share the
>> power
>> domain of the pack buddy CPU.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Morten Rasmussen <morten.rasmussen@arm.com>
>> ---
>>  kernel/sched/fair.c |   18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b636199..52a7736 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5455,7 +5455,25 @@ static struct {
>>
>>  static inline int find_new_ilb(int call_cpu)
>>  {
>> +       struct sched_domain *sd;
>>         int ilb = cpumask_first(nohz.idle_cpus_mask);
>> +       int buddy = per_cpu(sd_pack_buddy, call_cpu);
>> +
>> +       /*
>> +        * If we have a pack buddy CPU, we try to run load balance on
>> a CPU
>> +        * that is close to the buddy.
>> +        */
>> +       if (buddy != -1)
>> +               for_each_domain(buddy, sd) {
>> +                       if (sd->flags & SD_SHARE_CPUPOWER)
>> +                               continue;
>> +
>> +                       ilb = cpumask_first_and(sched_domain_span(sd),
>> +                                       nohz.idle_cpus_mask);
>> +
>> +                       if (ilb < nr_cpu_ids)
>> +                               break;
>> +               }
>
> /me hands you a fresh bucket of curlies, no reason to skimp on them.

ok

>
> But ha! here's your NO_HZ link.. but does the above DTRT and ensure
> that the ILB is a little core when possible?

The loop looks for an idle CPU as close as possible to the buddy CPU
and the buddy CPU is the 1st CPU has been chosen. So if your buddy is
a little and there is an idle little, the ILB will be this idle
little.

>
>
