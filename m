From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 12:27:39 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141024094412.GN27405@n2100.arm.linux.org.uk>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <13842628.d0ipOeqpYt@wuerfel> <20141024094412.GN27405@n2100.arm.linux.org.uk>
Message-ID: <2252625.10hSLNWzvm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 10:44:12 Russell King - ARM Linux wrote:
> On Fri, Oct 24, 2014 at 11:13:27AM +0200, Arnd Bergmann wrote:
> > Ok, that also explains the problems with the missing __linux__ macro, given
> > Ard's reply about bare-metal gcc.
> > 
> > I think we have two choices here:
> > 
> > a) change the buildall script so it actually builds a compiler that behaves
> >    in the way we expect for the kernel (__SIZE_TYPE__ and __linux__ at least,
> >    possibly others)
> > 
> > b) change the kernel to work with the way the bare-metal compiler is built,
> >    adding -D__linux__ in the ARM Makefile and applying Ard's workaround for
> >    __SIZE_TYPE__/__INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__.
> > 
> > Both options are a little hacky and I don't really like them, but I think
> > it makes sense to do one of them.
> 
> Well, (a) is probably the right answer.  EABI had (or still has) the
> idea that enums can be a dynamic size, and this was taken out of the
> Linux version of EABI.  What this means is that an enum used across an
> interface between a compiler targetting Linux and one not targetting
> Linux may not be compatible.

Ah, good point. Maybe we should also add #warning somewhere in an
ARM kernel file that warns about a compiler that doesn't set __linux__.

The alternative would be to add '-D__linux__ -fno-short-enums' to the
gcc flags, which for choice b, which should avoid this difference.

	Arnd
