From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 15:21:11 +0100
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <HK2PR06MB0561F8D4A17AAEFEBD774E478AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <3461274.sjccN4r7lq@wuerfel>
 <HK2PR06MB0561F8D4A17AAEFEBD774E478AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <2413859.DaWDFlIaaB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 13:49:38 Chris Brandt wrote:
> On 19 Feb 2016, Arnd Bergmann wrote:

> > - allow turning on XIP_KERNEL as long as Kconfig can figure out that
> >   this has a chance of working on at least one platform (easy enough
> >   to implement, and similar to how we handle DEBUG_LL).
> 
> 
> In the patch I was working on, if ARCH_MULTIPLATFORM was selected
>  (which is the problem I'm trying to solve), you can only select
> XIP_KERNEL if 'MULTIPLATFORM_XIP_CAPABLE' is selected. At least
> then we could restrict the multiplatform platforms to ones that
> stand a chance of XIP booting (or at least have been known to
> boot at one point or another)

Right, this seems fine to me, and we can combine that with
a Kconfig "choice" statement for picking one of the addresses
for RAM and ROM that are supported by the platforms (there should
ideally only be one of each, making the choice automatic).

> > - implement a Kconfig method to only allow XIP_KERNEL if exactly
> >   one platform is enable that supports it, or if all platforms
> >   use the exact same PHYS_OFFSET and XIP_PHYS_ADDR settings.
> >   Whether we want to enforce the same thing for DEBUG_LL is a
> >   separate matter once that infrastructure exists.
> > 
> > 	Arnd
> 
> This last one would be my favorite.
> 
> It would be nice if you could turn a section of "config ARCH_xxx
> bool" options into "choice" single select with some magical
> dynamic #ifdef.
> 
> if XIP_KERNEL
> choice
> endif
> 
> config DEVICE_A
> 	bool "Device A"
> 
> config DEVICE_B
> 	bool "Device B"
> 
> config DEVICE_C
> 	bool "Device C"
> 
> if XIP_KERNEL
> endchoice
> endif
> 
> 
> ...but...this doesn't work:

We can have 'tristate' inside of 'choice', which lets you pick one or
more the the inner options when they are all 'm', but only one if
one of them is 'y'. I don't think that solves the problem at
hand though, because that breaks the current per-platform submenus
that are not allowed inside of a 'choice'.

> I need a:
> 
> __INLINE__ if XIP_KERNEL
> choice
> endif

> Although...at some point I'd argue that you are trying to cater to a
> level of safety that is above and beyond XIP_KERNEL. There are
> probably multiple CONFIG options in the kernel that would break an
> XIP anyway.

We already turn them off today, mainly any dynamic patching is broken,
and so is the address randomization that Ard is working on, but those
are easy enough to handle.

> A car with the best seat belts and airbags still won't help you
> if you drive it off a cliff.

That was my point about DEBUG_LL: We already allow picking a DEBUG_LL
option that immediately breaks booting on any other platform, and
(worse) breaks even printing any useful output about that fact.

Even allowing XIP_KERNEL unconditionally doesn't make it much worse.

Other options that are able to ruin your day are CONFIG_CPU_BIG_ENDIAN
(which breaks all user space when changed) and CONFIG_ARM_LPAE (which
breaks booting on Cortex-A8/A9/A5 systems), or simply disabling essential
drivers like your console or the block device for your rootfs.

	Arnd
