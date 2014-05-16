From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 May 2014 17:55:48 +0100
Subject: [PATCH 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <20140516140606.GH5624@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
 <20140516140606.GH5624@arm.com>
Message-ID: <20140516165548.GA14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 03:06:07PM +0100, Catalin Marinas wrote:
> On Fri, May 16, 2014 at 10:50:39AM +0100, Mark Rutland wrote:
> > --- a/arch/arm64/Kconfig.debug
> > +++ b/arch/arm64/Kconfig.debug
> > @@ -37,4 +37,35 @@ config PID_IN_CONTEXTIDR
> >  	  instructions during context switch. Say Y here only if you are
> >  	  planning to use hardware trace tools with this kernel.
> >  
> > +config ARM64_RANDOMIZE_TEXT_OFFSET
> > +	bool "Randomize TEXT_OFFSET at build time (EXPERIMENTAL)"
> > +	default N
> 
> (nitpick: no need for default n)

Thanks for pointing that out, I'll remove it :)

> I think that's good for testing. It would have been nice to be able to
> set some limits for the random offset but I can't figure out an easy way
> to do this via Kconfig (maybe with additional options).

There are hard-coded limits implicit in the randomization -- between 0B
and 2MB in 16B increments:

TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%05x\n", and(int(0xfffff * rand()), 0xffff0)}')

The 16B increment is required due to some code in head.S (__turn_mmu_on)
requiring a minimum 16B alignment for the object.

The 2MB maximum comes from the fact we rely on the start of memory being
2MB aligned. I'm not sure there's a compelling reason to limit the
randomization if enabled at all -- either you can handle it or you
can't. Are we ever likely to want an offset larger than the memory
alignment?

> > +config ARM64_TEXT_OFFSET
> > +	hex "Required image load offset"
> > +	depends on !ARM64_RANDOMIZE_TEXT_OFFSET
> > +	default "0x0000000000080000"
> 
> I don't think we should include this. It encourages people to set
> specific offsets for their SoCs.

Sure, I was worried about potential abuse also (hence the warning in the
help text). I'll drop this portion.

Cheers,
Mark.
