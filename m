From: john.stultz@linaro.org (John Stultz)
Date: Wed, 12 Aug 2015 13:00:04 -0700
Subject: [PATCH v2] ARM: VDSO: fix coarse clock monotonicity regression
In-Reply-To: <1439221592-31875-1-git-send-email-nathan_lynch@mentor.com>
References: <1438999403-5770-1-git-send-email-nathan_lynch@mentor.com>
 <1439221592-31875-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <CALAqxLUxishMSb3A+PR_W0bSeFD9tWyETKM=Senk1_9A9GR2EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 8:46 AM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
> Since 906c55579a63 ("timekeeping: Copy the shadow-timekeeper over the
> real timekeeper last") it has become possible on ARM to:

Apologies I didn't catch that the core change caused a regression for
ARM. Though fixing the ARM vdso logic in this way is a good idea to
avoid future problems.


> - Obtain a CLOCK_MONOTONIC_COARSE or CLOCK_REALTIME_COARSE timestamp
>   via syscall.
> - Subsequently obtain a timestamp for the same clock ID via VDSO which
>   predates the first timestamp (by one jiffy).
>
> This is because ARM's update_vsyscall is deriving the coarse time
> using the __current_kernel_time interface, when it should really be
> using the timekeeper object provided to it by the timekeeping core.
> It happened to work before only because __current_kernel_time would
> access the same timekeeper object which had been passed to
> update_vsyscall.  This is no longer the case.
>
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>
> Changes since v1:
> - Add u32 cast to nsec calculation.
>
>  arch/arm/kernel/vdso.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index efe17dd9b921..54a5aeab988d 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -296,7 +296,6 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
>   */
>  void update_vsyscall(struct timekeeper *tk)
>  {
> -       struct timespec xtime_coarse;
>         struct timespec64 *wtm = &tk->wall_to_monotonic;
>
>         if (!cntvct_ok) {
> @@ -308,10 +307,10 @@ void update_vsyscall(struct timekeeper *tk)
>
>         vdso_write_begin(vdso_data);
>
> -       xtime_coarse = __current_kernel_time();
>         vdso_data->tk_is_cntvct                 = tk_is_cntvct(tk);
> -       vdso_data->xtime_coarse_sec             = xtime_coarse.tv_sec;
> -       vdso_data->xtime_coarse_nsec            = xtime_coarse.tv_nsec;
> +       vdso_data->xtime_coarse_sec             = tk->xtime_sec;
> +       vdso_data->xtime_coarse_nsec            = (u32)(tk->tkr_mono.xtime_nsec >>
> +                                                       tk->tkr_mono.shift);
>         vdso_data->wtm_clock_sec                = wtm->tv_sec;
>         vdso_data->wtm_clock_nsec               = wtm->tv_nsec;

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
