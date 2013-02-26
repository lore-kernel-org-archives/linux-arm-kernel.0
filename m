From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Tue, 26 Feb 2013 16:21:56 +0100
Subject: [RFC/PATCH 4/5] cputime: use do_div() for nsec resolution
 conversion helpers
In-Reply-To: <87621lo4ly.fsf@linaro.org>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
 <1361389302-11968-5-git-send-email-khilman@linaro.org>
 <20130221175857.GB14256@danjae.linux.parc55>
 <87621lo4ly.fsf@linaro.org>
Message-ID: <CAFTL4hxtCUs86uy7d5EWam9Usz4BjLFciy0faStQH=uhFQjYVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/21 Kevin Hilman <khilman@linaro.org>:
> From a8a0a8b8b12512a7f862ade459cd88d2b48e2bf3 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@linaro.org>
> Date: Thu, 14 Feb 2013 11:27:36 -0800
> Subject: [PATCH 4/5] cputime: use do_div() for nsec resolution conversion
>  helpers
>
> For the nsec resolution conversions to be useful on non 64-bit
> architectures, do_div() needs to be used for the 64-bit divisions.
>
> Special thanks to Namhyung Kim for pointing out omissions of the
> __force attribute in an earlier version.
>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  include/asm-generic/cputime_nsecs.h | 51 +++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/include/asm-generic/cputime_nsecs.h b/include/asm-generic/cputime_nsecs.h
> index b6485ca..d4944c9 100644
> --- a/include/asm-generic/cputime_nsecs.h
> +++ b/include/asm-generic/cputime_nsecs.h
> @@ -24,13 +24,17 @@ typedef u64 __nocast cputime64_t;
>  /*
>   * Convert cputime <-> jiffies (HZ)
>   */
> -#define cputime_to_jiffies(__ct)       \
> -       ((__force u64)(__ct) / (NSEC_PER_SEC / HZ))
> +static inline u64 cputime_to_jiffies(const cputime_t ct)
> +{
> +       u64 __ct = (__force u64) ct;
> +
> +       do_div(__ct, NSEC_PER_SEC / HZ);

So, when you don't need the remainder, could you please rather use
div_u64() ? It defaults to use do_div() anyway if the arch doesn't
override it. And none does apparently yet. But at least it paves the
way for further optimizations. And you can directly return the result.

Also, how about:

#define cputime_div(cputime, divisor)  div_u64((__force u64)cputime, divisor)

Thanks.
