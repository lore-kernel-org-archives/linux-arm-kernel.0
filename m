From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2009 21:03:00 +0000
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <4AF1E01A.2010209@45mercystreet.com>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1E01A.2010209@45mercystreet.com>
Message-ID: <20091104210300.GD518@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2009 at 09:12:10PM +0100, Toby Douglass wrote:
>  382                do {
>  383                        asm volatile("@ __cmpxchg4\n"
>  384                        "       ldrex   %1, [%2]\n"
>  385                        "       mov     %0, #0\n"
>  386                        "       teq     %1, %3\n"
>  387                        "       strexeq %0, %4, [%2]\n"
>  388                                : "=&r" (res), "=&r" (oldval)
>  389                                : "r" (ptr), "Ir" (old), "r" (new)
>  390                                : "memory", "cc");
>  391                } while (res);
>
> The "mov %0, #0" - why is this inbetween the ldrex and strexeq?  it
> seems to me it could just as well happen before the ldrex, and doing so
> would reduce the time between the ldrex and strexeq and so reduce the
> chance of someone else modifying our target.

Because it probably doesn't.  Loads normally have a 'result delay' which
cause a pipeline stall when the result is used in the next instruction.
It makes sense to fill those stall cycles with useful work, rather than
stalling the execution pipeline.
