From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 13:23:09 +0200
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <alpine.LFD.2.02.1207101304160.32033@ionos>
References: <20120710094249.GF10225@elf.ucw.cz>
 <alpine.LFD.2.02.1207101304160.32033@ionos>
Message-ID: <20120710112308.GC8701@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > -obj-y					:= common.o time.o
> > +obj-y					:= common.o ../../../drivers/clocksource/dw_apb_timer_of.o
> 
> Urgh! Why can't we just compile it from drivers/clocksource/Makefile ?
> 
> Otherwise, yes please move the code instead of creating a copy.

Ok, what about this?

Would it be ok to submit dw_apb_timer_of.c for merge now, so that
picoxcell can switch to it and upcomming mach-socfpga can use it?

Thanks,
								Pavel

commit eb710d44cc1b9e7a5d5516a87c43c3c0c62a8936
Author: Pavel <pavel@ucw.cz>
Date:   Tue Jul 10 13:21:24 2012 +0200

    Create a config option to avoid compile-from-different-directory hack.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7064f5..dbdf53d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -258,6 +258,7 @@ config ARCH_SOCFPGA
 	select CLKDEV_LOOKUP
 	select CPU_V7
 	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_MACH_CLKDEV
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 239b8a0..a44f4ff 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -2,5 +2,5 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= common.o ../../../drivers/clocksource/dw_apb_timer_of.o
+obj-y					:= common.o
 obj-$(CONFIG_MACH_SOCFPGA_CYCLONE5)	+= socfpga_cyclone5.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 99c6b20..e62bc7e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -16,6 +16,9 @@ config CLKSRC_MMIO
 config DW_APB_TIMER
 	bool
 
+config DW_APB_TIMER_OF
+	bool
+
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer"
 	depends on UX500_SOC_DB8500
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dd3e661..2cdaf7d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
+obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
\ No newline at end of file

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
