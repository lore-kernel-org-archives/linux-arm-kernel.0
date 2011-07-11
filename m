From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 16:05:09 -0400 (EDT)
Subject: [PATCH 19/51] ARM: kprobes: Infrastructure for table driven
	decoding of CPU instructions
In-Reply-To: <1310209058-20980-20-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-20-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107111552140.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> +/*
> + * Prepare an instruction slot to receive an instruction for emulating.
> + * This is done by placing a subroutine return after the location where the
> + * instruction will be placed. We also modify ARM instructions to be
> + * unconditional as the condition code will already be checked before any
> + * emulation handler is called.
> + */
> +static kprobe_opcode_t __kprobes
> +prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
> +								bool thumb)
> +{
> +#ifdef CONFIG_THUMB2_KERNEL
> +	if (thumb) {
> +		u16* thumb_insn = (u16 *)asi->insn;

Ninor style nit: we usually put the * against the variable rather than 
the type.  Here's why:

	u16* a, b, c;

vs

	u16 *a, b, c;

The first case is likely to cause confusion.

> +		thumb_insn[1] = 0x4770; /* Thumb bx lr */
> +		thumb_insn[2] = 0x4770; /* Thumb bx lr */
> +		return insn;
> +	}
> +	asi->insn[1] = 0xe12fff1e; /* ARM bx lr */
> +#else
> +	asi->insn[1] = 0xe1a0f00e; /* mov pc, lr */
> +#endif
> +	/* Make an ARM instructional unconditional */

You meant "instruction" here I suppose.

Otherwise this looks really great.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
