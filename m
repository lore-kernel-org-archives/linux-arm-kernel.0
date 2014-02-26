From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Feb 2014 14:46:05 +0100
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <20140226111507.GW21483@n2100.arm.linux.org.uk>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140226111507.GW21483@n2100.arm.linux.org.uk>
Message-ID: <20140226134605.GF6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 11:15:07AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 12:11:20PM +0100, Uwe Kleine-K?nig wrote:
> > The toolchain problem described in commit f6537f2f0eba
> > (scripts/kallsyms: filter symbols not in kernel address space) makes it
> > necessary to filter out some kernel symbols from /proc/kallsyms to make
> > perf happy.
> > 
> > For that to work correctly the address used to filter should be just
> > below the kernel text segment. Depending on kernel configuration
> > CONFIG_PAGE_OFFSET is not the right address to use. See the comments
> > introduced by this commit for the glory details.
> 
> Is there any reason why PAGE_OFFSET should not be DRAM_BASE for nommu?
Nothing I'm aware of[1]. Talking to Arnd earlier today on irc:

1393409816 < ukleinek> arnd: PAGE_OFFSET doesn't make much sense on
		!MMU, does it?
1393409828 < arnd> no
1393409844 < arnd> but I think we just set it to PHYS_OFFSET normally
1393409864 < arnd> which does the right thing, except with XIP_KERNEL,
		where the kernel doesn't actually run from RAM

PAGE_OFFSET is only set to PLAT_PHYS_OFFSET (for !MMU) in
arch/arm/include/asm/memory.h which in turn is set to CONFIG_PHYS_OFFSET
which is:

	hex "Physical address of main memory" if MMU
	...
	default DRAM_BASE if !MMU

So yes, I think we can do:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1595,6 +1595,7 @@ endchoice
 
 config PAGE_OFFSET
 	hex
+	default DRAM_BASE if !MMU
 	default 0x40000000 if VMSPLIT_1G
 	default 0x80000000 if VMSPLIT_2G
 	default 0xC0000000

and then drop the MMU case in the patch that is discussed here and also
simplify a few other locations. I'll test a bit with this and then send
it out with a few other fixes I have in the queue.

For stable I'd still suggest not to do this though but stick to the
original patch that started this thread.

Best regards
Uwe

[1] maybe apart from being only one of serveral things that could be
improved for !MMU.
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
