From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 11 Sep 2014 13:20:54 +0200
Subject: [PATCH v5 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140911100721.GT3190@worktop.ger.corp.intel.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
 <20140911100721.GT3190@worktop.ger.corp.intel.com>
Message-ID: <CAKfTPtDtw2kE9DtGB-ZHa=0+oWY+1-753eoRFDs=mz0qFuiwiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2014 12:07, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Aug 26, 2014 at 01:06:51PM +0200, Vincent Guittot wrote:
>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 18db43e..60ae1ce 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6049,6 +6049,14 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>                       return true;
>>       }
>>
>> +     /*
>> +      * The group capacity is reduced probably because of activity from other
>> +      * sched class or interrupts which use part of the available capacity
>> +      */
>> +     if ((sg->sgc->capacity_orig * 100) > (sgs->group_capacity *
>> +                             env->sd->imbalance_pct))
>> +             return true;
>> +
>>       return false;
>>  }
>
> This is unlikely to have worked as intended. You will never reach this,
> except on PowerPC >= 7. All other machines will have bailed at the
> !ASYM_PACKING check above this.

Ah yes, i miss that change while rebasing on rik patches. My use case
fall in this wider test now that we always select a busiest group
