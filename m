From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Aug 2017 15:07:09 -0400 (EDT)
Subject: [PATCH 0/3] make XIP kernel .data compressed in ROM
In-Reply-To: <SG2PR06MB1165EDDA573890B891E542CB8A9E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <SG2PR06MB1165EDDA573890B891E542CB8A9E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1708281520380.2606@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Aug 2017, Chris Brandt wrote:

> On Friday, August 25, 2017 1, Nicolas Pitre wrote:
> > This patch series provides the ability to store the kernel .data
> > segment compressed in ROM. It has to be copied to RAM anyway so
> > storing it uncompressed is arguably a waste of ROM resources.
> > 
> > While at it, the copying of .data (when not compressed) and the
> > clearing of .bss is performed using optimized string routines rather
> > than doing it one word at a time. And throw in small linker script
> > cleanups for good measure.
> > 
> 
> I like the idea, but unfortunately it won't build for my RZ/A1 
> (CONFIG_ARCH_R7S72100=y) XIP system. It's a Cortex-A9 with MMU (meaning
> you have to hack the Kconfig because apparently allowing
> CONFIG_ARCH_MULTIPLATFORM=y and CONFIG_XIP_KERNEL=y in the same build
> is considered a ridiculous thing to do).

If you want XIP, it is likely that your kernel won't have the same 
physical address across different platforms. It is also likely that the 
RAM offset will be different across different platforms. And the very 
nature of XIP means the kernel cannot be be self-modified to adjust 
those discrepencies like it does in the multiplatform case. And Flash is 
a precious resource so why would you waste it with platform code that 
you'll never execute?

If the Kconfig language could let you confirm that only one platform is 
selected then the XIP config option could be offered only in that case.  
Maybe something like:

config PLATFORM_FOO
	bool "blah"
	select MANY_PLATFORMS if ONE_PLATFORM_SELECTED
	select ONE_PLATFORM_SELECTED

config XIP_KERNEL
	bool "blah"
	depends on !MANY_PLATFORMS

But I don't think the above works and that's unfortunate. For having 
spent some time in the kconfig code a while ago, it shouldn't be hard to 
implement something like incrementable variables but that's not in my 
short term plans.

>   LD      vmlinux
>   SORTEX  vmlinux
>   SYSMAP  System.map
>   XIPZ    arch/arm/boot/xipImage
> data segment doesn't match end of xipImage

OK......... I now know why.

Executive summary: our linker script is a complete mess. In your case 
that would be partly solved by the patch that Arnd sent on Jul 28th 2017 
titled "ARM: move __bug_table into .data for XIP_KERNEL". However the 
XIP linker script is still broken for similar reasons.

I've done a first pass at fixing the worst of it and I'll post a new 
series soon.

@Arnd: please don't send that patch upstream. I have a better fix for 
it now.


Nicolas
