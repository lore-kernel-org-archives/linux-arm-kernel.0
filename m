From: pavel@denx.de (Pavel Machek)
Date: Mon, 9 Jul 2012 12:58:38 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <71B37E0559AC6849A68C5BA94C509FB45830BC6785@SJ-ITMSG02.altera.priv.altera.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120704105653.GA20021@elf.ucw.cz>
 <20120704131024.4bb558a3@skate> <20120704112358.GB31490@elf.ucw.cz>
 <71B37E0559AC6849A68C5BA94C509FB45830BC6785@SJ-ITMSG02.altera.priv.altera.com>
Message-ID: <20120709105838.GA12130@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Do you plan to resend a complete v2 with all your patches nicely
> > > rebased? It's not that easy to review such a set of small cleanup
> > > increments :-)
> >
> > Sorry about that. Obviously, complete v2 will follow when major
> > problems are fixed. (We do use git tree for coordination; I guess we
> > should make it public at this point?)
> 
> I'm reworking the patch to use the exisiting
> clocksource/dw_apb_timer driver.

Any news there? I got up-to attached diff, but could not get it to
boot...
									Pavel
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 453a7e2..6f22e0e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -85,6 +85,20 @@
             phy-mode = "gmii";
             };
 
+			rtc0: rtc at 00000 {
+				compatible = "not-there-picochip,pc3x2-rtc";
+				clock-freq = <200000000>;
+				reg = <0x00000 0xf>;
+				interrupts = <8>;
+			};
+
+			timer0: timer at ffd00000 {
+				compatible = "picochip,pc3x2-timer";
+				interrupts = <169>;
+				clock-freq = <200000000>;
+				reg = <0xffd00000 0x14>;
+				interrupt-parent = <&intc>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
index 2ecba67..eeebf2a 100644
--- a/arch/arm/mach-picoxcell/time.c
+++ b/arch/arm/mach-picoxcell/time.c
@@ -106,14 +106,15 @@ static void __init picoxcell_timer_init(void)
 		panic("No timer for clockevent");
 	picoxcell_add_clockevent(event_timer);
 
+#if 0
 	source_timer = of_find_matching_node(event_timer, picoxcell_timer_ids);
 	if (!source_timer)
 		panic("No timer for clocksource");
 	picoxcell_add_clocksource(source_timer);
-
+#endif
 	of_node_put(source_timer);
 
-	picoxcell_init_sched_clock();
+//	picoxcell_init_sched_clock();
 }
 
 struct sys_timer picoxcell_timer = {
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 81358e6..124422d 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -4,6 +4,7 @@ config MACH_SOCFPGA_CYCLONE5
 	select HAVE_SMP
 	select PLAT_SOCFPGA_ETH
 	select COMMON_CLK
+	select DW_APB_TIMER
 	help
 	  Include support for the Altera(R) Cyclone5 development platform.
 
diff --git a/arch/arm/mach-socfpga/common.c b/arch/arm/mach-socfpga/common.c
index ae310a5..7451c6f 100644
--- a/arch/arm/mach-socfpga/common.c
+++ b/arch/arm/mach-socfpga/common.c
@@ -42,6 +42,8 @@
 
 #include "common.h"
 
+#include "../../../arch/arm/mach-picoxcell/time.c"
+
 extern struct dw_mci_board sdmmc_platform_data;
 extern struct dma_pl330_platdata dma_platform_data;
 
@@ -112,6 +114,15 @@ void __init socfpga_timer_init(void __iomem *src_timer_base,
 	writel(0, osc_timer0_va_base + TIMER_CTRL);
 	writel(0, osc_timer1_va_base + TIMER_CTRL);
 
+#if 0
+	/* Fall back to jiffies? */
 	dwapbt_clocksource_init(src_timer_base);
+#endif
+
+#if 0
+	/* Use dt-based code from picoxcell */
 	dwapbt_clockevents_init(event_timer_base, event_timer_irq);
+#endif
+
+	picoxcell_timer_init();
 }
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index d67fc92..9fc89cc 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -118,6 +118,7 @@ static void __init socfpga_cyclone5_timer_init(void)
 
 	socfpga_timer_init(sp_timer0_va_base, osc_timer0_va_base,
 				IRQ_SOCFPGA_L4_OSC1_TIMER0);
+
 #ifdef CONFIG_OF
 	twd_local_timer_of_register();
 #endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
