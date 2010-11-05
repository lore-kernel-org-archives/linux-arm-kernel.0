From: mkl0301@gmail.com (Lin Mac)
Date: Fri, 5 Nov 2010 11:08:25 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
Message-ID: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the my summary:
1. Booting CNS3420 EVB v 1.3 failed with linux 2.6.36 and .35
2. Build fails if enable DEBUG in head.S. ( but I guess the cause is not in
head.S, since at least "Decompressing" and "booting" is shown.)
3. How should I debug before start_kernel?

Following is the description of the issues:
--------------------------------------
CNS3420 EVB v 1.3
Linux 2.6.36 and 2.6.35
Using arch/arm/configs/cns3420vb_defconfig as default config.
Toolchain is Sourcery G++ Lite for ARM GNU/Linux, arm-2010-q1 and
arm-2009-q1

My u-boot use following bootcmd to boot image:
---
set kfile bootpImage;
set ramaddr 4000000;
set bootcmd mmc\;fatload mmc 0 \$(ramaddr) \$(kfile)\; go
\$(ramaddr);saveenv;
---
As for the ramaddr, I've tried 0x10000, 0x80000, 0x100000, 0x200000,
0x4000000. All failed.

The u-boot message:
--
U-Boot 2008.10-mpcore-00653-g4f9d01a (Sep 17 2010 - 22:19:25)
Cavium Networks CNS3XXX SDK v1.0-1462

CPU: Cavium Networks CNS3000
ID Code: 410fb024 (Part number: 0xB02, Revision number: 4)
CPU ID: 900
Chip Version: c

DRAM:  256 MB
Flash: 128 MB
In:    serial
Out:   serial
Err:   serial
CPU works at 600 MHz (600/1/1)
DDR2 Speed is 400 MHz
Hit any key to stop autoboot:  0
mmc_init
Detected SD Card
reading bootpImage

9363530 bytes read
enter do_eth_down!!!
## Starting application at 0x04000000 ...
Uncompressing Li done, booting t
--

With RVDS, the CPU stops at:
--
PC=0x815c
...
0x815c: E1A00000: MOV r0,r0
0x8560: E28F3048: B 0x815c
...
--
The assembly seems really wrong, but I don't know where is it in the code.

So I tried to enable DEBUG in head.S with following patch:
----
diff --git a/arch/arm/boot/compressed/head.S
b/arch/arm/boot/compressed/head.S
index c5191b1..fbd04c1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -17,6 +17,7 @@
  * 100% relocatable.  Any attempt to do so will result in a crash.
  * Please select one of the following when turning on debugging.
  */
+#define DEBUG
 #ifdef DEBUG

 #if defined(CONFIG_DEBUG_ICEDCC)
----

Then it failed at building:
----
  AS      arch/arm/boot/compressed/lib1funcs.o
arch/arm/boot/compressed/head.S: Assembler messages:
arch/arm/boot/compressed/head.S:1019: Error: too many positional arguments
arch/arm/boot/compressed/head.S:1036: Error: too many positional arguments
make[3]: *** [arch/arm/boot/compressed/head.o] Error 1
----

Best Regards,
Mac Lin
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101105/2f70c3cb/attachment.html>
