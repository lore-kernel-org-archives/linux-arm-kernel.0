From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 11 Oct 2018 16:36:01 -0400 (EDT)
Subject: [PATCH] ARM: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
In-Reply-To: <20181011111652.31840-1-vincent.whitchurch@axis.com>
References: <20181011111652.31840-1-vincent.whitchurch@axis.com>
Message-ID: <nycvar.YSQ.7.76.1810111621450.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Oct 2018, Vincent Whitchurch wrote:

> ARMv6+ processors do not use CONFIG_CPU_USE_DOMAINS and use privileged
> ldr/str instructions in copy_{from/to}_user.  They are currently
> unnecessarily using single ldr/str instructions and can use ldm/stm
> instructions instead like memcpy does (but with appropriate fixup
> tables).
> 
> function                                     old     new   delta
> arm_copy_from_user                           924     824    -100
> __copy_to_user_std                           936     824    -112
> 
> This speeds up a "dd if=foo of=bar bs=32k" on a tmpfs filesystem by
> about 4% on my Cortex-A9.
> 
> before:134217728 bytes (128.0MB) copied, 0.543848 seconds, 235.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.538610 seconds, 237.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.544356 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.544364 seconds, 235.1MB/s
> before:134217728 bytes (128.0MB) copied, 0.537130 seconds, 238.3MB/s
> before:134217728 bytes (128.0MB) copied, 0.533443 seconds, 240.0MB/s
> before:134217728 bytes (128.0MB) copied, 0.545691 seconds, 234.6MB/s
> before:134217728 bytes (128.0MB) copied, 0.534695 seconds, 239.4MB/s
> before:134217728 bytes (128.0MB) copied, 0.540561 seconds, 236.8MB/s
> before:134217728 bytes (128.0MB) copied, 0.541025 seconds, 236.6MB/s
> 
>  after:134217728 bytes (128.0MB) copied, 0.520445 seconds, 245.9MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527846 seconds, 242.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519510 seconds, 246.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.527231 seconds, 242.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525030 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.524236 seconds, 244.2MB/s
>  after:134217728 bytes (128.0MB) copied, 0.523659 seconds, 244.4MB/s
>  after:134217728 bytes (128.0MB) copied, 0.525018 seconds, 243.8MB/s
>  after:134217728 bytes (128.0MB) copied, 0.519249 seconds, 246.5MB/s
>  after:134217728 bytes (128.0MB) copied, 0.518527 seconds, 246.9MB/s
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

[...]

> index a826df3d3814..7751072d409a 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -34,13 +34,19 @@
>   *	Number of bytes NOT copied.
>   */
>  
> +#ifdef CONFIG_CPU_USE_DOMAINS
>  #ifndef CONFIG_THUMB2_KERNEL
>  #define LDR1W_SHIFT	0
>  #else
>  #define LDR1W_SHIFT	1
>  #endif
> +#else
> +#define LDR1W_SHIFT	0
> +#endif
> +
>  #define STR1W_SHIFT	0
>  
> +#ifdef CONFIG_CPU_USE_DOMAINS
>  	.macro ldr1w ptr reg abort

I'd suggest you do the grouping differently. The LDR1W_SHIFT and 
STR1W_SHIFT definitions are direct properties of the ldr1w and str1w 
macro implementations, and not necessarily whether you have 
CONFIG_CPU_USE_DOMAINS defined.

In other words, I'd prefer to see:

#ifdef CONFIG_CPU_USE_DOMAINS

#define LDR1W_SHIFT ...
#define STR1W_SHIFT ...

	.macro ldr1w ...
	...

#else

#define LDR1W_SHIFT ...
#define STR1W_SHIFT ...

	.macro ldr1w ...
	...

#endif


Nicolas
