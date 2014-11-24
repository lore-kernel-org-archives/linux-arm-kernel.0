From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 24 Nov 2014 15:24:00 +0100
Subject: [PATCH v9 05/10] sched: make scale_rt invariant with frequency
In-Reply-To: <20141121123559.GF23177@e105550-lin.cambridge.arm.com>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-6-git-send-email-vincent.guittot@linaro.org>
 <20141121123559.GF23177@e105550-lin.cambridge.arm.com>
Message-ID: <CAKfTPtAo3PzZ=-KtH-YS2nf9R9srMGAUJ2A2qkHrsPZmj18-Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2014 at 13:35, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Mon, Nov 03, 2014 at 04:54:42PM +0000, Vincent Guittot wrote:

[snip]

>> The average running time of RT tasks is used to estimate the remaining compute
>> @@ -5801,19 +5801,12 @@ static unsigned long scale_rt_capacity(int cpu)
>>
>>       total = sched_avg_period() + delta;
>>
>> -     if (unlikely(total < avg)) {
>> -             /* Ensures that capacity won't end up being negative */
>> -             available = 0;
>> -     } else {
>> -             available = total - avg;
>> -     }
>> +     used = div_u64(avg, total);
>
> I haven't looked through all the details of the rt avg tracking, but if
> 'used' is in the range [0..SCHED_CAPACITY_SCALE], I believe it should
> work. Is it guaranteed that total > 0 so we don't get division by zero?

static inline u64 sched_avg_period(void)
{
return (u64)sysctl_sched_time_avg * NSEC_PER_MSEC / 2;
}

>
> It does get a slightly more complicated if we want to figure out the
> available capacity at the current frequency (current < max) later. Say,
> rt eats 25% of the compute capacity, but the current frequency is only
> 50%. In that case get:
>
> curr_avail_capacity = (arch_scale_cpu_capacity() *
>   (arch_scale_freq_capacity() - (SCHED_SCALE_CAPACITY - scale_rt_capacity())))
>   >> SCHED_CAPACITY_SHIFT

You don't have to be so complicated but simply need to do:
curr_avail_capacity for CFS = (capacity_of(CPU) *
arch_scale_freq_capacity())  >> SCHED_CAPACITY_SHIFT

capacity_of(CPU) = 600 is the max available capacity for CFS tasks
once we have removed the 25% of capacity that is used by RT tasks
arch_scale_freq_capacity = 512 because we currently run at 50% of max freq

so curr_avail_capacity for CFS = 300

Vincent
>
> With numbers assuming arch_scale_cpu_capacity() = 800:
>
> curr_avail_capacity = 800 * (512 - (1024 - 758)) >> 10 = 200
>
> Which isn't actually that bad. Anyway, it isn't needed until we start
> invovling energy models.
>
>>
>> -     if (unlikely((s64)total < SCHED_CAPACITY_SCALE))
>> -             total = SCHED_CAPACITY_SCALE;
>> +     if (likely(used < SCHED_CAPACITY_SCALE))
>> +             return SCHED_CAPACITY_SCALE - used;
>>
>> -     total >>= SCHED_CAPACITY_SHIFT;
>> -
>> -     return div_u64(available, total);
>> +     return 1;
>>  }
>>
