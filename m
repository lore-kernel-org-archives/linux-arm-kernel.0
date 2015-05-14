From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 14 May 2015 13:31:32 +0200
Subject: [PATCH] arm: topology: fix capacity calculation on SMP SoCs
In-Reply-To: <1431549503-11799-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1431549503-11799-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <CAKfTPtDONGLyMO_4qmzmj2Q4AVHyvy2HJb4uuGnueYVPsM213A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorge,

On 13 May 2015 at 22:38, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> This commit sets the capacity of the average CPU in SMP systems to
> SCHED_CAPACITY_SCALE.
>
> Ignoring the condition "min_capacity==max_capacity" causes the function
> update_cpu_capacity( .. ) to generate out of range values [1]. This is
> because the default value of middle_capacity is used in the final
> calculation instead of a valid scaling factor.
>
> Incidentally, when out of range values are generated and if
> SCHED_FEAT(ARCH_POWER, true), the load balancing algorithm makes the
> wrong decisions typically overallocating work on one of the cores
> while leaving the others unused.

Have you got an example ?

>
> [1] val > SCHED_CAPACITY_SCALE
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm/kernel/topology.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 08b7847..509bc9b 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -137,14 +137,14 @@ static void __init parse_dt_topology(void)
>                 cpu_capacity(cpu) = capacity;
>         }
>
> -       /* If min and max capacities are equals, we bypass the update of the
> -        * cpu_scale because all CPUs have the same capacity. Otherwise, we
> -        * compute a middle_capacity factor that will ensure that the capacity
> +       /* Compute a middle_capacity factor that will ensure that the capacity
>          * of an 'average' CPU of the system will be as close as possible to
>          * SCHED_CAPACITY_SCALE, which is the default value, but with the
>          * constraint explained near table_efficiency[].
>          */
> -       if (4*max_capacity < (3*(max_capacity + min_capacity)))
> +       if (min_capacity == max_capacity)
> +               middle_capacity = min_capacity >> SCHED_CAPACITY_SHIFT;
> +       else if (4*max_capacity < (3*(max_capacity + min_capacity)))

if min_capacity == max_capacity then the condition 4*max_capacity <
(3*(max_capacity + min_capacity)) is true and
middle_capacity = (min_capacity + max_capacity) >>
(SCHED_CAPACITY_SHIFT+1) = 2*min_capacity >> (SCHED_CAPACITY_SHIFT+1)
so middle capacity = min_capacity >> SCHED_CAPACITY_SHIFT

I don't see what your change does that is not already done by current code

Regards,
Vincent


>                 middle_capacity = (min_capacity + max_capacity)
>                                 >> (SCHED_CAPACITY_SHIFT+1);
>         else
> --
> 2.1.4
>
