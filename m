From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 May 2014 22:11:28 -0400 (EDT)
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
References: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Marc Carino wrote:

> The zImage loader will relocate the image if it determines that
> decompression will overwrite its current location. Since the act
> of relocation is basically a form of code self-modification, we
> need to ensure that the CPU fetches the updated instruction stream.
> 
> Since cache maintenance is skipped during the relocation phase (the
> MMUs and caches are off), 

Beware... This statement isn't true in most cases.

> we need to execute both a data sync
> and instruction sync barrier prior to jumping to the relocated code.
> Skipping the barriers can result in execution of stale prefetched
> code, leading to hangs or an UNDEFINED INSTRUCTION exception.

Are you sure of that?  When the MMU is off, memory access is strongly 
ordered.  I'm wondering if instruction prefetching applies in that case.

Also, is this a problem that you actually experienced in practice?

> @@ -400,8 +400,16 @@ dtb_check_done:
>  		add	sp, sp, r6
>  #endif
>  
> +		/*
> +		 * Perform cache maintenance if caches were enabled earlier.
> +		 * Otherwise, execute data and instruction barriers prior to
> +		 * jumping to the newly-written code.
> +		 */
>  		tst	r4, #1
>  		bleq	cache_clean_flush
> +		movne	r0, #0
> +		mcrne	p15, 0, r0, c7, c10, 4	@ DSB
> +		mcrne	p15, 0, r0, c7, c5, 4	@ ISB

Are you sure those CP15 accesses are fine on all the CPU variants that 
may execute this code?  Officially we still support back to ARMv4 
implementations.


Nicolas
