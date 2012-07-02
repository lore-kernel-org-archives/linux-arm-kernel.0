From: pavel@denx.de (Pavel Machek)
Date: Mon, 2 Jul 2012 23:53:32 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <201207021652.52787.arnd@arndb.de>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201206302104.37937.arnd@arndb.de>
 <20120701184110.GA30680@elf.ucw.cz>
 <201207021652.52787.arnd@arndb.de>
Message-ID: <20120702215331.GA6173@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >  static void __init socfpga_cyclone5_init(void)
> >  {
> > +       int i;
> > +       for (i = 0; i < 512; i++) {
> > +               dynamic_irq_init(i);
> > +       }
> > +
> >  #ifdef CONFIG_CACHE_L2X0
> >         /* 8-way, 64K/way, evmon/parity/share */
> >         l2x0_of_init(0x00760000, 0xfe000fff);
> > 
> 
> This looks wrong, I think what you should do instead is
> to call irq_domain_add_legacy() for each controller you
> register as the first step, and then try to convert the
> controllers to use irq_domain_add_linear() as the second
> step. See also Documentation/IRQ-domain.txt.

Stupid me, GIC already has irq_domain support, so the switch to
sparse_irq is as simple as:

							Pavel

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1578e1..d203253 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -263,6 +263,7 @@ config ARCH_SOCFPGA
 	select GPIO_PL061 if GPIOLIB
 	select NEED_MACH_MEMORY_H
 	select USE_OF
+	select SPARSE_IRQ
 	help
 	  This enables support for Altera SOCFPGA Cyclone V platform
 
diff --git a/arch/arm/mach-socfpga/include/mach/irqs.h b/arch/arm/mach-socfpga/include/mach/irqs.h
index da50124..565ca59 100644
--- a/arch/arm/mach-socfpga/include/mach/irqs.h
+++ b/arch/arm/mach-socfpga/include/mach/irqs.h
@@ -27,8 +27,6 @@
 #define IRQ_SOCFPGA_CLK_MAN            (IRQ_SOCFPGA_GIC_START + 173)   /* Clock manager */
 
 
-#define NR_IRQS			512
-
 #define MAX_GIC_NR		1
 
 #endif	/* __MACH_IRQS_H */
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index f6498cc..d8cd89b 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -24,6 +24,7 @@
 #include <mach/socfpga-timer.h>
 #include <mach/dw_apb_timer.h>
 #include <mach/socfpga_cyclone5.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
