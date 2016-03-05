From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Mar 2016 01:19:21 +0100
Subject: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
In-Reply-To: <20160305000225.GB55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
Message-ID: <5158260.vK2YuWzYIn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2016 16:02:25 Brian Norris wrote:
> Hi Arnd,
> 
> I know you're travelling, but...
> 
> On Mon, Jan 25, 2016 at 04:41:50PM +0100, Arnd Bergmann wrote:
> > When XIP_KERNEL is enabled, some functions are defined in the .data
> > ELF section because we require them to be in RAM whenever we communicate
> > with the flash chip. However this causes problems when FTRACE is
> > enabled and gcc emits calls to __gnu_mcount_nc in the function
> > prolog:
> > 
> > drivers/built-in.o: In function `cfi_chip_setup':
> > :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > drivers/built-in.o: In function `cfi_probe_chip':
> > :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > /tmp/ccY172rP.s: Assembler messages:
> > /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
> > /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> > /tmp/ccK4rjeO.s: Assembler messages:
> > /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
> > /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> > make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> > /tmp/ccUvhCYR.s: Assembler messages:
> > /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
> > /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
> 
> Can you provide a sample .config that DOES build correctly with
> XIP_KERNEL enabled + this patch? My first attempt yields some other
> failures I don't care to fixup right now...
> 
> Anyway, I don't doubt you have a good fix here, so I can probably take
> it. Any review from others would be welcome though.

I found the config in the attachment in my logs.

To get this config working, I also needed this hunk from my set of
old unsubmitted patches:

diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
index b3d684098fbf..cb76096a2e36 100644
--- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
+++ b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
@@ -20,7 +20,7 @@
 #define xip_irqpending()	(ICIP & ICMR)
 
 /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
-#define xip_currtime()		(OSCR)
-#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
+#define xip_currtime()		readl_relaxed(OSCR)
+#define xip_elapsed_since(x)	(signed)((readl_relaxed(OSCR) - (x)) / 4)
 
 #endif /* __ARCH_SA1100_MTD_XIP_H__ */

	Arnd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xip-config.gz
Type: application/gzip
Size: 29837 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160305/4fce9742/attachment-0001.gz>
