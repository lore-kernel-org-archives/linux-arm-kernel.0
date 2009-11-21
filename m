From: trd@45mercystreet.com (Toby Douglass)
Date: Sat, 21 Nov 2009 16:21:00 +0100
Subject: CAS implementation may be broken
In-Reply-To: <4AF1FBA4.4070307@xenomai.org>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1FBA4.4070307@xenomai.org>
Message-ID: <4B08055C.3000408@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all -

I may be *utterly* wrong, and I'm expecting that someone here is simply 
going to look at what I'm about to say and explain to me what I've 
misunderstood, but I suspect it may be that atomic compare-and-swap is 
incorrectly implemented in the Linux kernel on ARM v6 and above (e.g. 
using ldrex and strex).

I'm looking at this code, for 2.6.31, which I believe is the latest 
released version;

http://lxr.linux.no/#linux+v2.6.31/arch/arm/include/asm/system.h

  382                do {
  383                        asm volatile("@ __cmpxchg4\n"
  384                        "       ldrex   %1, [%2]\n"
  385                        "       mov     %0, #0\n"
  386                        "       teq     %1, %3\n"
  387                        "       strexeq %0, %4, [%2]\n"
  388                                : "=&r" (res), "=&r" (oldval)
  389                                : "r" (ptr), "Ir" (old), "r" (new)
  390                                : "memory", "cc");
  391                } while (res);

This code is for a four byte CAS; the issue I'm about to describe exists 
similarly for the two byte and one byte CASs.

The issue is the ABA problem.

Imagine you have a populated stack.  Two threads come to pop.  Both read 
the head pointer and the next pointer of the top element and both 
simultaneously come to the point where the are about to CAS, comparing 
the head pointer with the top element pointer and if they match, 
replacing the head pointer with the next pointer of the top element - so 
by this, I mean both threads have just got into the do-while loop above, 
but have not yet executed ldrex.

Now, one thread pauses for a long time.

The other thread pops.  Then a bunch of the other threads pop and push 
and the stack is *totally* different.  Then our initial thread which 
popped *pushes* that original element back.

Finally, our second thread kicks into life.  Remember that his exchange 
pointer is now utterly incorrect, because the stack has completely 
changed.  Now, he's just inside the do-while loop.  He checks the top 
pointer - and lo and behold, it matches the head element.  However, 
because someone else has messed with the top pointer in the meantime, 
the CAS fails - strex refuses to swap, it can see from the shared TLB 
attribute that someone else has touched destination (the top pointer).

So we dodge ABA *there*.

The problem is *we then come round in the do-while loop again*.  We have 
*not* updated our exchange value.  So THIS second time around, we 
*repeat* our strex and we DO swap - and we just swapped in completely 
the wrong next pointer, from way back before the stack was totally 
changed by all the other threads popping and pushing.

So that's the problem.

A common way to solve ABA on contiguous double-word compare-and-swap 
architectures (e.g. x86, x64 and Itanium) is to use a pointer-counter 
pair.  This permits the caller to ensure swaps fail, even if the 
pointers all match, because the counters don't.

Load-linked/conditional-store architectures solve ABA by having the 
store fail if the destination has been touched since the load was performed.

Currently, the code appears to violate this, by repeating the CAS 
*anyway*.  In fact, the appropriate behaviour would seem to be *not* to 
loop, but rather, to issue the ldrex/strex *once*, and indicate to the 
user if the store succeed or failed.

This requires a prototype change, because the return value is the 
original value of the destination and so is unable to indicate, when 
returning that value, if it is returned from a successful or 
unsuccessful swap.
