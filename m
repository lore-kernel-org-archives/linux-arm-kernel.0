From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Nov 2009 21:12:31 +0100
Subject: [PATCH] ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
In-Reply-To: <20091128182439.GB497@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 28 Nov 2009 18:24:39 +0000")
References: <m3zl6owvvi.fsf@intrepid.localdomain>
	<20091128182439.GB497@n2100.arm.linux.org.uk>
Message-ID: <m3skbywgr4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Missed this.
>
> If you want to override a function, it's preferred to do it the way we're
> doing it.
>
> In otherwords, if you want to override a symbol using an inline function.
> Eg:
>
> #ifndef ndelay
> static inline void ndelay(unsigned long x)
> {
>         udelay(DIV_ROUND_UP(x, 1000));
> }
> #define ndelay(x) ndelay(x)
> #endif

I fear someone may want to remove this later thinking that
"#define a() a()" is not necessary.

Also we'd need to test each individual macro in the generic header since
we don't know if having ioread8 also means having other functions.

#ifndef ioread8
define ioread8()
#endif

#ifndef ioread16
define ioread16()
...

etc.

One self-explaining HAVE_IOREAD_AND_IOWRITE has no such problems.

But I can convert to these #ifndef ioread{8,16,etc} of course if you
wish. Please let me know if you want only ioread8 tested, or all of
them respectively.

What is important to me is that the IXP4xx functions are not called
__ixp4xx_something() if they do just the something() (instead of maybe
__raw_something() or __indirect_something()).

Thanks.
-- 
Krzysztof Halasa
