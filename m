From: pavel@denx.de (Pavel Machek)
Date: Sun, 1 Jul 2012 20:41:10 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <201206302104.37937.arnd@arndb.de>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <20120627180516.GA17393@elf.ucw.cz> <20120627204018.0bfef362@skate>
 <201206302104.37937.arnd@arndb.de>
Message-ID: <20120701184110.GA30680@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2012-06-30 21:04:37, Arnd Bergmann wrote:
> On Wednesday 27 June 2012, Thomas Petazzoni wrote:
> > > > > +#define NR_IRQS                  512
> > > > 
> > > > You should be looking at using SPARSE_IRQ to avoid having a maximum
> > > > number of irqs. See for example mach-highbank/.
> > > 
> > > Is maximum number of interrupts a problem? 512 does not seem
> > > excessive.
> > 
> > Regardless of the value of NR_IRQS, there is apparently a trend to use
> > SPARSE_IRQ anyway. However, I am not at the best place to explain why
> > SPARSE_IRQ is now considered the right thing to use.
> 
> The main reason for me is to get rid of a hardcoded NR_IRQS constant,
> whihc is a blocker for multiplatform kernels. New platforms should
> do all they can to allow being built together with other platforms
> in the same kernel. While we're not there yet, doing sparse irq
> is an important step in the right direction and should not be hard
> to do for new code.

Something as easy as this? But it does not seem to boot here :-(.

								Pavel

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
index f6498cc..674bac3 100644
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
@@ -133,6 +134,11 @@ static void socfpga_cyclone5_restart(char mode, const char *cmd)
 
 static void __init socfpga_cyclone5_init(void)
 {
+	int i;
+	for (i = 0; i < 512; i++) {
+		dynamic_irq_init(i);
+	}
+
 #ifdef CONFIG_CACHE_L2X0
 	/* 8-way, 64K/way, evmon/parity/share */
 	l2x0_of_init(0x00760000, 0xfe000fff);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
