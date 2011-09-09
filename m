From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 9 Sep 2011 17:41:23 +0100
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <alpine.LFD.2.00.1109090919170.20358@xanadu.home>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-3-git-send-email-dave.martin@linaro.org>
	<201109081845.58260.arnd@arndb.de>
	<CAMPhdO82ho2WPrJ3irwLgfPOycQt=kyqK3hhtrLCjOw1vptTrg@mail.gmail.com>
	<20110908172002.GG2070@arm.com>
	<CAMPhdO9USGfrpgR0fXUL6024qWGLqsS72vzaO6AH1oo-TW1RtA@mail.gmail.com>
	<1315562102.7961.5.camel@linaro1>
	<alpine.LFD.2.00.1109090919170.20358@xanadu.home>
Message-ID: <20110909164123.GB3069@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 09:21:28AM -0400, Nicolas Pitre wrote:
> On Fri, 9 Sep 2011, Jon Medhurst (Tixy) wrote:
> 
> > On Thu, 2011-09-08 at 11:49 -0700, Eric Miao wrote:
> > > So the problem is really when compiling this file with existing toolchain,
> > > it's downgrading to v5 compatible mode, and the instruction below
> > > 
> > > sub pc, lr, r1, lsr #32
> > > 
> > > wouldn't be encoded when building a THUMB2 kernel. Considering the
> > > r1, lsr #32 is actually to create an explicit data dependency of the previous
> > > co-processor instruction, would it be one option to rewrite this as something
> > > like:
> > > 
> > > mov r1, r1
> > > mov pc, lr
> > 
> > That doesn't include a data dependency of PC on R1, so it's possible for
> > MOV PC, LR and subsequent instructions to be executed before MOV R1, R1
> > has completed. We would want...
> > 
> > add lr, lr, r1, lsr #32
> > mov pc, lr
> 
> But isn't the first insn unavailable with Thumb2?
> 
> Maybe something like:
> 
> 	sub	r1, r1, r1
> 	add	pc, lr, r1

Thumb-2 implies v7, the v7 implies that we have (and need) a real ISB.  So for the
Thumb-2 case, this should always become

	isb

Ideally, we should do this even for ARM v7 kernels, but in order not to break older
tools which don't understand -march=armv7-a+iwmmxt we may need to use a .long to
encode the ISB manually.  I'll give that a try...

Cheers
---Dave
