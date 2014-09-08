From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Sep 2014 11:53:07 +0100
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with
 clang
In-Reply-To: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
References: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
Message-ID: <20140908105307.GF26030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 12:24:20AM +0100, behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
> 
> Fix variable types for 64-bit inline assembly.
> 
> This patch now works with both gcc and clang.

Really? This looks like something the clang needs to do better on, as I
really don't see people adding these casts to future code. They're ugly and
redundant (or GCC).

This hunk:

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c555672..6894ef3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -94,7 +94,7 @@ static int __init early_cachepolicy(char *p)
>  	 */
>  	asm volatile(
>  	"	mrs	%0, mair_el1\n"
> -	"	bfi	%0, %1, #%2, #8\n"
> +	"	bfi	%0, %1, %2, #8\n"
>  	"	msr	mair_el1, %0\n"
>  	"	isb\n"
>  	: "=&r" (tmp)

also looks fishy. Does gas accept that without the '#' prefix?

Will
