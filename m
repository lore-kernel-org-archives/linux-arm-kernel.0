From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 5 Nov 2012 13:02:55 +0000
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105111346.GF28327@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net>
 <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
Message-ID: <20121105130255.GD2005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 11:13:46AM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 10:48:50AM +0000, Dave Martin wrote:
> > On Thu, Oct 25, 2012 at 05:08:16PM +0200, Johannes Stezenbach wrote:
> > > On Thu, Oct 25, 2012 at 09:25:06AM -0500, Rob Herring wrote:
> > > > On 10/25/2012 09:16 AM, Johannes Stezenbach wrote:
> > > > > On Thu, Oct 25, 2012 at 07:41:45AM -0500, Rob Herring wrote:
> > > > >> On 10/25/2012 04:34 AM, Johannes Stezenbach wrote:
> > > > >>> On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
> > > > >>>
> > > > >>>> While v6 can support unaligned accesses, it is optional and current
> > > > >>>> compilers won't emit unaligned accesses. So we don't clear the A bit for
> > > > >>>> v6.
> > > > >>>
> > > > >>> not true according to the gcc changes page
> > > > >>
> > > > >> What are you going to believe: documentation or what the compiler
> > > > >> emitted? At least for ubuntu/linaro 4.6.3 which has the unaligned access
> > > > >> support backported and 4.7.2, unaligned accesses are emitted for v7
> > > > >> only. I guess default here means it is the default unless you change the
> > > > >> default in your build of gcc.
> > > > > 
> > > > > Since ARMv6 can handle unaligned access in the same way as ARMv7
> > > > > it seems a clear bug in gcc which might hopefully get fixed.
> > > > > Thus in this case I think it is reasonable to follow the
> > > > > gcc documentation, otherwise the code would break for ARMv6
> > > > > when gcc gets fixed.
> > > > 
> > > > But the compiler can't assume the state of the U bit. I think it is
> > > > still legal on v6 to not support unaligned accesses, but on v7 it is
> > > > required. All the standard v6 ARM cores support it, but I'm not sure
> > > > about custom cores or if there are SOCs with buses that don't support
> > > > unaligned accesses properly.
> > > 
> > > Well, I read the "...since Linux version 2.6.28" comment
> > > in the gcc changes page in the way that they assume the
> > > U-bit is set. (Although I'm not sure it really is???)
> > 
> > Actually, the kernel checks the arch version and the U bit on boot,
> > and chooses the appropriate setting for the A bit depending on the
> > result.  (See arch/arm/mm/alignment.c:alignment_init().)
> 
> That is in the kernel itself, _after_ the decompressor has run.  It is
> not relevant to any discussion about the decompressor.

This was merely meant as an argument that the kernel does not make
assumptions about the U bit, and so the zImage decompressor probably
shouldn't either.

> > Currently, we depend on the CPU reset behaviour or firmware/
> > bootloader to set the U bit for v6, but the behaviour should be
> > correct either way, though unaligned accesses will obviously
> > perform (much) better with U=1.
> 
> Will someone _PLEASE_ address my initial comments against this patch
> in light of the fact that it's now been proven _NOT_ to be just a V7
> issue, rather than everyone seemingly buring their heads in the sand
> over this.
> 
> The fact is, unaligned accesses in the decompressor are *undefined* at
> present.

Why not allow unaligned accesses in the decompressor, though, both
for v6 and v7?

The decompressors run with the cache on, so we should have fault-free
unaligned access on all CPUs which support it, provided that we set the
SCTLR bits appropriately, and provided that the decompressers are
written in correct C.

The counterargument is that zImage would then just fall over if booted
on a CPU older than the baseline architecture the kernel was built for.
However, that should be detected before executing any C code, giving
the zImage code a chance to bail out with a suitable error message.

A kernel which contains support for v6/v7 platforms cannot work on older
CPUs anyway, because the kernel itself doesn't support such combinations.

> > For v7, we should definitely use -munaligned-access where available
> > (unless it's the default?)
> 
> No such option on my compiler - according to the manual I have, the only
> option there is starting -munaligned is on SPARC for -munaligned-doubles.

OK, I guess that's something backported into the Linaro toolchain I'm
currently using then.  But it seems a good idea to use this if available,
because it allows the compiler to generate better code in some situations,
especially for packed struct access.
 
> However, I believe GCC does believe that unaligned accesses are fine on
> V6 and above.

Possibly, but I've never seen it use them deliberately, prior to the
-munaligned-access support.

Cheers
---Dave
