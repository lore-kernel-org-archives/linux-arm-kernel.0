From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 14:10:05 +0000
Subject: [PATCH v3 04/12] arm: vdso: enforce monotonic and realtime as
 inline
In-Reply-To: <20171027222531.57223-1-salyzyn@android.com>
References: <20171027222531.57223-1-salyzyn@android.com>
Message-ID: <20171030141004.n54obxkbmtfbzmra@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 03:25:28PM -0700, Mark Salyzyn wrote:
> Ensure monotonic and realtime are inline, small price to pay for
> high volume common request.

Does this make a noticeable difference on any workload?

What does this do to the binary size?

Thanks,
Mark.

> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Andrew Pinski <apinski@cavium.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> 
> v2:
> - split first CL into 4 of 7 pieces
> 
> v3:
> - rebase (unchanged)
> 
> ---
>  arch/arm/vdso/vgettimeofday.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
> index 5f596911bd53..71003a1997c4 100644
> --- a/arch/arm/vdso/vgettimeofday.c
> +++ b/arch/arm/vdso/vgettimeofday.c
> @@ -99,7 +99,7 @@ static notrace int do_monotonic_coarse(const struct vdso_data *vd,
>  
>  #ifdef CONFIG_ARM_ARCH_TIMER
>  
> -static notrace u64 get_ns(const struct vdso_data *vd)
> +static __always_inline notrace u64 get_ns(const struct vdso_data *vd)
>  {
>  	u64 cycle_delta;
>  	u64 cycle_now;
> @@ -115,7 +115,9 @@ static notrace u64 get_ns(const struct vdso_data *vd)
>  	return nsec;
>  }
>  
> -static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
> +/* Code size doesn't matter (vdso is 4k/16k/64k anyway) and this is faster. */
> +static __always_inline notrace int do_realtime(const struct vdso_data *vd,
> +					       struct timespec *ts)
>  {
>  	u64 nsecs;
>  	u32 seq;
> @@ -137,7 +139,8 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
>  	return 0;
>  }
>  
> -static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
> +static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
> +						struct timespec *ts)
>  {
>  	struct timespec tomono;
>  	u64 nsecs;
> -- 
> 2.15.0.rc2.357.g7e34df9404-goog
> 
