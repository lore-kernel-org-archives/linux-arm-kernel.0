From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 10:49:54 +0100
Subject: [PATCH] ARM: highbank: Add smc calls to enable/disable the L2
In-Reply-To: <1338865900-11373-1-git-send-email-robherring2@gmail.com>
References: <1338865900-11373-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120605094954.GH8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 10:11:40PM -0500, Rob Herring wrote:
> +/*
> + * This is common routine to manage secure monitor API
> + * used to modify the PL310 secure registers.
> + * 'r0' contains the value to be modified and 'r12' contains
> + * the monitor API number. It uses few CPU registers
> + * internally and hence they need be backed up including
> + * link register "lr".
> + * Function signature : void highbank_smc1(u32 fn, u32 arg)
> + */
> +
> +ENTRY(highbank_smc1)
> +	stmfd   sp!, {r2-r12, lr}
> +	mov	r12, r0
> +	mov 	r0, r1
> +	dsb
> +	smc	#0
> +	ldmfd   sp!, {r2-r12, pc}
> +ENDPROC(highbank_smc1)

The ABI.  r0-r3 are used to pass arguments, and _may_ be corrupted by
the called function.  r12 is a temporary register which called functions
may corrupt.  lr is not expected to be preserved.  Everything else must
be preserved.  Return values in r0 and maybe r1.

So.  The registers you must preserve across a function call are r4-r11,
and r13(sp).
