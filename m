From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Oct 2017 15:12:17 +0100
Subject: [PATCH v3] arm64: acpi/gtdt: validate CNTFRQ after having enabled
 the frame
In-Reply-To: <20170901103533.8970-1-ard.biesheuvel@linaro.org>
References: <20170901103533.8970-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu97WoJCXqxQPvdJDavuMF6LZbrpFYb1H+Q3BUw8wqp0dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2017 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The ACPI GTDT code validates the CNTFRQ field of each MMIO timer
> frame against the CNTFRQ system register of the current CPU, to
> ensure that they are equal, which is mandated by the architecture.
>
> However, reading the CNTFRQ field of a frame is not possible until
> the RFRQ bit in the frame's CNTACRn register is set, and doing so
> before that willl produce the following error:
>
>   arch_timer: [Firmware Bug]: CNTFRQ mismatch: frame @ 0x00000000e0be0000: (0x00000000), CPU: (0x0ee6b280)
>   arch_timer: Disabling MMIO timers due to CNTFRQ mismatch
>   arch_timer: Failed to initialize memory-mapped timer.
>
> The reason is that the CNTFRQ field is RES0 if access is not enabled.
>
> So move the validation of CNTFRQ into the loop that iterates over the
> timers to find the best frame, but defer it until after we have selected
> the best frame, which should also have enabled the RFRQ bit.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: - preserve existing logic as much as possible wrt verifying all frames of
>       all timers before selecting a suitable one
>

Ping?


>  drivers/clocksource/arm_arch_timer.c | 38 +++++++++++---------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 72bbfccef113..30071cdea846 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1264,10 +1264,6 @@ arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
>
>         iounmap(cntctlbase);
>
> -       if (!best_frame)
> -               pr_err("Unable to find a suitable frame in timer @ %pa\n",
> -                       &timer_mem->cntctlbase);
> -
>         return best_frame;
>  }
>
> @@ -1368,6 +1364,8 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
>
>         frame = arch_timer_mem_find_best_frame(timer_mem);
>         if (!frame) {
> +               pr_err("Unable to find a suitable frame in timer @ %pa\n",
> +                       &timer_mem->cntctlbase);
>                 ret = -EINVAL;
>                 goto out;
>         }
> @@ -1416,7 +1414,7 @@ arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
>  static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>  {
>         struct arch_timer_mem *timers, *timer;
> -       struct arch_timer_mem_frame *frame;
> +       struct arch_timer_mem_frame *frame, *best_frame = NULL;
>         int timer_count, i, ret = 0;
>
>         timers = kcalloc(platform_timer_count, sizeof(*timers),
> @@ -1428,14 +1426,6 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>         if (ret || !timer_count)
>                 goto out;
>
> -       for (i = 0; i < timer_count; i++) {
> -               ret = arch_timer_mem_verify_cntfrq(&timers[i]);
> -               if (ret) {
> -                       pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
> -                       goto out;
> -               }
> -       }
> -
>         /*
>          * While unlikely, it's theoretically possible that none of the frames
>          * in a timer expose the combination of feature we want.
> @@ -1444,12 +1434,26 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
>                 timer = &timers[i];
>
>                 frame = arch_timer_mem_find_best_frame(timer);
> -               if (frame)
> -                       break;
> +               if (!best_frame)
> +                       best_frame = frame;
> +
> +               ret = arch_timer_mem_verify_cntfrq(timer);
> +               if (ret) {
> +                       pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
> +                       goto out;
> +               }
> +
> +               if (!best_frame) /* implies !frame */
> +                       /*
> +                        * Only complain about missing suitable frames if we
> +                        * haven't already found one in a previous iteration.
> +                        */
> +                       pr_err("Unable to find a suitable frame in timer @ %pa\n",
> +                               &timer->cntctlbase);
>         }
>
> -       if (frame)
> -               ret = arch_timer_mem_frame_register(frame);
> +       if (best_frame)
> +               ret = arch_timer_mem_frame_register(best_frame);
>  out:
>         kfree(timers);
>         return ret;
> --
> 2.11.0
>
