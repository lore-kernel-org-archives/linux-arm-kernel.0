From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 12 Nov 2013 14:22:55 +0000
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <alpine.LFD.2.10.1311120839310.9667@knanqh.ubzr> (Nicolas Pitre's
 message of "Tue, 12 Nov 2013 09:01:16 -0500 (EST)")
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.10.1311092357090.2314@knanqh.ubzr>
 <528193A0.7050505@codeaurora.org>
 <alpine.LFD.2.10.1311120839310.9667@knanqh.ubzr>
Message-ID: <yw1xhabhvgw0.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

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

It would be safer to declare these as arrays of unspecified size.
Otherwise the compiler might do evil things with what to it looks like
out of bounds indexing.

There should also be some cache maintenance after this patching, or is
that already happening for some other reason?

-- 
M?ns Rullg?rd
mans at mansr.com
