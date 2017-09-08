From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 8 Sep 2017 11:50:45 +0900
Subject: [PATCH 09/14] arm64: kexec_file: add sha256 digest check in
 purgatory
In-Reply-To: <20170825104133.GB3127@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-10-takahiro.akashi@linaro.org>
 <20170824170440.GD29665@leverpostej>
 <20170825012103.GB7245@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825104133.GB3127@leverpostej>
Message-ID: <20170908025044.GD17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 11:41:33AM +0100, Mark Rutland wrote:
> On Fri, Aug 25, 2017 at 10:21:06AM +0900, AKASHI Takahiro wrote:
> > On Thu, Aug 24, 2017 at 06:04:40PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 24, 2017 at 05:18:06PM +0900, AKASHI Takahiro wrote:
> > > > Most of sha256 code is based on crypto/sha256-glue.c, particularly using
> > > > non-neon version.
> > > > 
> > > > Please note that we won't be able to re-use lib/mem*.S for purgatory
> > > > because unaligned memory access is not allowed in purgatory where mmu
> > > > is turned off.
> > > > 
> > > > Since purgatory is not linked with the other part of kernel, care must be
> > > > taken of selecting an appropriate set of compiler options in order to
> > > > prevent undefined symbol references from being generated.
> > > 
> > > What is the point in performing this check in the purgatory code, when
> > > this will presumably have been checked when the image is loaded?
> > 
> > Well, this is what x86 does :)
> > On powerpc, meanwhile, they don't have this check.
> > 
> > Maybe to avoid booting corrupted kernel after loading?
> > (loaded data are now protected by making them unmapped, though.)
> 
> I'd really prefer to avoid this, since it seems to be what necessitates
> all the complexity for executing C code (linking and all), and it's
> going to be very slow to execute with the MMU off.
> 
> If you can deliberately corrupt the next kernel, you could also have
> corrupted the purgatory to skip the check.
> 
> Unless we have a strong reason to want the hash check, I think it should
> be dropped.

As I said, I will drop the code in v2 :)

> > > > diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> > > > index bc4e6b3bf8a1..74d028b838bd 100644
> > > > --- a/arch/arm64/purgatory/entry.S
> > > > +++ b/arch/arm64/purgatory/entry.S
> > > > @@ -6,6 +6,11 @@
> > > >  .text
> > > >  
> > > >  ENTRY(purgatory_start)
> > > > +	adr	x19, .Lstack
> > > > +	mov	sp, x19
> > > > +
> > > > +	bl	purgatory
> > > > +
> > > >  	/* Start new image. */
> > > >  	ldr	x17, arm64_kernel_entry
> > > >  	ldr	x0, arm64_dtb_addr
> > > > @@ -15,6 +20,14 @@ ENTRY(purgatory_start)
> > > >  	br	x17
> > > >  END(purgatory_start)
> > > >  
> > > > +.ltorg
> > > > +
> > > > +.align 4
> > > > +	.rept	256
> > > > +	.quad	0
> > > > +	.endr
> > > > +.Lstack:
> > > > +
> > > >  .data
> > > 
> > > Why is the stack in .text?
> > 
> > to call verify_sha256_digest() from asm
> 
> Won't that also work if the stack is in .data? or .bss?
> 
> ... or is there a particular need for it to be in .text?
> 
> > > Does this need to be zeroed?
> > 
> > No :)
> 
> Ok, so we can probably do:
> 
> 	.data
> 	.align 4
> 	. += PURGATORY_STACK_SIZE
> .Lstack_ptr:
> 
> ... assuming we need to run C code.
> 
> [...]
> 
> > > > diff --git a/arch/arm64/purgatory/sha256.c b/arch/arm64/purgatory/sha256.c
> > > > new file mode 100644
> > > > index 000000000000..5d20d81767e3
> > > > --- /dev/null
> > > > +++ b/arch/arm64/purgatory/sha256.c
> > > > @@ -0,0 +1,79 @@
> > > > +#include <linux/kexec.h>
> > > > +#include <linux/purgatory.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +/*
> > > > + * Under KASAN, those are defined as un-instrumented version, __memxxx()
> > > > + */
> > > > +#undef memcmp
> > > > +#undef memcpy
> > > > +#undef memset
> > > 
> > > This doesn't look like the right place for this undeffery; it looks
> > > rather fragile.
> > 
> > Yeah, I agree, but if not there, __memxxx() are used.
> 
> Ok, but we'll have to add this to every C file used in the purgatory
> code, or at the start of any header that uses a memxxx() function, or it
> might still be overridden to use __memxxx(), before the undef takes
> effect.
> 
> Can we define __memxxx() instead?
> 
> [...]
> 
> > > > +void *memcpy(void *dst, const void *src, size_t len)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < len; i++)
> > > > +		((u8 *)dst)[i] = ((u8 *)src)[i];
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > +void *memset(void *dst, int c, size_t len)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < len; i++)
> > > > +		((u8 *)dst)[i] = (u8)c;
> > > > +
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > +int memcmp(const void *src, const void *dst, size_t len)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < len; i++)
> > > > +		if (*(char *)src != *(char *)dst)
> > > > +			return 1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > How is the compiler prevented from "optimising" these into calls to
> > > themselves?
> > 
> > I don't get what you mean by "calls to themselves."
> 
> There are compiler optimizations that recognise sequences like:
> 
> 	for (i = 0; i < len; i++)
> 		dst[i] = src[i];
> 
> ... and turn those into:
> 
> 	memcpy(dst, src, len);
> 
> ... these have been known to "optimize" memcpy implementations into
> calls to themselves. Likewise for other string operations.
> 
> One way we avoid that today is by writing our memcpy in assembly.

I see, thanks.

> Do we have a guarnatee that this will not happen here? e.g. do we pass
> some compiler flag that prevents this?

I don't know any options to do this.
(maybe -nostdlib?)

-Takahiro AKASHI

> Thanks,
> Mark.
