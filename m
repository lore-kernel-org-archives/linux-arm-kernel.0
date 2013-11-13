From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 13 Nov 2013 11:46:49 +0000
Subject: [PATCH 1/2] ARM: default PHYS_OFFSET if !MMU
In-Reply-To: <1384341351-4110-2-git-send-email-tom.leiming@gmail.com>
References: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
 <1384341351-4110-2-git-send-email-tom.leiming@gmail.com>
Message-ID: <528366A9.7060504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming,

On 13/11/13 11:15, Ming Lei wrote:
> From: Jonathan Austin <jonathan.austin@arm.com>
> 
> Set CONFIG_PAGE_OFFSET as PHYS_OFFSET when !MMU so that
> we can keep CONFIG_PAGE_OFFSET same with PAGE_OFFSET.
>

I'm not so sure about this commit message - I don't think
it makes sense...Should it not be more like:

------->8-------
Subject: ARM: set PAGE_OFFSET = PHYS_OFFSET if !MMU

With !MMU we still set PAGE_OFFSET to 0xC0000000, which
makes little sense and causes a regression on !MMU after
f6537f2f0eba4eba ("scripts/kallsyms: filter symbols not
kernel address space")

This patch sets PAGE_OFFSET to PHYS_OFFSET in the !MMU
case, fixing the regression (Tested on Cortex-R7/Vexpress)
--------8<---------

Russell: Will you pick this patch up from the list or does
it need to go in through the patch system?

Jonny

> This patch and patch 2/2 fix regression on !MMU by
> f6537f2f0eba4eba("scripts/kallsyms: filter symbols not
> in kernel address space")
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>   arch/arm/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 799ef94..db708c4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1560,6 +1560,7 @@ endchoice
>   
>   config PAGE_OFFSET
>   	hex
> +	default PHYS_OFFSET if !MMU
>   	default 0x40000000 if VMSPLIT_1G
>   	default 0x80000000 if VMSPLIT_2G
>   	default 0xC0000000
> 
