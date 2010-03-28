From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 28 Mar 2010 15:39:26 +0100
Subject: [PATCH 1/1] [RFCv2] arm: add half-word __xchg
In-Reply-To: <20100328010048.GB12449@Krystal>
References: <20100318135008.GA11800@Krystal>
	<1269535366-25175-1-git-send-email-virtuoso@slind.org>
	<20100327225240.GC13203@n2100.arm.linux.org.uk>
	<20100328001429.GA16697@shareable.org>
	<20100328010048.GB12449@Krystal>
Message-ID: <20100328143926.GE3417@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Desnoyers wrote:
> * Jamie Lokier (jamie at shareable.org) wrote:
> > Russell King - ARM Linux wrote:
> > > I wonder if we should be using __alignof__ here.
> > > 
> > > 	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr &
> > > 		(__alignof__(unsigned long) - 1));
> > 
> > Are there ARM targets with a smaller value from __alignof__()?
> > I think you meant:
> > 
> > 	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr &
> > 		~(unsigned long)(__alignof__(unsigned long) - 1));
> > 
> > Perhaps in asm-generic that has a place.  It would simplify the asm if
> > the alignment is 1 on some machine.
> > 
> > But I don't think it'd happen anyway.  There are machines which don't
> > require full alignment of long, but insufficiently aligned *atomic*
> > accesses like cmpxchg are *not atomic*.  x86 is one such machine.
> 
> I think you mean CMPXCHG8B and CMPXCHG16B ?
> 
> If my memory serves me well, cmpxchg is fine with unaligned accesses on
> x86. But you are right in that other architectures will have a hard time
> with non-aligned cmpxchg. I'm just not sure about x86 specifically.

I'm surprised, I thought I'd read it somewhere, but you're right,
except that CMPXCHG8B also permits arbitrary alignment, as an old
Intel manual states:

    The integrity of the LOCK prefix is not affected by the alignment
    of the memory field. Memory locking is observed for arbitrarily
    misaligned fields.

I didn't check anything about CMPXCHG16.

What I'd misremembered was this:

    To improve performance of applications, AMD64 processors can
    speculatively execute instructions out of program order and
    temporarily hold out-of-order results. However, certain rules are
    followed with regard to normal cacheable accesses on naturally
    aligned boundaries to WB memory.

In other words, the x86 implicit SMP barriers are only guaranteed for
naturally aligned accesses.

ARM does requires naturally aligned atomics, and that's an issue if a
kernel is built for OABI, which has 4-byte alignment for "long long".
Fortunately it throws a noisy alignment fault, rather than being
quietly non-atomic :-)

-- Jamie
