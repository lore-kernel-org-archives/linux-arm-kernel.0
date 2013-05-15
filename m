From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 May 2013 12:38:12 -0700
Subject: [PATCH] ARM: avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
References: <1368049671-22879-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5193E424.9090605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/13 14:47, Stephen Boyd wrote:
> From: Brian Swetland <swetland@google.com>
>
> Currently v7 CPUs with an MIDR that has no bits set in the range
> [16:12] will be detected as old ARM CPUs with no caches and so
> the cache will never be turned on during decompression. ARM's
> Cortex chips have an 0xC in the range [16:12] so they never match
> this entry, but Qualcomm's Scorpion and Krait processors never
> set these bits to anything besides 0 so they always match.
>
> Skip this entry if we've compiled in support for v7 CPUs. This
> allows kernel decompression to happen nearly instantly instead of
> taking over 20 seconds.
>
> Signed-off-by: Brian Swetland <swetland@google.com>
> [sboyd: Clarified and extended commit text]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Ping?

>  arch/arm/boot/compressed/head.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index fe4d9c3..a236190 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -805,6 +805,8 @@ call_cache_fn:	adr	r12, proc_types
>  		.align	2
>  		.type	proc_types,#object
>  proc_types:
> +#if !defined(CONFIG_CPU_V7)
> +		/* This collides with some V7 IDs, preventing correct detection */
>  		.word	0x00000000		@ old ARM ID
>  		.word	0x0000f000
>  		mov	pc, lr
> @@ -813,6 +815,7 @@ proc_types:
>   THUMB(		nop				)
>  		mov	pc, lr
>   THUMB(		nop				)
> +#endif
>  
>  		.word	0x41007000		@ ARM7/710
>  		.word	0xfff8fe00


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
