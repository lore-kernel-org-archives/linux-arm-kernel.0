From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 13:49:38 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <3461274.sjccN4r7lq@wuerfel>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <20160218223312.GT19428@n2100.arm.linux.org.uk>
 <HK2PR06MB05617E2ED835CFE20F65E3D38AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <3461274.sjccN4r7lq@wuerfel>
Message-ID: <HK2PR06MB0561F8D4A17AAEFEBD774E478AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19 Feb 2016, Arnd Bergmann wrote:

> In a different thread today, I was trying to come up with a way to
> reliably pick a PHYS_OFFSET value, and I think it can be done but it
> quickly gets ugly without extending the Kconfig language.


OK, I see that now (no idea how you guy weed through so many reflector emails)


> Also, the same problem exists in three areas:
> 
> a) PHYS_OFFSET / DRAM_BASE
> b) XIP_PHYS_ADDR
> c) DEBUG_UART_VIRT/DEBUG_UART_PHYS
> 
> The last one is already really ugly and by nature causes problems
> whenever someone enables DEBUG_LL and tries to boot a compressed
> kernel on a platform other than the one that was configured.
> 
> XIP_PHYS_ADDR is probably the worst here, because the number does
> not just depend on the SoC family but the specific board configuration
> and could even change when you rearrange the partitions on your NOR
> flash (unless you enforce that the kernel has to start at the
> beginning of the ROM or some other fixed location).
> 
> It would be nice to handle all three of the above in a similar manner,
> and I'm definitely open to a range of solutions for this, like
> 
> - always allow turning XIP_KERNEL on for all configurations, and
>   expect the user to know what they are doing (as your current
>   patch)

This method is the quickest and easiest (from a kbuild perspective), and I was going with the assumption that the less I modify, less likely I was to break something else.


> - allow turning on XIP_KERNEL as long as Kconfig can figure out that
>   this has a chance of working on at least one platform (easy enough
>   to implement, and similar to how we handle DEBUG_LL).


In the patch I was working on, if ARCH_MULTIPLATFORM was selected (which is the problem I'm trying to solve), you can only select XIP_KERNEL if 'MULTIPLATFORM_XIP_CAPABLE' is selected. At least then we could restrict the multiplatform platforms to ones that stand a chance of XIP booting (or at least have been known to boot at one point or another)

 
> - make XIP_KERNEL and DEBUG_LL depend on either CONFIG_EXPERT or
>   a new "I know this breaks other platforms and I won't complain
>   about that" flag.

A plausible deniability clause. Funny.

 
> - implement a Kconfig method to only allow XIP_KERNEL if exactly
>   one platform is enable that supports it, or if all platforms
>   use the exact same PHYS_OFFSET and XIP_PHYS_ADDR settings.
>   Whether we want to enforce the same thing for DEBUG_LL is a
>   separate matter once that infrastructure exists.
> 
> 	Arnd

This last one would be my favorite.

It would be nice if you could turn a section of "config ARCH_xxx bool" options into "choice" single select with some magical dynamic #ifdef.

if XIP_KERNEL
choice
endif

config DEVICE_A
	bool "Device A"

config DEVICE_B
	bool "Device B"

config DEVICE_C
	bool "Device C"

if XIP_KERNEL
endchoice
endif


...but...this doesn't work:

  arch/arm/mach-shmobile/Kconfig:51: unexpected 'endif' within choice block
  arch/arm/mach-shmobile/Kconfig:131: unexpected 'endchoice' within if block


I need a:

__INLINE__ if XIP_KERNEL
choice
endif




Although...at some point I'd argue that you are trying to cater to a level of safety that is above and beyond XIP_KERNEL. There are probably multiple CONFIG options in the kernel that would break an XIP anyway.

A car with the best seat belts and airbags still won't help you if you drive it off a cliff.


Chris
