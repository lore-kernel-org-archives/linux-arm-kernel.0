From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Apr 2014 11:59:25 -0400 (EDT)
Subject: [PATCH] ARM: fix do_div() bug in big-endian systems
In-Reply-To: <1397211384-2962-1-git-send-email-luxiangyu@huawei.com>
References: <1397211384-2962-1-git-send-email-luxiangyu@huawei.com>
Message-ID: <alpine.LFD.2.11.1404141148480.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Lu Xiangyu wrote:

> From: Xiangyu Lu <luxiangyu@huawei.com>
> 
> In big-endian systems, "%1" get the most significant part of the value, cause
> the instruction to get the wrong result.
> 
> When viewing ftrace record in big-endian ARM systems, we found that
> the timestamp errors:
> 
> swapper-0     [001]  1325.970000:      0:120:R ==> [001]    16:120:R events/1
> events/1-16   [001]  1325.970000:      16:120:S ==> [001]    0:120:R swapper
> swapper-0     [000]  1325.1000000:     0:120:R   + [000]    15:120:R events/0
> swapper-0     [000]  1325.1000000:     0:120:R ==> [000]    15:120:R events/0
> swapper-0     [000]  1326.030000:      0:120:R   + [000]  1150:120:R sshd
> swapper-0     [000]  1326.030000:      0:120:R ==> [000]  1150:120:R sshd
> 
> When viewed ftrace records, it will call the do_div(n, base) function, which
> achieved arch/arm/include/asm/div64.h in. When n = 10000000, base = 1000000, in
> do_div(n, base) will execute "umull %Q0, %R0, %1, %Q2".
> 
> Cc: <stable@vger.kernel.org> # 2.6.20+
> Signed-off-by: Alex Wu <wuquanming@huawei.com>
> Signed-off-by: Xiangyu Lu <luxiangyu@huawei.com>

Argh..  My bad.

Reviewed-by: Nicolas Pitre <nico@linaro.org>

Please send to RMK's patch system.


> ---
>  arch/arm/include/asm/div64.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 191ada6..662c7bd 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -156,7 +156,7 @@
>  		/* Select the best insn combination to perform the   */	\
>  		/* actual __m * __n / (__p << 64) operation.         */	\
>  		if (!__c) {						\
> -			asm (	"umull	%Q0, %R0, %1, %Q2\n\t"		\
> +			asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"		\
>  				"mov	%Q0, #0"			\
>  				: "=&r" (__res)				\
>  				: "r" (__m), "r" (__n)			\
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
