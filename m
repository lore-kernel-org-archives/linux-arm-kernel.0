From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 6 Mar 2014 16:42:13 +0800
Subject: [RFC 6/6] sched: ARM: create a dedicated scheduler topology table
In-Reply-To: <5317A77C.8020501@arm.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <1394003906-11630-7-git-send-email-vincent.guittot@linaro.org>
 <5317A77C.8020501@arm.com>
Message-ID: <CAKfTPtCDoLCxnud8OgUTWzUu8SNQv7e36Z_85=-A6j0zveNkuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2014 06:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 05/03/14 07:18, Vincent Guittot wrote:
>> Create a dedicated topology table for ARM which will create new level to
>> differentiate CPUs that can or not powergate independantly from others.
>>
>> The patch gives an example of how to add domain that will take advantage of
>> SD_SHARE_POWERDOMAIN.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

[snip]

>>
>>       parse_dt_topology();
>> +
>> +     /* Set scheduler topology descriptor */
>> +     set_sched_topology();
>>   }
>>
>
> How about the core scheduler provides an interface set_sched_topology()
> instead of each arch has its own __init function? Sketched out below
> for ARM.

yes, i will add it

>
> -- >8 --
> Subject: [PATCH] sched: set_sched_topology() as an interface of core scheduler
>
> ---
>  arch/arm/kernel/topology.c | 7 +------
>  include/linux/sched.h      | 2 +-
>  kernel/sched/core.c        | 5 +++++
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ae8ffbc..89d5592 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -284,11 +284,6 @@ static struct sched_domain_topology_level arm_topology[] = {
>         { NULL, },
>  };
>
> -static void __init set_sched_topology(void)
> -{
> -       sched_domain_topology = arm_topology;
> -}
> -
>  /*
>   * init_cpu_topology is called at boot when only one cpu is running
>   * which prevent simultaneous write access to cpu_topology array
> @@ -314,5 +309,5 @@ void __init init_cpu_topology(void)
>         parse_dt_topology();
>
>         /* Set scheduler topology descriptor */
> -       set_sched_topology();
> +       set_sched_topology(arm_topology);
>  }
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8831413..fefd4e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -998,7 +998,7 @@ struct sched_domain_topology_level {
>  #endif
>  };
>
> -extern struct sched_domain_topology_level *sched_domain_topology;
> +extern void set_sched_topology(struct sched_domain_topology_level *tl);
>
>  #ifdef CONFIG_SCHED_DEBUG
>  # define SD_INIT_NAME(type)            .name = #type
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b4fb0df..a748c92 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6105,6 +6105,11 @@ static struct sched_domain_topology_level default_topology[] = {
>
>  struct sched_domain_topology_level *sched_domain_topology = default_topology;
>
> +void set_sched_topology(struct sched_domain_topology_level *tl)
> +{
> +       sched_domain_topology = tl;
> +}
> +
>  #define for_each_sd_topology(tl)                       \
>         for (tl = sched_domain_topology; tl->mask; tl++)
>
> --
> 1.8.3.2
>
>
>
>
>
