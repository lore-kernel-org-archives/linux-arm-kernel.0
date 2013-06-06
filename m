From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jun 2013 21:38:58 +0100
Subject: [PATCH v2] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <1370538602.3695.71.camel@linaro1.home>
References: <1370538602.3695.71.camel@linaro1.home>
Message-ID: <20130606203858.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 06:10:02PM +0100, Jon Medhurst (Tixy) wrote:
> +#ifdef CONFIG_ARM_ERRATA_643719
> +	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
> +	ALT_UP(moveq	pc, lr)			@ LoUU is zero, so nothing to do
> +	biceq	r2, r2, #0x0000000f             @ clear minor revision number
> +	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
> +	teqeq	r2, r1                          @ test for errata affected core and if so...

I'm not sure if it makes much difference on Cortex A9, but we used to
try to delay the use of a loaded value by one instruction where-ever
possible.  This can be done trivially and cheaply on the above by just
reversing the order of the ldreq and biceq.

Of course, if branch prediction and speculative load gets it right, the
theory is there shouldn't be any delay here at all.  So I'm not _that_
bothered about it as this is ARMv7-only code.
