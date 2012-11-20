From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:00:51 +0100
Subject: [PATCH v4] Introduce irqchip infrastructure
Message-ID: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of patches that introduces a small irqchip
infrastructure that allows the registration of irqchip drivers without
having each of those drivers to expose a public API and header in
include/linux/irqchip/, and moves a number of existing irqchip
controller to this infrastructure.

This new version (detailed changelog below) provides a number of
improvements: usage of a special link section to avoid the central
registration in irqchip.{c,h} of all irqchip drivers, and addition of
the GIC, VIC and Versatile FPGA IRQ drivers move, thanks to Rob
Herring and Linus Walleij.

Remaining issues to solve:

 * Russell would like arch/arm/include/asm/hardware/vic.h and
   arch/arm/include/asm/hardware/gic.h to move elsewhere, since the
   corresponding code is no longer in arch/arm/. I can move them in
   <linux/irqchip>, but that will cause a fairly large change as there
   are a big number of users of those headers in arch/arm.

 * The arch/arm/include/asm/hardware/vic.h has a few offset macros
   that should move into the .c file of the irqchip driver, but some
   of those offsets are bizarrely used in some other pieces of code in
   arch/arm/.

 * How to get rid entirely of the headers in <linux/irqchip/>. The
   remaining problematic functions are <foo>_handle_irq() and
   <foo>_irq_init() that are used by non-DT platforms. And the special
   case of gic_cascade_irq().

 * Move all the users of gic_of_init() to the irqchip mechanism
   (Exynos, i.MX 6, MSM, OMAP, SH Mobile, socfpga, spear13xx, tegra,
   ux500, vexpress) so that gic_of_init() no longer has to be
   exported.

Of course, I don't expect any of this to go in 3.8, it is 3.9 material
if we manage to reach a consensus on the remaining issues to solve
(and the other issues that will certainly show up or be raised by
other people).

This series has been built and boot tested for BCM2835 and Armada
XP. It has been built tested on Versatile with OF and without OF,
spear3xx, spear6xx and a multi_v6_v7 configuration with all possible
architectures enabled (therefore including picoxcell).

Changes since v3:

 * Switch to a link-trick based registration of the irqchip drivers,
   using the IRQCHIP_DECLARE() macro.

 * Integrate Rob Herring's patches to move the GIC and VIC irq
   controller drivers in drivers/irqchip/.

 * Migrate picoxcell, spear3xx and spear6xx to using the irqchip
   platform, so that no direct user of vic_of_init() remains.

 * Don't export vic_of_init() anymore: all users go through
   irqchip_init() now.

 * Integrate Linus Walleij patch that moves the Versatile FPGA irq
   controller driver to drivers/irqchip.

 * A set_handle_irq() ARM function was added to properly set the
   handle_arch_irq pointer to the right handler of the parent IRQ
   controller.

Changes since v2:

 * Fixed the entry in the MAINTAINERS file. Noticed by Rob Herring.

 * Simplified the Kconfig logic by making the IRQCHIP option enabled
   by default as soon as OF_IRQ is enabled. The individual ARCH_<foo>
   Kconfig options no longer have to select IRQCHIP. Also, the option
   was renamed from USE_IRQCHIP to just IRQCHIP. Suggested by Rob
   Herring.

 * Added Reviewed-by tags given by Rob Herring.

Changes since v1:

 * Add a new patch mentionning the drivers/irqchip in the list of
   directories part of the IRQ subsystem maintained by Thomas Gleixner
   in the MAINTAINERS file. Requested by Arnd Bergmann.

 * Reduce the amount of code movement in the irq-bcm2835.c and
   irq-armada-370-xp.c files by using one forward declaration for the
   IRQ handling entry point. Requested by Stephen Warren.

 * Rename the armctrl_of_init() function to bcm2835_irqchip_init() as
   requested by Stephen Warren.

 * Added the formal Acked-by and Reviewed-by received from Stephen
   Warren.

Thanks,

Thomas
