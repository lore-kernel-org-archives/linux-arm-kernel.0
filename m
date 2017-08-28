From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 28 Aug 2017 17:40:21 +0000
Subject: [PATCH 0/3] make XIP kernel .data compressed in ROM
In-Reply-To: <20170825162600.15709-1-nicolas.pitre@linaro.org>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
Message-ID: <SG2PR06MB1165EDDA573890B891E542CB8A9E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 25, 2017 1, Nicolas Pitre wrote:
> This patch series provides the ability to store the kernel .data
> segment compressed in ROM. It has to be copied to RAM anyway so
> storing it uncompressed is arguably a waste of ROM resources.
> 
> While at it, the copying of .data (when not compressed) and the
> clearing of .bss is performed using optimized string routines rather
> than doing it one word at a time. And throw in small linker script
> cleanups for good measure.
> 

I like the idea, but unfortunately it won't build for my RZ/A1 
(CONFIG_ARCH_R7S72100=y) XIP system. It's a Cortex-A9 with MMU (meaning
you have to hack the Kconfig because apparently allowing
CONFIG_ARCH_MULTIPLATFORM=y and CONFIG_XIP_KERNEL=y in the same build
is considered a ridiculous thing to do).


  LD      vmlinux.o
  MODPOST vmlinux.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  XIPZ    arch/arm/boot/xipImage
data segment doesn't match end of xipImage
../arch/arm/boot/Makefile:46: recipe for target 'arch/arm/boot/xipImage' failed
make[2]: *** [arch/arm/boot/xipImage] Error 1
arch/arm/Makefile:334: recipe for target 'xipImage' failed
make[1]: *** [xipImage] Error 2
make[1]: Leaving directory '/home/renesas/tools/upstream/renesas-drivers/.out'
Makefile:145: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2


I admit, I did not do any debug yet to find out why.
But if you want to see it, you can simply apply this patch below and 
then build the shmobile_defconfig (after you go in and enable XIP_KERNEL=y 
and XIP_DEFLATED_DATA=y of course).


---------------------------

diff --git a/arch/arm/Kconfigb/arch/arm/Kconfig
index 80191e93f09b..eeb4aa37e8e9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -338,7 +338,7 @@ config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
 	select AUTO_ZRELADDR
 	select TIMER_OF
 	select COMMON_CLK
@@ -1977,7 +1977,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM


Chris
