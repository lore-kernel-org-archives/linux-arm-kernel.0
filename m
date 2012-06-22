From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 11:20:58 +0100
Subject: [PATCH] Consolidate stack size information into THREAD_SIZE_ORDER
In-Reply-To: <4FE35CF9.60707@am.sony.com>
References: <4FBD8205.3010904@am.sony.com>
 <4FE35CF9.60707@am.sony.com>
Message-ID: <20120622102058.GB28748@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Thu, Jun 21, 2012 at 06:42:17PM +0100, Tim Bird wrote:
> Any response to the following, which I submitted about
> a month ago?  May I submit it to the ARM patch-queue?
> Note that Ben Dooks took a quick look at it, but I
> haven't gotten an official ACK-ed by from anyone.

[...]

> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 0f04d84..5172c36 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -16,7 +16,7 @@
>  #include <asm/fpstate.h>
> 
>  #define THREAD_SIZE_ORDER	1
> -#define THREAD_SIZE		8192
> +#define THREAD_SIZE		(4096 << THREAD_SIZE_ORDER)
>  #define THREAD_START_SP		(THREAD_SIZE - 8)
> 
>  #ifndef __ASSEMBLY__
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 9a8531e..f94216b 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -109,8 +109,8 @@
>  	.endm
> 
>  	.macro	get_thread_info, rd
> -	mov	\rd, sp, lsr #13
> -	mov	\rd, \rd, lsl #13
> +	mov	\rd, sp, lsr #12 + THREAD_SIZE_ORDER
> +	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
>  	.endm

Maybe use PAGE_SHIFT instead of hardcoding the 12?

>  	@
> @@ -150,8 +150,8 @@
> 
>  	.macro	get_thread_info, rd
>  	mov	\rd, sp
> -	lsr	\rd, \rd, #13
> -	mov	\rd, \rd, lsl #13
> +	lsr	\rd, \rd, #12 + THREAD_SIZE_ORDER
> +	mov	\rd, \rd, lsl #12 + THREAD_SIZE_ORDER
>  	.endm

I appreciate you've followed the same style as before but while we're here
maybe you could rewrite the lsr as a mov for consistency?

Will
