From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Aug 2012 14:02:14 -0400 (EDT)
Subject: [PATCH] ARM: decompressor: reset ttbcr for VMSA ARMv7 cores
In-Reply-To: <1345744123-4121-1-git-send-email-will.deacon@arm.com>
References: <1345744123-4121-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1208231401460.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Aug 2012, Will Deacon wrote:

> When enabling the MMU for ARMv7 CPUs, the decompressor does not touch
> the ttbcr register, assuming that it will be zeroed (N == 0, EAE == 0).
> Given that only EAE is defined as 0 for non-secure copies of the
> register (and a bootloader such as kexec may leave it set to 1 anyway),
> we should ensure that we reset the register ourselves before turning on
> the MMU.
> 
> This patch zeroes TTBCR.EAE and TTBCR.N prior to enabling the MMU for
> ARMv7 cores in the decompressor, configuring us exclusively for 32-bit
> translation tables via TTBR0.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/boot/compressed/head.S |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index b8c64b8..81769c1 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -659,10 +659,14 @@ __armv7_mmu_cache_on:
>  #ifdef CONFIG_CPU_ENDIAN_BE8
>  		orr	r0, r0, #1 << 25	@ big-endian page tables
>  #endif
> +		mrcne   p15, 0, r6, c2, c0, 2   @ read ttb control reg
>  		orrne	r0, r0, #1		@ MMU enabled
>  		movne	r1, #0xfffffffd		@ domain 0 = client
> +		bic     r6, r6, #1 << 31        @ 32-bit translation system
> +		bic     r6, r6, #3 << 0         @ use only ttbr0
>  		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
>  		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
> +		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>  #endif
>  		mcr	p15, 0, r0, c7, c5, 4	@ ISB
>  		mcr	p15, 0, r0, c1, c0, 0	@ load control register
> -- 
> 1.7.4.1
> 
