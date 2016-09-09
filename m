From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 9 Sep 2016 13:36:56 -0400 (EDT)
Subject: Improper TTBCR for arm 32bit kernel decompression
In-Reply-To: <57D2E47D.5030105@codeaurora.org>
References: <57D2E47D.5030105@codeaurora.org>
Message-ID: <alpine.LFD.2.20.1609091334120.14769@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2016, Srinivas Ramana wrote:

> Hello,
> 
> While trying to boot arm-32 bit kernel, I came across a problem where TTBCR is
> in improper state. If the bootloader uses the long descriptor format and jumps
> to kernel decompressor code, TTBCR may not be in the right state. So, as soon
> as the MMU is enabled, execution can not proceed further.
> 
> Before enabling the MMU, it is required to clear the TTBCR.PD0 field to use
> TTBR0 for translation table walks. Also, TTBCR.N should be reset to '0' to
> indicate the correct base address width. The 'commit dbece45894d3a ("ARM:
> 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores")' does the reset of
> TTBCR.N, but doesn't consider all the bits for the size of TTBCR.N.
> 
> when i tried the below change where i explicitly clear TTBCR.PD0 and use
> correct mask for TTBCR.N, I see proper memory after MMU is enabled and
> decompression succeeds.
> 
> Request your comments on the change below. If it looks good, I can submit a
> patch for inclusion.
> 
> ---------------------8<----------------------------------
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index af11c2f..5769f1f 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -779,7 +779,8 @@ __armv7_mmu_cache_on:
>                 orrne   r0, r0, #1              @ MMU enabled
>                 movne   r1, #0xfffffffd         @ domain 0 = client
>                 bic     r6, r6, #1 << 31        @ 32-bit translation system
> -               bic     r6, r6, #3 << 0         @ use only ttbr0
> +               bic     r6, r6, #7 << 0         @ width of base address field
> +               bic     r6, r6, #1 << 4         @ use only ttbr0

You could combine those instructions like this:

		bic	r6, r6, #(7 << 0) | (1 << 4) @ use only ttbr0


Nicolas
