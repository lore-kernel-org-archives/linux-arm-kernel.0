From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 5 Nov 2012 10:48:50 +0000
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121025150816.GA3874@sig21.net>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net>
Message-ID: <20121105104839.GA2005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 05:08:16PM +0200, Johannes Stezenbach wrote:
> On Thu, Oct 25, 2012 at 09:25:06AM -0500, Rob Herring wrote:
> > On 10/25/2012 09:16 AM, Johannes Stezenbach wrote:
> > > On Thu, Oct 25, 2012 at 07:41:45AM -0500, Rob Herring wrote:
> > >> On 10/25/2012 04:34 AM, Johannes Stezenbach wrote:
> > >>> On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
> > >>>
> > >>>> While v6 can support unaligned accesses, it is optional and current
> > >>>> compilers won't emit unaligned accesses. So we don't clear the A bit for
> > >>>> v6.
> > >>>
> > >>> not true according to the gcc changes page
> > >>
> > >> What are you going to believe: documentation or what the compiler
> > >> emitted? At least for ubuntu/linaro 4.6.3 which has the unaligned access
> > >> support backported and 4.7.2, unaligned accesses are emitted for v7
> > >> only. I guess default here means it is the default unless you change the
> > >> default in your build of gcc.
> > > 
> > > Since ARMv6 can handle unaligned access in the same way as ARMv7
> > > it seems a clear bug in gcc which might hopefully get fixed.
> > > Thus in this case I think it is reasonable to follow the
> > > gcc documentation, otherwise the code would break for ARMv6
> > > when gcc gets fixed.
> > 
> > But the compiler can't assume the state of the U bit. I think it is
> > still legal on v6 to not support unaligned accesses, but on v7 it is
> > required. All the standard v6 ARM cores support it, but I'm not sure
> > about custom cores or if there are SOCs with buses that don't support
> > unaligned accesses properly.
> 
> Well, I read the "...since Linux version 2.6.28" comment
> in the gcc changes page in the way that they assume the
> U-bit is set. (Although I'm not sure it really is???)

Actually, the kernel checks the arch version and the U bit on boot,
and chooses the appropriate setting for the A bit depending on the
result.  (See arch/arm/mm/alignment.c:alignment_init().)

Currently, we depend on the CPU reset behaviour or firmware/
bootloader to set the U bit for v6, but the behaviour should be
correct either way, though unaligned accesses will obviously
perform (much) better with U=1.

>From the compiler's point of view we have always implemented the
U=1 behaviour, but it has to be done via the alignment fault
handler prior to v6 or with U=0.

> Looking at it from another side, if using the hw unaligned
> access capability gives a performance benefit then it
> would be useful to support it even if gcc doesn't
> behave as documented.  One could still use a special
> unaligned.h for ARMv6 to get the performance benefit.
> (If it doesn't give performance benfit, then why
> bother, let's just use -mno-unaligned-access for v7, too.)

For v7, we should definitely use -munaligned-access where available
(unless it's the default?)

For v6, the question is whether there is any legitimate reason
ever to run the kernel with U=0.  If not, could we explicitly
set it early and build with -munaligned-access where the compiler
supports this?

The only counterargument I can think of is that some people might
be running some ancient userspace which actually relies on the U=0
behaviour.  I don't know whether anyone is actually doing that on
v6, though.

Cheers
---Dave

> In the ARMv6 ARM unaligned support and the U-bit is
> not optional, so you could use the same SoC bus argument
> for some hypothetical v7 SoCs.
> 
> 
> Johannes
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
