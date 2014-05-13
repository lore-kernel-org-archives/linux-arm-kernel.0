From: bp@alien8.de (Borislav Petkov)
Date: Tue, 13 May 2014 02:12:46 +0200
Subject: [PATCHv4 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller
In-Reply-To: <1399937817-2202-4-git-send-email-tthayer@altera.com>
References: <1399937817-2202-1-git-send-email-tthayer@altera.com>
 <1399937817-2202-4-git-send-email-tthayer@altera.com>
Message-ID: <20140513001246.GC5935@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 06:36:57PM -0500, tthayer at altera.com wrote:
> +	ptemp[0] = 0x5A5A5A5A;
> +	ptemp[1] = 0xA5A5A5A5;
> +	/* Clear the error injection bits */
> +	regmap_write(drvdata->mc_vbase,	CTLCFG, read_reg);
> +	/* Ensure it has been written out */
> +	wmb();
> +
> +	/*
> +	 * To trigger the error, we need to read the data back
> +	 * (the data was written with errors above)
> +	 * The ACCESS_ONCE macros are used to prevent the
> +	 * compiler optimizing these reads out.
> +	 */
> +	reg = ACCESS_ONCE(ptemp[0]);
> +	read_reg = ACCESS_ONCE(ptemp[1]);
> +	/* Force Read */
> +	rmb();

Right, I still am a bit unsure about this thing. So sure, we funnel
ptemp through an asm() block which stops the optimizer but we assign the
results to reg and read_reg, i.e. two local variables which aren't used
in this function anymore.

Thus, I don't see what stops the compiler from discarding them along
with the ACCESS_ONCE() reads at some point, when it becomes really
smart. Basically killing

> +     reg = ACCESS_ONCE(ptemp[0]);
> +     read_reg = ACCESS_ONCE(ptemp[1]);

as they have to effect.

Maybe we can do the reads in asm - this should be pretty safe.

I.e., something like this:

      asm volatile("" : "=r" (reg), "=r" (read_reg),
		      : "0" (ptemp[0]), "1" (ptemp[1]));

and it does it on x86 (did a small test program) by shuffling the values
through registers so we definitely have the reads.

	.loc 1 28 0
	movl	-48(%rbp), %edx	# ptemp, D.2240
	movl	-44(%rbp), %eax	# ptemp, D.2240
	.loc 1 27 0
	movl	%edx, -28(%rbp)	# reg, reg
	movl	%eax, -32(%rbp)	# read_reg, read_reg

Btw, if you only want to do the reads, you can simply tell gcc to put them in
registers

      asm volatile("" :: "r" (ptemp[0]), "r" (ptemp[1]));

and be done with it but I don't know how smart it is with register
allocation so as to recognize that they're already in registers (when
they already are in some registers) and discard the reads.

Fun stuff! :-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
