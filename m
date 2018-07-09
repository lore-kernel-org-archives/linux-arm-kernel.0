From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 9 Jul 2018 11:24:01 -0700
Subject: [PATCH 1/2] Revert "tick: Prefer a lower rating device only if
 it's CPU local device"
In-Reply-To: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 8:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.
>
> The original issue was not because of incorrect checking of cpumask for
> both new and old tick device. It was incorrectly analysed was due to the
> misunderstanding of the comment and misinterpretation of the return
> value from tick_check_preferred. The main issue is with the clockevent
> driver that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

And verified to fix a regression on the 32-bit ARM platform mesion8b-odroidc1.

Thanks,

Kevin


> ---
>  kernel/time/tick-common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Hi Thomas,
>
> As mentioned in the other thread, this needs to be reverted. Sorry for
> the misunderstanding the original issue and producing wrong fix.
>
> Regards,
> Sudeep
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index b7005dd21ec1..14de3727b18e 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -277,8 +277,7 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
>          */
>         return !curdev ||
>                 newdev->rating > curdev->rating ||
> -              (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
> -               !tick_check_percpu(curdev, newdev, smp_processor_id()));
> +              !cpumask_equal(curdev->cpumask, newdev->cpumask);
>  }
>
>  /*
> --
> 2.7.4
>
