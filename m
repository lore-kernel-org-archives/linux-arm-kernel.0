From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 15:08:42 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B08055C.3000408@45mercystreet.com>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1FBA4.4070307@xenomai.org> <4B08055C.3000408@45mercystreet.com>
Message-ID: <20091123150842.GD18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 04:21:00PM +0100, Toby Douglass wrote:
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
> The problem is *we then come round in the do-while loop again*.  We have  
> *not* updated our exchange value.  So THIS second time around, we  
> *repeat* our strex and we DO swap - and we just swapped in completely  
> the wrong next pointer, from way back before the stack was totally  
> changed by all the other threads popping and pushing.

First time around the loop, lets say %3 = 1 *(u32 *)%2 = 1.

	ldrex	%1, [%2]
				%1 = *(u32 *)%2 (= 1)
	mov	%0, #0
				%0 = 0
	teq	%1, %3
				%3 == %1? (yes)
	strexeq	%0, %4, [%2]
				executed but because of the other access,
				exclusivity fails. *(u32 *)%2 not written
				and %0 = 1

So, res = 1, and we go around the loop again.  Lets say that *(u32 *)%2 = 2
now.

	ldrex	%1, [%2]
				%1 = *(u32 *)%2 (= 2)
	mov	%0, #0
				%0 = 0
	teq	%1, %3
				%3 == %1? (no)
	strexeq	%0, %4, [%2]
				not executed at all, %0 and *(u32 *)%2 untouched

So, res = 0 and we do _not_ repeat the loop and return "cmpxchg" failure.

I haven't had time to read all your email properly (due to the need to
get on a conference call), but please tell me where the problem is above
(using a similar worked example).

Thanks.
