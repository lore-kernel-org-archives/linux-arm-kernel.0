From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Feb 2016 17:04:10 +0000
Subject: [PATCH v2 2/2] arm64/mm: Add .rodata to kernel virtual memory
 boot notice
In-Reply-To: <1455727274-16328-3-git-send-email-jeremy.linton@arm.com>
References: <1455727274-16328-1-git-send-email-jeremy.linton@arm.com>
 <1455727274-16328-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160217170409.GG32647@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 10:41:14AM -0600, Jeremy Linton wrote:
> Now that .rodata has differing permissions from .text
> display it in the mem_init banner as a seperate memory range.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This looks fine, but I think it would be better to have this folded into
the prior patch.

Mark.

> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5dd0831..41be7db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -325,6 +325,7 @@ void __init mem_init(void)
>  		  "    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n"
>  		  "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>  		  "      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
> +		  "    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>  		  "      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>  #ifdef CONFIG_KASAN
>  		  MLG(KASAN_SHADOW_START, KASAN_SHADOW_END),
> @@ -341,7 +342,8 @@ void __init mem_init(void)
>  		  MLM(MODULES_VADDR, MODULES_END),
>  		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
>  		  MLK_ROUNDUP(__init_begin, __init_end),
> -		  MLK_ROUNDUP(_text, _etext),
> +		  MLK_ROUNDUP(_text, __start_rodata),
> +		  MLK_ROUNDUP(__start_rodata, _etext),
>  		  MLK_ROUNDUP(_sdata, _edata));
>  
>  #undef MLK
> -- 
> 2.4.3
> 
