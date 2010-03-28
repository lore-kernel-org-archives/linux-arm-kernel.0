From: mathieu.desnoyers@polymtl.ca (Mathieu Desnoyers)
Date: Sat, 27 Mar 2010 21:00:48 -0400
Subject: [PATCH 1/1] [RFCv2] arm: add half-word __xchg
In-Reply-To: <20100328001429.GA16697@shareable.org>
References: <20100318135008.GA11800@Krystal>
	<1269535366-25175-1-git-send-email-virtuoso@slind.org>
	<20100327225240.GC13203@n2100.arm.linux.org.uk>
	<20100328001429.GA16697@shareable.org>
Message-ID: <20100328010048.GB12449@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Lokier (jamie at shareable.org) wrote:
> Russell King - ARM Linux wrote:
> > I wonder if we should be using __alignof__ here.
> > 
> > 	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr &
> > 		(__alignof__(unsigned long) - 1));
> 
> Are there ARM targets with a smaller value from __alignof__()?
> I think you meant:
> 
> 	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr &
> 		~(unsigned long)(__alignof__(unsigned long) - 1));
> 
> Perhaps in asm-generic that has a place.  It would simplify the asm if
> the alignment is 1 on some machine.
> 
> But I don't think it'd happen anyway.  There are machines which don't
> require full alignment of long, but insufficiently aligned *atomic*
> accesses like cmpxchg are *not atomic*.  x86 is one such machine.

I think you mean CMPXCHG8B and CMPXCHG16B ?

If my memory serves me well, cmpxchg is fine with unaligned accesses on
x86. But you are right in that other architectures will have a hard time
with non-aligned cmpxchg. I'm just not sure about x86 specifically.

Thanks,

Mathieu

> Fortunately GCC aligns the types sufficiently well - and we rely on
> that all over the kernel.
> 
> I'm not sure about ARM, when doing a 64-bit cmpxchg, if the doubleword
> must be 64-bit aligned to get atomicity.
> 
> Note that the posted code doesn't work as is for 64-bit longs: the
> "mask" calculation overflows if called with size >= 4.
> 
> But seeing as this is for ARM only at present, I'd just change the
> types to u32 and be done with it.  It does seem like a good thing to
> go to asm-generic eventually though.
> 
> -- Jamie

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
