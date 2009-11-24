From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 16:15:37 +0100
Subject: CAS implementation may be broken
In-Reply-To: <1258989196.8088.28.camel@pc1117.cambridge.arm.com>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
Message-ID: <4B0BF899.7060106@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Sat, 2009-11-21 at 15:21 +0000, Toby Douglass wrote:
>> I may be *utterly* wrong, and I'm expecting that someone here is simply
>> going to look at what I'm about to say and explain to me what I've
>> misunderstood, but I suspect it may be that atomic compare-and-swap is
>> incorrectly implemented in the Linux kernel on ARM v6 and above (e.g.
>> using ldrex and strex).
> 
> Well, you have to define "correctly" or you may just need a different
> function for what you want.

Yeeessss-s-s-s-s-s...

But you can have a situation where you can choose between two 
implementations and although both could be 'correct', one offers more 
functionality than the other - and so is best choice.

I'm coming at this from the POV of implementing lock-free data 
structures.  Essentially, "plain CAS" (as on SPARC, which has neither 
LL/SC nor contiguous double word length CAS) makes implementation 
problematic because you have no straightforward solution to the ABA problem.

Contiguous double word length CAS permits a pointer-counter pair, which 
solves ABA.  LL/SC solves ABA by failing the store if the target has 
been modified since load (I didn't properly realise how this could be 
used to solve ABA until later in this post; there is, I think, a way - I 
describe it later).

Now, it is possible to implement CAS using LL/SC such that it behaves 
exactly like plain CAS - a la SPARC.  I believe this is what exists now.

However, I think it may also possible to implement using LL/SC such that 
ABA is avoided.  If a platform implements CAS using LL/SC *only* a plain 
CAS, then it makes life exceedingly difficult for lock-free data 
structures; and it does so by *not* implementing functionality which 
exists in the CPU which solves ABA!

> In this implementation, CAS is expected to
> succeed if the the old value matches the memory one. The loop is present
> to always guarantee that it will succeed if the condition matches.

Yes.  This is a "plain CAS" implementation.

Interestingly, I saw a day or two ago that there is a double-word 
version of LDREX.  The atomic-ptr project, which forms the basis of the 
GCC garbage collector, relies on this; it does not in fact use LL/SC on 
ARM, but rather uses double-word CAS using a pointer-counter pair.

> Note that the exclusive monitor state is cleared (and hence STREX fails)
> a every context switch or a return from an exception, i.e. interrupt).

Good.  I expected this to be so and it is important to me that it is; 
for by being so, it permits the use of these lock-free data structures 
in interrupt handlers.

>> The issue is the ABA problem.

>> The problem is *we then come round in the do-while loop again*.  We have
>> *not* updated our exchange value.  So THIS second time around, we
>> *repeat* our strex and we DO swap - and we just swapped in completely
>> the wrong next pointer, from way back before the stack was totally
>> changed by all the other threads popping and pushing.
> 
> But the first thread (paused) one may may actually wait before the LDREX
> (the old value was loaded with an LDR), so the LDREX/STREX pair would
> succeed anyway.

I can see my original description of the problem contains an error!  I 
described it first as "both threads pause before LDREX" and then later I 
wrote as if both had in fact executed LDREX.

In fact, what you describe here in the paragraph above is what I 
described in the OP as occurring in the second iteration of the while 
loop (when in fact it can just as well occur in the first iteration, as 
you have here described); namely, you're experiencing ABA - your 
exchange pointer is wrong, but you don't realise it, because the 
destination matches your compare.

So, now I'm puzzled.  I was under the impression it was possible to use 
LL/SC to solve ABA.

Ah - wait - perhaps I see how.  The problem is that the exchange pointer 
is loaded before we become able to see that the destination has changed.

In fact, what's needed here (in this stack example) is that you *load 
the exchange pointer inside the ldrex/strex pair*.

> That's not really a solution unless you also use LDREX
> for loading the old value to be passed to CAS.

Man, you're just way ahead of me :-)  the coffee at ARM must be *really* 
good :-)

But I think you don't need to use LDREX; it's enough just to LDR inside 
the LDREX/STREX pair used on destination.  (This would mean in the CAS 
prototype taking a pointer to the exchange value).

This would mean that if the destination was changed by someone else, 
you'd never use the exchange value; but if it was not, you'd be using 
the current value.

However, this assumes the caller has a linkage between the exchange 
value and the destination; e.g. that if the destination is modified by 
someone else, the exchange must now be wrong.

This I would expect is not always the case and such an implementation 
would no longer be lowest common denominator.

But I wonder...

Imagine we had a CAS where the compare and exchange are passed in as 
pointers and we load what they point to after the LDREX on destination.

What do we have now?

We have a CAS where the exchange and compare are guaranteed to be only 
those which exist continuously and without modification between the 
loading, compare and potential set of the destination.

It is perhaps offering stronger guarantees than necessary in all cases - 
but it actually sounds like a *real* CAS; it says that when we enter the 
CAS, we WILL have the values for compare and exchange which are correct 
at that moment, rather than using historical values.

Is this wrong?  or is it better than x86 style cmpxchg?  can we do 
everything with this that we could do with a CAS which swaps historical 
values?

> IOW, you need your own
> implementation of what you are trying to achieve (and not modifying
> CAS).

On one hand, plain CAS is the basic functionality.  It is all you need 
for some things and indeed, I can imagine for some things, it is 
orthogonal; it is *what you must have* and so it would need to exist.

However, for many things you want an ABA-safe CAS.  I would go as so far 
as to say is a *second* basic functionality, since there is I think more 
use for this than for a non-ABA safe CAS.

Windows offers this simply by offering double-word CAS (and requiring 
developers to use it as a pointer-counter pairing, which is reasonable, 
since you might want to use double-word really as double-word, so it has 
other uses).

ARM offers that as well, but I believe there is no double-word CAS 
support in the kernel.  That would be one route (and indeed it seems odd 
that the current code supports in a switch one, two and four byte CAS, 
but not eight - perhaps is it not available on all >= v6 CPUs?).

The other would be to use the LL/SC functionality as described above. 
The user of the current CAS cannot implement this behaviour on top of 
the CAS that currently exists; he would have to write his own assembly.

My feeling in this, for what it's worth, is that this seems an excessive 
requirement for something which is necessary for lock-free data 
structures; they are becoming important as the number of cores in SMP 
systems continues to double.
