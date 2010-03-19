From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 19 Mar 2010 03:36:01 +0000
Subject: [PATCH 1/1] [RFC] arm: add half-word __xchg
In-Reply-To: <20100319021222.GA17388@Krystal>
References: <20100318123223.GA6855@Krystal>
	<1268919221-2748-1-git-send-email-virtuoso@slind.org>
	<20100318135008.GA11800@Krystal>
	<20100319014906.GC14108@shareable.org>
	<20100319021222.GA17388@Krystal>
Message-ID: <20100319033601.GF14108@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Desnoyers wrote:
> * Jamie Lokier (jamie at shareable.org) wrote:
> > Mathieu Desnoyers wrote:
> > > But.. thinking about it. It's bad to have a 2-byte xchg primitive that
> > > only works on UP and breaks the build on SMP. We should instead
> > > implement a workaround based on __cmpxchg4 to perform the 2-byte xchg().
> > 
> > This exposes why there should be __cmpxchg_bool() versions, which do
> > not loop, preferably in the generic kernel API, because the workaround
> > using __cmpxchg4 has to add yet another pointless loop nesting to all
> > cmpxchg users.
> 
> The workaround I propose is to use __cmpxchg4 in a loop for 2-byte xchg()
> fallback on arm; it is not related to cmpxchg() in any way. I don't
> think one single use-case justifies the creation of a __cmpxchg_bool()
> across all architectures.
> 
> Also, I've never seen where having a cmpxchg primitive returning a
> boolean is more efficient than returning the value read, ever. If we
> have to loop, then we can re-use the value that has been read by
> cmpxchg, while the version returning a boolean would need a read to
> re-read the next value.

Your workaround is an example (but we are both right; the best I can
come up with is described at the end).  This is a version of __xchg2
as you've described (please ignore any irrelevant mistakes :-):

static inline u16 __xchg2(u16 *ptr, u16 new)
{
	int shift = (~(unsigned)ptr & 2) * 8; /* Assumes big-endian. */
	u32 mask = ~(0x0000ffff << shift), add = new << shift;
	u32 *ptrbig = (u32 *)((char *)ptr - ((unsigned)ptr & 2));

	u32 oldbig = *ptrbig;
	while (1) {
		u32 tmp = __cmpxchg4(ptrbig, oldbig, (oldbig & mask) | add);
		if (tmp == oldbig)
			break;
		oldbig = tmp;
	}

	return (u16)(oldbig >> shift);
}

This is __cmpxchg4() from the __cmpxchg() macro in <asm/system.h>,
types changed for sanity:

static inline u32 __cmpxchg4(u32 *ptr, u32 old, u32 new)
{
	u32 oldval, res;
	do {
		asm volatile("@ __cmpxchg4\n"
		"       ldrex   %1, [%2]\n"
		"       mov     %0, #0\n"
		"       teq     %1, %3\n"
		"       strexeq %0, %4, [%2]\n"
			: "=&r" (res), "=&r" (oldval)
			: "r" (ptr), "Ir" (old), "r" (new)
			: "memory", "cc");
	} while (res);
	return oldval;
}

Now let's imagine a __cmpxchg4_bool, which returns non-zero if the new
value was stored, and zero if the new value was not stored:

static inline int __cmpxchg4_bool(u32 *ptr, u32 old, u32 new)
{
	u32 tmp, failed;
	asm volatile("@ __cmpxchg4_bool\n"
	"       ldrex   %1, [%2]\n"
	"       mov     %0, #1\n"
	"       teq     %1, %3\n"
	"       strexeq %0, %4, [%2]\n"
		: "=&r" (res), "=&r" (tmp)
		: "r" (ptr), "Ir" (old), "r" (new)
		: "memory", "cc");
	return !failed;
}

