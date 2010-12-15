From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 02:37:58 +0100
Subject: [PATCH 00/54] ARM irq_data conversion.
In-Reply-To: <20101130131105.GA15575@mail.wantstofly.org>
References: <20101130131105.GA15575@mail.wantstofly.org>
Message-ID: <20101215013758.GR15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:11:05PM +0100, Lennert Buytenhek wrote:

> This patch set converts arch/arm/ irq_chips and flow handlers over
> to the new struct irq_data based irq_chip functions.

I have collected the various ACKs provided in this thread, dropped the
Samsung SoC patches from the queue (hopefully in favor of the patches I
sent on top of the current samsung -next branch today), and put the
result here:

	http://git.kernel.org/?p=linux/kernel/git/buytenh/arm_irq_data.git;a=summary
	git://git.kernel.org/pub/scm/linux/kernel/git/buytenh/arm_irq_data.git master

The most significant change is probably that I tacked the patch
attached below onto the end of the queue.

There exists a merge dependency between the irq_chip users/providers in
arch/arm/ and the irq_chip users/providers in drivers/, in that the
compatibility code in kernel/irq/ only provides compatibility between
old-style irq_chip providers and new-style irq_chip callers, and not
the other way around.

Patches to convert all drivers/gpio/ and drivers/mfd/ irq_chip
implementations to the new-style API have been submitted by me and Mark
Brown, and this queue of ARM irq_data patches semi-depends on those
patches to be merged to avoid the situation where old-style (drivers/)
irq_chip users call into new-style (arch/arm/) irq_chip providers.

A patch to provide API compat in the reverse direction was rejected,
which means that if e.g. the ARM queue gets merged before the drivers/
patches do, we can end up in situations where drivers/ users call into
NULL irq_chip members.

To avoid this, the last patch in this queue selects
GENERIC_HARDIRQS_NO_DEPRECATED, at the suggestion of Yong Zhang on
lkml, so as to catch this type of breakage at compile time rather
than at run time.

This queue is against current -linus -- I'd be happy to rebase it onto
any other branch (arm tree devel?).  If there are no objections, please
pull.

Comments appreciated!


thanks,
Lennert


commit f4195ca70c8881f6fe8d654acd0babb1b2cda5d8
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Mon Nov 29 11:53:39 2010 +0100

    ARM: disable deprecated genirq support.
    
    Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0281d7b..71904d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
 	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select HAVE_SPARSE_IRQ
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
