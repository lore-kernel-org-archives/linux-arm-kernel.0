From: trd@45mercystreet.com (Toby Douglass)
Date: Wed, 04 Nov 2009 21:12:10 +0100
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <20091104190544.GA518@n2100.arm.linux.org.uk>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
Message-ID: <4AF1E01A.2010209@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Nov 04, 2009 at 07:09:37PM +0100, Toby Douglass wrote:
>> This leads me to want to use smp_mb().  However, from what I can see,
>> this macro is only available via the linux kernel headers; it's not
>> available in user-mode.  Is this correct?
> 
> Correct.

Thanks.  It's often hard on the net to track down a negative answer.

[snip]

While we're talking about the GCC atomics...

This appears to be the current code for CAS;

  349        static inline unsigned long __cmpxchg(volatile void *ptr,
unsigned long old, unsigned long new, int size)

  352        unsigned long oldval, res;

[snip]

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

The "mov %0, #0" - why is this inbetween the ldrex and strexeq?  it
seems to me it could just as well happen before the ldrex, and doing so
would reduce the time between the ldrex and strexeq and so reduce the
chance of someone else modifying our target.
