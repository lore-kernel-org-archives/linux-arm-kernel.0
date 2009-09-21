From: shinel@foxmail.com (Shine Liu)
Date: Mon, 21 Sep 2009 15:57:10 +0800
Subject: [PATCH] ARM:S3C24XX: Fix a wrong dependency in Kconfig which leads
	to a compile time error
Message-ID: <1253519830.5804.31.camel@shinel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

There's a small mistake in arch/arm/plat-s3c24xx/Kconfig leads to a
compile time error when compiling kernel for S3C24XX mach:

  LD      .tmp_vmlinux1
arch/arm/mach-s3c2440/built-in.o: In function `mini2440_map_io':
mach-mini2440.c:(.init.text+0x4a0): undefined reference to `s3c_device_nand'
arch/arm/mach-s3c2440/built-in.o:(.init.data+0x78c): undefined reference to `s3c_device_nand'
arch/arm/plat-s3c24xx/built-in.o: In function `s3c244x_map_io':
common-smdk.c:(.init.text+0x8e4): undefined reference to `s3c_device_nand'
arch/arm/plat-s3c24xx/built-in.o: In function `smdk_machine_init':
common-smdk.c:(.init.text+0xe44): undefined reference to `s3c_device_nand'
arch/arm/plat-s3c24xx/built-in.o:(.init.data+0x18c): undefined reference to `s3c_device_nand'
make: *** [.tmp_vmlinux1] Error 1

The bug was introduced by the patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=db616eb67604242c11bfbb331bb143bfe4a2e386

Both kernel 2.6.31 and latest linux-next (next-20090918) has the defect.
The following patch will fixed this bug.



Signed-off-by: Shine Liu <shinel@foxmail.com>
Signed-off-by: Shine Liu <liuxian@redflag-linux.com>
----------------------------------------------------

--- a/arch/arm/plat-s3c24xx/Kconfig	2009-09-21 15:09:59.000000000 +0800
+++ b/arch/arm/plat-s3c24xx/Kconfig	2009-09-21 15:10:09.000000000 +0800
@@ -10,7 +10,7 @@
 	default y
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
-	select S3C_DEVICE_NAND
+	select S3C_DEV_NAND
 	help
 	  Base platform code for any Samsung S3C24XX device
 
