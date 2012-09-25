From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Sep 2012 15:44:57 +0000
Subject: [PATCH v2] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <5061CF5A.2030201@parrot.com>
References: <1346413645-4593-1-git-send-email-castet.matthieu@free.fr>
 <201209031257.28213.arnd@arndb.de> <5061CF5A.2030201@parrot.com>
Message-ID: <201209251544.57998.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012, Matthieu CASTET wrote:
> > static inline char __dcc_getchar(void)
> > {
> >         char __c;
> > 
> >         if (__LINUX_ARM_ARCH >= 6)
> >               asm volatile("mrc p14, 0, %0, c0, c5, 0 @ read comms data reg"
> >                       : "=r" (__c));
> >       else
> >               asm volatile ("mrc p14, 0, %0, c1, c0  @ read comms data reg"
> >                       : "=r" (ret));
> >         isb();
> > 
> >         return __c;
> > }
> > 
> >       Arnd
> > 
> Yes doing that will be great!
> 
> But Alan wanted "all be runtime handled".
> 
> May be we can do something like:
> 
> 
> static int cpu_arch;
> 
> static inline char __dcc_getchar(void)
> {
>          char __c;
> 
>          if (cpu_arch >= 6)
>                 asm volatile("mrc p14, 0, %0, c0, c5, 0 @ read comms data reg"
>                         : "=r" (__c));
>         else
>                 asm volatile ("mrc p14, 0, %0, c1, c0  @ read comms data reg"
>                         : "=r" (ret));
>          isb();
> 
>          return __c;
> }

It's not possible to build a kernel that runs on ARMv5 (or below) and also on
ARMv6 (or above), so the effect would be exactly the same. While we are putting
a lot of effort into making all sorts of ARMv6 and ARMv7 based systems work
with the same kernel binary, it's highly unlikely we would ever need the
above to be runtime selected, because there are a lot of other differences
at assembly level.

	Arnd
