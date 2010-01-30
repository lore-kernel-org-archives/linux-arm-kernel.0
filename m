From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 30 Jan 2010 18:21:28 +0530
Subject: [PATCH 0/9] Initial multi-omap support for omap4
References: <20100130020036.10590.78028.stgit@baageli.muru.com> 
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0A68EC6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi all,
> >
> > These patches allow compiling in also omap4 into the multi-omap
> > configuration. As I don't yet have omap4, I've only boot tested
> > these on omap2 and omap3.
> >
> > Somebody with an omap4 board please boot test these with the
> > omap3_defconfig and see what happens.. You might want to enable
> > DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.
> Looks like this series have some dependent series because it doesn't
> apply on mainline.
> 
> So I tested this directly on linux-omap "multi-omap4" branch. It boots sufficiently
> but doesn't proceed after "brd_init". Didn't get much time to debug so attached log

Stand alone omap_4430sdp_defconfig also didn't fully boot on the linux-omap "multi-omap4".
The log below shows that the serial platform data isn't configured correctly. 

<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 104) is a ST16654
<6>serial8250.1: ttyS0 at MMIO 0x4806a000 (irq = 105) is a ST16654

Below patch to fix the boot for omap_4430sdp_defconfig. Small typo really.

diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/inclu
index 67ffa08..83dce4c 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -33,7 +33,7 @@

 /* OMAP4 serial ports */
 #define OMAP4_UART1_BASE       OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE       OMAP2_UART1_BASE
+#define OMAP4_UART2_BASE       OMAP2_UART2_BASE
 #define OMAP4_UART3_BASE       0x48020000
 #define OMAP4_UART4_BASE       0x4806e000


For multi-omap build, for now I need to disable 
[*] Reset unused clocks during boot

With this OMAP4430 boots with omap3_defconfig :)

Regards,
Santosh
