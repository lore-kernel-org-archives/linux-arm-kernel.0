From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 19 Jan 2015 15:55:47 +0900
Subject: [PATCH] ARM: exynos: fix UART address selection for DEBUG_LL
In-Reply-To: <1411728234-29705-1-git-send-email-jy0922.shim@samsung.com>
References: <1411728234-29705-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <54BCAA73.5080404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi kukjin,

On 09/26/2014 07:43 PM, Joonyoung Shim wrote:
> The exynos5 SoCs using A15+A7 can boot to A15 or A7. If it boots using
> A7, it can't detect right UART physical address only the part number of
> CP15. It's possible to solve as checking Cluster ID additionally.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  arch/arm/include/debug/exynos.S | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/debug/exynos.S b/arch/arm/include/debug/exynos.S
> index b17fdb7..60bf3c2 100644
> --- a/arch/arm/include/debug/exynos.S
> +++ b/arch/arm/include/debug/exynos.S
> @@ -24,7 +24,11 @@
>  		mrc	p15, 0, \tmp, c0, c0, 0
>  		and	\tmp, \tmp, #0xf0
>  		teq	\tmp, #0xf0		@@ A15
> -		ldreq	\rp, =EXYNOS5_PA_UART
> +		beq	100f
> +		mrc	p15, 0, \tmp, c0, c0, 5
> +		and	\tmp, \tmp, #0xf00
> +		teq	\tmp, #0x100		@@ A15 + A7 but boot to A7
> +100:		ldreq	\rp, =EXYNOS5_PA_UART
>  		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
>  		ldr	\rv, =S3C_VA_UART
>  #if CONFIG_DEBUG_S3C_UART != 0
> 

Any comments?

Thanks.
