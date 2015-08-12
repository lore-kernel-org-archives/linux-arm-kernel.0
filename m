From: john.stultz@linaro.org (John Stultz)
Date: Wed, 12 Aug 2015 13:00:53 -0700
Subject: [PATCH 2/2] arm64: VDSO: fix coarse clock monotonicity regression
In-Reply-To: <1438999403-5770-3-git-send-email-nathan_lynch@mentor.com>
References: <1438999403-5770-1-git-send-email-nathan_lynch@mentor.com>
 <1438999403-5770-3-git-send-email-nathan_lynch@mentor.com>
Message-ID: <CALAqxLVt43ntH04FJCTXujhtNQ8KAOcTSfyZ5TnKs=R7m2grNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 7:03 PM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
> Since 906c55579a63 ("timekeeping: Copy the shadow-timekeeper over the
> real timekeeper last") it has become possible on arm64 to:
>
> - Obtain a CLOCK_MONOTONIC_COARSE or CLOCK_REALTIME_COARSE timestamp
>   via syscall.
> - Subsequently obtain a timestamp for the same clock ID via VDSO which
>   predates the first timestamp (by one jiffy).
>
> This is because arm64's update_vsyscall is deriving the coarse time
> using the __current_kernel_time interface, when it should really be
> using the timekeeper object provided to it by the timekeeping core.
> It happened to work before only because __current_kernel_time would
> access the same timekeeper object which had been passed to
> update_vsyscall.  This is no longer the case.
>
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm64/kernel/vdso.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index ec37ab3f524f..97bc68f4c689 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -199,16 +199,15 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
>   */
>  void update_vsyscall(struct timekeeper *tk)
>  {
> -       struct timespec xtime_coarse;
>         u32 use_syscall = strcmp(tk->tkr_mono.clock->name, "arch_sys_counter");
>
>         ++vdso_data->tb_seq_count;
>         smp_wmb();
>
> -       xtime_coarse = __current_kernel_time();
>         vdso_data->use_syscall                  = use_syscall;
> -       vdso_data->xtime_coarse_sec             = xtime_coarse.tv_sec;
> -       vdso_data->xtime_coarse_nsec            = xtime_coarse.tv_nsec;
> +       vdso_data->xtime_coarse_sec             = tk->xtime_sec;
> +       vdso_data->xtime_coarse_nsec            = tk->tkr_mono.xtime_nsec >>
> +                                                       tk->tkr_mono.shift;
>         vdso_data->wtm_clock_sec                = tk->wall_to_monotonic.tv_sec;
>         vdso_data->wtm_clock_nsec               = tk->wall_to_monotonic.tv_nsec;
>

(Sorry for the slow response, I've been out on vacation).

If its worth anything now:
Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
