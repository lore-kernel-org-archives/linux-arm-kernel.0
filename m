From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Nov 2013 14:04:36 +0000
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <alpine.LFD.2.10.1311120839310.9667@knanqh.ubzr>
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.10.1311092357090.2314@knanqh.ubzr>
 <528193A0.7050505@codeaurora.org>
 <alpine.LFD.2.10.1311120839310.9667@knanqh.ubzr>
Message-ID: <20131112140436.GK16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 09:01:16AM -0500, Nicolas Pitre wrote:
> What about this patch which I think is currently your best option.  Note 
> it would need to use the facilities from asm/opcodes.h to make it endian 
> agnostic.
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 6a1b8a81b1..379cffe4ab 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -383,6 +383,34 @@ static void __init cpuid_init_hwcaps(void)
>  		elf_hwcap |= HWCAP_IDIVT;
>  	}
>  
> +	/*
> +	 * Patch our division routines with the corresponding opcode
> +	 * if the hardware supports it.
> +	 */
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && (elf_hwcap & HWCAP_IDIVT)) {
> +		extern char __aeabi_uidiv, __aeabi_idiv;
> +		u16 *uidiv = (u16 *)&__aeabi_uidiv;
> +		u16 *idiv = (u16 *)&__aeabi_idiv;
> +
> +		uidiv[0] = 0xfbb0;  /* udiv r0, r0, r1 */
> +		uidiv[1] = 0xf0f1;
> +		uidiv[2] = 0x4770;  /* bx lr */
> +
> +		idiv[0] = 0xfb90;  /* sdiv r0, r0, r1 */
> +		idiv[1] = 0xf0f1;  
> +		idiv[2] = 0x4770;  /* bx lr */
> +	} else if (!IS_ENABLED(CONFIG_THUMB2_KERNEL) && (elf_hwcap & HWCAP_IDIVA)) {
> +		extern char __aeabi_uidiv, __aeabi_idiv;
> +		u32 *uidiv = (u32 *)&__aeabi_uidiv;
> +		u32 *idiv = (u32 *)&__aeabi_idiv;
> +
> +		uidiv[0] = 0xe730f110;  /* udiv r0, r0, r1 */
> +		uidiv[1] = 0xe12fff1e;  /* bx lr */
> +
> +		idiv[0] = 0xe710f110;  /* sdiv r0, r0, r1 */
> +		idiv[1] = 0xe12fff1e;  /* bx lr */
> +	}

What about endianness, and what if XIP is enabled?