And the alternative loop part of __xchg2 (setup and return aren't
interseting):

	do {
		oldbig = *ptrbig;
	} while (!__cmpxchg4_bool(ptrbig, oldbig, (oldbig & mask) | add);

	
I'm sure you can already see where this is going.

Let's compile __xchg2 using __cmpxchg4 by hand.  We're not interested
in the setup, just the loop, so let's imagine the code starting at
"oldbig = *ptrbig".  The names are all symbolic register names:

	ldr	oldbig, [ptrbig]

	@ start of loop in __xchg2
	and	new, oldbig, mask
	or	new, new, add
1:
	@ start of __cmpxchg4
2:
	ldrex	tmp, [ptrbig]
	mov	res, #0
	teq	tmp, oldbig
	strexeq	res, newbig, [ptrbig]

	@ end of asm, but do..while(res) still needed
	teq	res, #0
	bne	2b
	@ end of __cmpxchg4

	@ remainder of loop in __xchg2
	teq	tmp, oldbig
	mov	oldbig, tmp
	bne	1b

The result is (oldbig >> shift).

Now for comparison, the equivalent part of __xchg2 using __cmpxchg4_bool:

	@ start of loop in __xchg2
1:
	ldr	oldbig, [ptrbig]
	and	new, oldbig, mask
	or	new, new, add

	@ start of __cmpxchg4_bool
	ldrex	tmp, [ptrbig]
	mov	failed, #1
	teq	tmp, oldbig
	strexeq	failed, newbig, [ptrbig]
	@ end of __cmpxchg4_bool (!failed is optimised by caller's !)

	@ remainder of loop in __xchg2
	teq	failed, #0
	bne	1b

As you can see, the bool version has one less loop nesting, and is 9
instructions instead of 11 for the non-bool version because of that.

Although the bool version is shorter, and the double-loop is
pointless, 

You are right that the ldrex result can be recycled to avoid a load
(and is probably faster), although the double-loop is pointless.

Meaning the "ideal" API for the bool-flavoured call would returns
_both_ the old value and whether the new value was stored.  A tidy way
to do that would be to take &old instead, and modify the pointed-to value.

Combining both observations:

static inline int __cmpxchg4_bool2(u32 *ptr, u32 *old, u32 new)
{
	u32 failed;
	asm volatile("@ __cmpxchg4_bool2\n"
	"       ldrex   %1, [%2]\n"
	"       mov     %0, #1\n"
	"       teq     %1, %3\n"
	"       strexeq %0, %4, [%2]\n"
		: "=&r" (res), "=&r" (*old)
		: "r" (ptr), "Ir" (*old), "r" (new)
		: "memory", "cc");
	return !failed;
}

The new loop part of __xchg2:

	u32 oldbig = *ptrbig;
	while (!__cmpxchg4_bool2(ptrbig, &oldbig, (oldbig & mask) | add)) {}

The result (assuming GCC does it's job optimising *&oldbig to oldbig):
	
	ldr	oldbig, [ptrbig]

	@ start of loop in __xchg2
1:
	and	new, oldbig, mask
	or	new, new, add

	@ start of __cmpxchg4_bool2
	ldrex	tmp, [ptrbig]
	mov	failed, #1
	teq	tmp, oldbig
	strexeq	failed, newbig, [ptrbig]
	mov	oldbig, tmp
	@ end of __cmpxchg4_bool2 (!failed is optimised by caller's !)

	@ remainder of loop in __xchg2
	teq	failed, #0
	bne	1b

That eliminates the load and the double-loop.

Quite a lot of __cmpxchg calls in the kernel are like this, with an
unnecessary extra loop, but by no means all are.  It's not just
__xchg2, but obviously all the callers would have to change to take
advantage of a __cmpxchg_bool2-like function.

The difference becomes more evident when writing __cmpxchg2 emulation
using __cmpxchg4.  Then you get an unnecessary *triple* loop at many
call sites: From __cmpxchg4 itself, __cmpxchg2 wrapped around it, and
the caller is also looping.  Only the caller's loop is necessary.

Obviously we can only go so far.  The shortest version of __xchg2 puts
the and+or between ldrex and strex, but that really isn't something
that can be exported safely in an arch-generic way:

	@ start of loop in __xchg2_smallest
1:
	ldrex	oldbig, [ptrbig]
	and	new, oldbig, mask
	or	new, new, add
	strex	failed, newbig, [ptrbig]
	teq	failed, #0
	bne	1b

The difference between 6 instructions and the original's 11, and the
fact it is simple and clear, leads me to suggest using last one as the
ARM version of __xchg2 when {ld,st}rexh are not available.  It's only
downside is it can't go in asm-generic.  That is, unless we had an
__atomic_and_xor() arch function, for asm-generic to use :-)

-- Jamie
