From: johnstul@us.ibm.com (John Stultz)
Date: Fri, 09 Nov 2012 15:02:53 -0800
Subject: [PATCH 02/11] time: convert arch_gettimeoffset to a pointer
In-Reply-To: <1352408516-21988-4-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <509D8B9D.40608@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2012 01:01 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Currently, whenever CONFIG_ARCH_USES_GETTIMEOFFSET is enabled, each
> arch core provides a single implementation of arch_gettimeoffset(). In
> many cases, different sub-architectures, different machines, or
> different timer providers exist, and so the arch ends up implementing
> arch_gettimeoffset() as a call-through-pointer anyway. Examples are
> ARM, Cris, M68K, and it's arguable that the remaining architectures,
> M32R and Blackfin, should be doing this anyway.
>
> Modify arch_gettimeoffset so that it itself is a function pointer, which
> the arch initializes. This will allow later changes to move the
> initialization of this function into individual machine support or timer
> drivers. This is particularly useful for code in drivers/clocksource
> which should rely on an arch-independant mechanism to register their
> implementation of arch_gettimeoffset().
>
> This patch also converts the Cris architecture to set arch_gettimeoffset
> directly to the final implementation in time_init(), because Cris already
> had separate time_init() functions per sub-architecture. M68K and ARM
> are converted to set arch_gettimeoffset the final implementation in later
> patches, because they already have function pointers in place for this
> purpose.
[snip]
> diff --git a/include/linux/time.h b/include/linux/time.h
> index 4d358e9..05e32a7 100644
> --- a/include/linux/time.h
> +++ b/include/linux/time.h
> @@ -142,9 +142,7 @@ void timekeeping_inject_sleeptime(struct timespec *delta);
>    * finer then tick granular time.
>    */
>   #ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
> -extern u32 arch_gettimeoffset(void);
> -#else
> -static inline u32 arch_gettimeoffset(void) { return 0; }
> +extern u32 (*arch_gettimeoffset)(void);
>   #endif
>
>   extern void do_gettimeofday(struct timeval *tv);
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index e424970..9d00ace 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -140,6 +140,20 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
>   }
>
>   /* Timekeeper helper functions. */
> +
> +#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
> +u32 (*arch_gettimeoffset)(void);
> +
> +u32 gettimeoffset(void)
> +{
> +	if (likely(arch_gettimeoffset))
> +		return arch_gettimeoffset();
> +	return 0;
> +}
> +#else
> +static inline u32 gettimeoffset(void) { return 0; }
> +#endif

Minor nit-pick here, but get_arch_timeoffset() or get_arch_tickoffset() 
might be clearer, as gettimeoffset() sounds a little generic, and could 
be confused with the higher-level timekeeping_inject_offset() call.

Otherwise this looks ok to me (disclaimer: I'm back from a 4 week leave, 
so I may not have my brain plugged in all the way yet).

thanks
-john
