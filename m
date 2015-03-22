From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Mar 2015 20:40:55 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <201503222040.56105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 March 2015, Chris Brandt wrote:
> > At first glance, HIGHMEM shouldn't be affected by XIP_KERNEL at all.
> 
> I really didn't find the root cause of this. I just remember looking at the crashed log and it seemed like removing HIGHMEM would fix it....and it did (can't remember the details).
> 
> > However, SMP_ON_UP is incompatible with XIP_KERNEL (as already listed in its dependencies) and building with SMP=y without SMP_ON_UP, and trying to run on UP hardware will definitely fail.
> 
> So, it sounds like you are saying XIP_KERNEL and SMP is not going to happen.
> 
> However, you said:
> > To put that another way:
> > 1. SMP_ON_UP relies on being able to change the kernel text, which it
> >    can't do with an XIP kernel.
> 
> But, what kernel text are we talking about? All of it, or just certain parts?
> What if I changed the linker to put all those files in a specific area and
> then remap that one area to RAM (of course and copy the binary too). Yes,
> sounds pretty hack-ish, but if XIP can't go past single core, it might not
> have a long term future anyway.

XIP should be fine on ARMv7 SMP, which does not require SMP_ON_UP.

Maybe it's enough to describe the dependency in the opposite way and make
XIP_KERNEL depend on !SMP_ON_UP. You should never really need the two
together anyway, since SMP_ON_UP is only needed for kernels that are
meant to run on SMP machines with full SMP support as well as legacy
ARMv6 machines without SMP instructions.
 

	Arnd
