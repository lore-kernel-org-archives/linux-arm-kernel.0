From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 2 Jun 2014 11:25:16 +0100
Subject: [PATCH] ARM: decompressor: a minor optimization
In-Reply-To: <1401449433-1963-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1401449433-1963-1-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <20140602102516.GC3855@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 08:30:33PM +0900, Masahiro Yamada wrote:
> "ldr sp, [r0, #28]" can be squashed into the previous ldm instruction.

See commit 77754410fb8ecd7cf307bcd75d60f3b22b8c3cd2
ARM: 6286/1: fix Thumb-2 decompressor broken by "Auto calculate ZRELADDR"

Loading sp with LDMIA is not allowed in Thumb.  For simpler code
maintenance, the code was just made Thumb-compatible anyway by splitting
out the sp load while fixing another issue.  This isn't part of a core
loop, so shouldn't have a significant impact on performance.

git blame can be useful for finding out how an odd-looking piece of code
came into existence.  Sometimes you have to dig through a few patches to
find the answer.

Cheers
---Dave

> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> ---
>  arch/arm/boot/compressed/head.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 066b034..8c392c5 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -194,8 +194,7 @@ not_angel:
>  		blcs	cache_on
>  
>  restart:	adr	r0, LC0
> -		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12}
> -		ldr	sp, [r0, #28]
> +		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12, sp}
>  
>  		/*
>  		 * We might be running at a different address.  We need
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
