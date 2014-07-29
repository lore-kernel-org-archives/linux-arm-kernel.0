From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 29 Jul 2014 09:40:51 +0200
Subject: [PATCH v4 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <53D699BE.90208@redhat.com>
References: <1406569906-9763-1-git-send-email-vincent.guittot@linaro.org>
 <1406569906-9763-9-git-send-email-vincent.guittot@linaro.org>
 <53D699BE.90208@redhat.com>
Message-ID: <CAKfTPtBCE57m8MsKVr=ww18g44ive3NVWRHVczfKgkxN6zao4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 July 2014 20:43, Rik van Riel <riel@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 07/28/2014 01:51 PM, Vincent Guittot wrote:
>> If the CPU is used for handling lot of IRQs, trig a load balance to
>> check if it's worth moving its tasks on another CPU that has more
>> capacity.
>>
>> As a sidenote, this will note generate more spurious ilb because we
>> already trig an ilb if there is more than 1 busy cpu. If this cpu
>> is the only one that has a task, we will trig the ilb once for
>> migrating the task.
>>
>> The nohz_kick_needed function has been cleaned up a bit while
>> adding the new test
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org> ---
>> kernel/sched/fair.c | 69
>> +++++++++++++++++++++++++++++++++++++---------------- 1 file
>> changed, 49 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
>> 6843016..1cde8dd 100644 --- a/kernel/sched/fair.c +++
>> b/kernel/sched/fair.c @@ -5969,6 +5969,14 @@ static bool
>> update_sd_pick_busiest(struct lb_env *env, return true; }
>>
>> +     /* +     * The group capacity is reduced probably because of
>> activity from other +  * sched class or interrupts which use part
>> of the available capacity +    */ +   if ((sg->sgc->capacity_orig *
>> 100) > (sgs->group_capacity * +                               env->sd->imbalance_pct)) +
>> return true; + return false; }
>
> Isn't this already reflected in avg_load, by having avg_load increase
> due to the capacity decreasing when a cpu is busy with non-CFS loads?

Yes, the avg_load should probably increase but it doesn't mean that it
will be selected for a load balancing.

>
> Also, this part of update_sd_pick_busiest will not be reached in the
> !SD_ASYM_PACKING case once my patch is applied, so this is a small
> conflict between our series :)

yes, this will conflict with your change but the conflict should be
obvious to solve as it only adds a new condition for picking the group

>
> - --
> All rights reversed
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iQEcBAEBAgAGBQJT1pm+AAoJEM553pKExN6DysEH/1/s2dY0EWM4mVctRAcyASc+
> qD5yQgDZEbnIzuUldtTRNwlAxHSaexLI7oF418RAaUV3oue+OQIesJPhKDVrR2+J
> fLo4fhtutuF1SHJ5Zo2fiGBIUI+GuLspT2fXiG2UxXQXtYioVdDeB+cjo6H3xQ3D
> R2hR+WeSsLznwFhRnufI1neleIRpqk/Nw1wfdXCyE03kM478rCQjlygMUx6eqURn
> jblr7GY7jmtzhYFPY9qnE0za/WHWUVAf4RXSjCcuYwZqdhbzmHPKpJyiC3cl9XGz
> kNzAjqVzvSyCBblaOnJfrRyCWmBdatp5eZQCzZK9/l+YpbkkzQJNlUMAAVV1eNw=
> =qD2A
> -----END PGP SIGNATURE-----
