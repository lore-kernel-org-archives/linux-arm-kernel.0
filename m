From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 07 Jun 2013 11:07:29 +0100
Subject: [PATCH v2] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <20130606203858.GP18614@n2100.arm.linux.org.uk>
References: <1370538602.3695.71.camel@linaro1.home>
 <20130606203858.GP18614@n2100.arm.linux.org.uk>
Message-ID: <1370599649.3391.19.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-06 at 21:38 +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 06, 2013 at 06:10:02PM +0100, Jon Medhurst (Tixy) wrote:
> > +#ifdef CONFIG_ARM_ERRATA_643719
> > +	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
> > +	ALT_UP(moveq	pc, lr)			@ LoUU is zero, so nothing to do
> > +	biceq	r2, r2, #0x0000000f             @ clear minor revision number
> > +	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
> > +	teqeq	r2, r1                          @ test for errata affected core and if so...
> 
> I'm not sure if it makes much difference on Cortex A9, but we used to
> try to delay the use of a loaded value by one instruction where-ever
> possible.  This can be done trivially and cheaply on the above by just
> reversing the order of the ldreq and biceq.
> 
> Of course, if branch prediction and speculative load gets it right, the
> theory is there shouldn't be any delay here at all.  So I'm not _that_
> bothered about it as this is ARMv7-only code.

But you're a _little_ bothered? :-) I swapped the order in the version I
submitted to the patch system, I'm sure the Acker's won't mind.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7752/1

-- 
Tixy
