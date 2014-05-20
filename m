From: trini@kernel.crashing.org (Tom Rini)
Date: Tue, 20 May 2014 10:11:26 -0400
Subject: [PATCH 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <20140516165548.GA14766@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
 <20140516140606.GH5624@arm.com>
 <20140516165548.GA14766@leverpostej>
Message-ID: <20140520141126.GA1752@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 05:55:48PM +0100, Mark Rutland wrote:
> On Fri, May 16, 2014 at 03:06:07PM +0100, Catalin Marinas wrote:
> > On Fri, May 16, 2014 at 10:50:39AM +0100, Mark Rutland wrote:
> > > --- a/arch/arm64/Kconfig.debug
> > > +++ b/arch/arm64/Kconfig.debug
> > > @@ -37,4 +37,35 @@ config PID_IN_CONTEXTIDR
> > >  	  instructions during context switch. Say Y here only if you are
> > >  	  planning to use hardware trace tools with this kernel.
> > >  
> > > +config ARM64_RANDOMIZE_TEXT_OFFSET
> > > +	bool "Randomize TEXT_OFFSET at build time (EXPERIMENTAL)"
> > > +	default N
> > 
> > (nitpick: no need for default n)
> 
> Thanks for pointing that out, I'll remove it :)
> 
> > I think that's good for testing. It would have been nice to be able to
> > set some limits for the random offset but I can't figure out an easy way
> > to do this via Kconfig (maybe with additional options).
> 
> There are hard-coded limits implicit in the randomization -- between 0B
> and 2MB in 16B increments:
> 
> TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%05x\n", and(int(0xfffff * rand()), 0xffff0)}')

Note, is mawk expected to be able to be used for kernel building?  It
doesn't have 'and' as a function.

> The 16B increment is required due to some code in head.S (__turn_mmu_on)
> requiring a minimum 16B alignment for the object.
> 
> The 2MB maximum comes from the fact we rely on the start of memory being
> 2MB aligned. I'm not sure there's a compelling reason to limit the
> randomization if enabled at all -- either you can handle it or you
> can't. Are we ever likely to want an offset larger than the memory
> alignment?

A reason to limit the randomization is to make it easier on the
bootloaders to be able to rule of thumb initial loads.  It's not a big
deal with Image if it gets loaded lower than the offset, we can start
shifting data at the end.  But when we start looking at Image.gz (or xz
or ...), in some cases we'll get the whole image read into memory (network
booting for example), uncompress the first block so we can confirm a
good Image header and see about text_offset/image_size.  If we know that
text_offset is somewhere random inside of 2MB (or some other documented
max), we can then go with saying an initial load should be at say +32MB
(to mirror Documentation/arm/Booting).  If it can be anywhere, then
things get hard, or at least annoying (error out and tell the user to
re-load things because of a random value?  I can see testing frameworks
being annoyed about that).

And we should document the range of the offset in
Documentation/arm64/booting.txt as well.

-- 
Tom
