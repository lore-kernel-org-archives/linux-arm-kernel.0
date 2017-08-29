From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 29 Aug 2017 19:58:57 +0000
Subject: [PATCH 0/3] make XIP kernel .data compressed in ROM
In-Reply-To: <nycvar.YSQ.7.76.1708281520380.2606@knanqh.ubzr>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <SG2PR06MB1165EDDA573890B891E542CB8A9E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1708281520380.2606@knanqh.ubzr>
Message-ID: <SG2PR06MB116536F14485B36DF66385758A9F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 29, 2017, Nicolas Pitre wrote:
> On Mon, 28 Aug 2017, Chris Brandt wrote:
> 
> > On Friday, August 25, 2017 1, Nicolas Pitre wrote:
> > > This patch series provides the ability to store the kernel .data
> > > segment compressed in ROM. It has to be copied to RAM anyway so
> > > storing it uncompressed is arguably a waste of ROM resources.
> > >
> > > While at it, the copying of .data (when not compressed) and the
> > > clearing of .bss is performed using optimized string routines rather
> > > than doing it one word at a time. And throw in small linker script
> > > cleanups for good measure.
> > >
> >
> > I like the idea, but unfortunately it won't build for my RZ/A1
> > (CONFIG_ARCH_R7S72100=y) XIP system. It's a Cortex-A9 with MMU (meaning
> > you have to hack the Kconfig because apparently allowing
> > CONFIG_ARCH_MULTIPLATFORM=y and CONFIG_XIP_KERNEL=y in the same build
> > is considered a ridiculous thing to do).
> 
> If you want XIP, it is likely that your kernel won't have the same
> physical address across different platforms. It is also likely that the
> RAM offset will be different across different platforms. And the very
> nature of XIP means the kernel cannot be be self-modified to adjust
> those discrepencies like it does in the multiplatform case. And Flash is
> a precious resource so why would you waste it with platform code that
> you'll never execute?

It's not really that I plan on running an XIP_KERNEL on multiple 
different images, it's that if you look at an MMU based system, you have no 
choice but to build it as a ARCH_MULTIPLATFORM in the current Kconfig 
structure.
Of course for my .config, I go in and uncheck every other CPU and driver
that has nothing to do with my system which is why my XIP KERNEL binary
is only 4MB which include all static drivers built in.



> If the Kconfig language could let you confirm that only one platform is
> selected then the XIP config option could be offered only in that case.
> Maybe something like:
> 
> config PLATFORM_FOO
> 	bool "blah"
> 	select MANY_PLATFORMS if ONE_PLATFORM_SELECTED
> 	select ONE_PLATFORM_SELECTED
> 
> config XIP_KERNEL
> 	bool "blah"
> 	depends on !MANY_PLATFORMS


Yes, that's the argument. But, I've tried many different ways with the 
current Kconfig system, and submitted many different patches over the 
last year and a half and not everyone is ever completely happy...so I'm 
stuck with hacking the 2 lines in the Kconfig.
But, that's not what this thread is about.


> But I don't think the above works and that's unfortunate. For having
> spent some time in the kconfig code a while ago, it shouldn't be hard to
> implement something like incrementable variables but that's not in my
> short term plans.

The only way that would seem to make people happy is to make some new 
'Kconfig type', but that's a bit more involved than just editing some 
Kconfig files.


> >   LD      vmlinux
> >   SORTEX  vmlinux
> >   SYSMAP  System.map
> >   XIPZ    arch/arm/boot/xipImage
> > data segment doesn't match end of xipImage
> 
> OK......... I now know why.
> 
> Executive summary: our linker script is a complete mess. In your case
> that would be partly solved by the patch that Arnd sent on Jul 28th 2017
> titled "ARM: move __bug_table into .data for XIP_KERNEL". However the
> XIP linker script is still broken for similar reasons.

Ya, I thought that would happen eventually. The only way I could get 
agreement to fix existing broken XIP_KERNEL stuff was to split the linker 
script into XIP and non-XIP. But, trying to follow every vmlinux.lds.S 
change and checking to see if it is needed for vmlinux-xip.lds.S is a bit 
daunting.


Chris
