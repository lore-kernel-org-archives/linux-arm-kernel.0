From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 15:56:47 +0100
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <alpine.LFD.2.11.1412040837130.470@knanqh.ubzr>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <2165831.DQoLFmGhIf@wuerfel> <alpine.LFD.2.11.1412040837130.470@knanqh.ubzr>
Message-ID: <2362381.LDAGLC19vb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 08:46:27 Nicolas Pitre wrote:
> On Thu, 4 Dec 2014, Arnd Bergmann wrote:
> Note the above code is for 32-bit architectures that support a 32x32=64 
> bit multiply instruction.  And even then, what kills performances is the 
> inhability to efficiently deal with carry bits from C code.  Hence the 
> far better output from do_div() on ARM.
> 
> If x86-64 has a 64x64=128 bit multiply instruction then the above may 
> greatly be simplified to a single multiply and a shift.  That would 
> possibly outperform do_div().

I was trying this in 32-bit mode to see how it would work in x86-32
kernels. Since that architecture has a 64-by-32 divide instruction,
that gets used here.

x86-64 has a 64x64=128 multiply instruction and gcc uses that for
any 64-bit division by constant, so that's what already happens
in do_div. I assume for any 64-bit architecture, the result will
be similar.

I guess the only architectures that would benefit from your implementation
above are the ones that do not have any optimization for constant
64-by-32-bit division and just call do_div.

> > On a related note, I wonder if we can come up with a more efficient
> > implementation for do_div on ARMv7ve, and I think we should add the
> > Makefile logic to build with -march=armv7ve when we know that we do
> > not need to support processors without idiv.
> 
> Multiplications will always be faster than divisions.  However the idiv 
> instruction would come very handy in the slow path when the divisor is 
> not constant.

Makes sense. I also just checked the gcc sources and it seems that the
idiv/udiv instructions on ARM are not even used for implementing
__aeabi_uldivmod there. Not sure if that's intentional, but we probably
don't need to bother optimizing this in the kernel before user space
does. Building with -march=armv7ve still sounds helpful to avoid the
__aeabi_uidiv calls though.

	Arnd
