From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 11 Aug 2014 22:33:25 -0400 (EDT)
Subject: [PATCH v3] ARM: zImage: perform cache maintenance after relocating
 code (was: ARM: zImage: add DSB and ISB barriers after relocating code)
In-Reply-To: <1407803747-21379-1-git-send-email-marc.ceeeee@gmail.com>
References: <1407803747-21379-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <alpine.LFD.2.11.1408112232590.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Aug 2014, Marc Carino wrote:

> The zImage loader will relocate the kernel image if it determines that
> decompression will overwrite its current location. Since the act of relocation
> is a form of code self-modification, we need to ensure that the CPU fetches
> the updated instruction stream.
> 
> Instead of conditionally executing cache maintenance, this commit ensures that
> cache maintenance is performed in all cases. Besides ensuring coherency with
> the caches and main memory, performing cache maintenance ensures that any
> potentially stale instructions are flushed from the instruction pipeline.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/boot/compressed/head.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 3a8b32d..8a39054 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -395,8 +395,7 @@ dtb_check_done:
>  		add	sp, sp, r6
>  #endif
>  
> -		tst	r4, #1
> -		bleq	cache_clean_flush
> +		bl	cache_clean_flush
>  
>  		adr	r0, BSYM(restart)
>  		add	r0, r0, r6
> -- 
> 1.8.1.3
> 
> 
