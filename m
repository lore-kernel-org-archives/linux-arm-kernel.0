From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 20:56:22 +0000
Subject: [RFT/RFC PATCH 3/6] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <1426181892-15440-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150312205622.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 06:38:09PM +0100, Ard Biesheuvel wrote:
> +	/*
> +	 * Macros to emit relative branches that may exceed the range
> +	 * of the 24-bit immediate of the ordinary b/bl instructions.
> +	 * NOTE: this doesn't work with locally defined symbols, as they
> +	 * might lack the ARM/Thumb annotation (even if they are annotated
> +	 * as functions)
> +	 */
> +	.macro  b_far, target, tmpreg
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> + ARM(	movt	\tmpreg, #:upper16:(\target - (8888f + 8))	)
> + ARM(	movw	\tmpreg, #:lower16:(\target - (8888f + 8))	)
> + THUMB(	movt    \tmpreg, #:upper16:(\target - (8888f + 4))	)
> + THUMB(	movw	\tmpreg, #:lower16:(\target - (8888f + 4))	)
> +8888:	add	pc, pc, \tmpreg
> +#else
> +	ldr	\tmpreg, 8889f
> +8888:	add	pc, pc, \tmpreg
> +	.align 	2
> +8889:
> + ARM(	.word   \target - (8888b + 8)           )
> +#endif

I'm really hating this.  It's potentially polluting the data cache
(which relies on proximity of data to be effective) with instructions.
I wonder whether we can use ldr \tmpreg, =\target - (8888b + 8) here,
and let the assembler build some literal pools (maybe with appropriate
.ltorg statements if necessary)?

Another reason I'm hating it is the difference in those movt and movw
instructions just because we have a different PC offset between Thumb
and ARM.  A better way to deal with that would be some common definition
somewhere of that offset.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
