From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 9 Feb 2017 14:25:15 -0500 (EST)
Subject: [PATCH 4/4] ARM: kuser: split the kuser support for Thumb-capable
 and ARM-only
In-Reply-To: <E1cbngY-00026G-HA@rmk-PC.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
 <E1cbngY-00026G-HA@rmk-PC.armlinux.org.uk>
Message-ID: <alpine.LFD.2.20.1702091355110.9597@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Feb 2017, Russell King wrote:

[...]
> +#ifdef GENERATE_FIXUPS
> +/*
> + * The .text section in this file is used for fixups of the various
> + * helpers.  Do not place anything else in the .text section within
> + * this file.
> + */
> +	.globl kuser_cmpxchg64_fixup
> +kuser_cmpxchg64_fixup:
> +#endif

[...]

> +#ifdef GENERATE_FIXUPS
>  	.text
> -	.globl kuser_cmpxchg64_fixup
> -kuser_cmpxchg64_fixup:
>  	@ Called from kuser_cmpxchg_check macro.
>  	@ r4 = address of interrupted insn (must be preserved).
>  	@ sp = saved regs. r7 and r8 are clobbered.
> @@ -98,11 +97,9 @@ __kuser_cmpxchg64:				@ 0xffff0f60
>  	subs	r8, r4, r7
>  	rsbcss	r8, r8, #(2b - 1b)
>  	strcs	r7, [sp, #S_PC]
> -#if __LINUX_ARM_ARCH__ < 6
> -	bcc	kuser_cmpxchg32_fixup
> -#endif
> -	ret	lr
> +	retcs	lr
>  	.previous
> +#endif

This construct gave me pause for a while.

A few observations:

- The kuser_cmpxchg32_fixup symbol is no longer referenced, so it can be 
  removed from the next fixup code block too.

- If __LINUX_ARM_ARCH__ >= 6 then the kuser_cmpxchg32 doesn't need any 
  fixup and the above sequence will end in:

	retcs	lr
	ret	lr

  Note a big deal though, and the increased code clarity is worth it.

- Given a single linear fixup block it might be more appropriate to 
  rename kuser_cmpxchg64_fixup to kuser_fixup so not to imply it is only 
  for cmpxchg64.

And you may add to the whole series:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
