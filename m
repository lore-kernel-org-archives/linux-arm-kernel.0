From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 12 Feb 2016 16:45:03 -0500 (EST)
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602121639340.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Feb 2016, Arnd Bergmann wrote:

> In my randconfig tests, I came across a bug that involves several
> components:
> 
> * gcc-4.9 through at least 5.3
> * CONFIG_GCOV_PROFILE_ALL enabling -fprofile-arcs for all files
> * CONFIG_PROFILE_ALL_BRANCHES overriding every if()
> * The optimized implementation of do_div() that tries to
>   replace a library call with an division by multiplication
> * code in drivers/media/dvb-frontends/zl10353.c doing
> 
>         u32 adc_clock = 450560; /* 45.056 MHz */
>         if (state->config.adc_clock)
>                 adc_clock = state->config.adc_clock;
>         do_div(value, adc_clock);
> 
> In this case, gcc fails to determine whether the divisor
> in do_div() is __builtin_constant_p(). In particular, it
> concludes that __builtin_constant_p(adc_clock) is false, while
> __builtin_constant_p(!!adc_clock) is true.
> 
> That in turn throws off the logic in do_div() that also uses
> __builtin_constant_p(), and instead of picking either the
> constant- optimized division, and the code in ilog2() that uses
> __builtin_constant_p() to figure out whether it knows the answer at
> compile time. The result is a link error from failing to find
> multiple symbols that should never have been called based on
> the __builtin_constant_p():
> 
> dvb-frontends/zl10353.c:138: undefined reference to `____ilog2_NaN'
> dvb-frontends/zl10353.c:138: undefined reference to `__aeabi_uldivmod'
> ERROR: "____ilog2_NaN" [drivers/media/dvb-frontends/zl10353.ko] undefined!
> ERROR: "__aeabi_uldivmod" [drivers/media/dvb-frontends/zl10353.ko] undefined!
> 
> This patch avoids the problem by changing __trace_if() to check
> whether the condition is known at compile-time to be nonzero, rather
> than checking whether it is actually a constant.
> 
> I see this one link error in roughly one out of 1600 randconfig builds
> on ARM, and the patch fixes all known instances.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ab3c9c686e22 ("branch tracer, intel-iommu: fix build with CONFIG_BRANCH_TRACER=y")

It is certainly a worthwhile workaround if it solves all the known 
cases.

Acked-by: Nicolas Pitre <nico@linaro.org>

This trick doesn't work with the test case I produced to demonstrate 
this bug though.  So we might be affected again in the future, or maybe 
not if we're lucky.


> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index b5acbb404854..b5ff9881bef8 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -148,7 +148,7 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>   */
>  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>  #define __trace_if(cond) \
> -	if (__builtin_constant_p((cond)) ? !!(cond) :			\
> +	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
>  	({								\
>  		int ______r;						\
>  		static struct ftrace_branch_data			\
> -- 
> 2.7.0
> 
> 
