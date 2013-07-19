From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 19 Jul 2013 18:51:52 +0200
Subject: [PATCH 2/3] init/Kconfig: VIRT_CPU_ACCOUNTING_GEN: drop 64-bit
 requirement
In-Reply-To: <1372876601-23881-3-git-send-email-khilman@linaro.org>
References: <1372876601-23881-1-git-send-email-khilman@linaro.org>
 <1372876601-23881-3-git-send-email-khilman@linaro.org>
Message-ID: <20130719165150.GD21752@somewhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 11:36:40AM -0700, Kevin Hilman wrote:
> The 64-bit requirement can be removed after the conversion of the nsec
> granularity cputime to work on !64_BIT, which was done in commit
> 8c23b80e (cputime_nsecs: use math64.h for nsec resolution conversion
> helpers)
> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

So I finally sat down and checked all the use of cputime_t (I probably
missed some) to make sure that readers are safe against concurrent write
in 32 bits archs.

And everything looks ok expect perhaps fs/[compat]binfmt_elf*.c that doesn't
lock the signal struct before getting tsk->signal->cutime and stuff. But perhaps
it's safe for some reason, I'll look more carefully. And I also need to
check further itimers code.

But I think I pushed back the ARM support long enough now so it's time to
get this patch in. The above issues are mostly details that can be dealt
with separately.

Just one thing before we apply this. I haven't checked the arch/* potential
unsafe uses of cputime. So it would be nice to bring a new
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN. This won't require any specific arch
support, it would just be there to inform the arch developer, through the help
text, about the issue with cputime being u64 and resulting possible race.
So the guy can have a look at cputime_t uses in his arch before finally enabling
that config.

Also, of course check that arm is fine wrt. that and finally enable it :)

Thanks!


> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 2d9b831..e151022 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -325,7 +325,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
>  
>  config VIRT_CPU_ACCOUNTING_GEN
>  	bool "Full dynticks CPU time accounting"
> -	depends on HAVE_CONTEXT_TRACKING && 64BIT
> +	depends on HAVE_CONTEXT_TRACKING
>  	select VIRT_CPU_ACCOUNTING
>  	select CONTEXT_TRACKING
>  	help
> -- 
> 1.8.3
> 
