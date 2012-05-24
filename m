From: try2share@gmail.com (K K)
Date: Thu, 24 May 2012 10:52:46 +0530
Subject: Linux Kernel boot up stops after message "Uncompressing
 Linux....done, booting the kernel"
In-Reply-To: <CACZ0kf88Ac8hne9RtLObi624okPw8Nkiv7++Uw8npPLW108mhw@mail.gmail.com>
References: <CACZ0kf88Ac8hne9RtLObi624okPw8Nkiv7++Uw8npPLW108mhw@mail.gmail.com>
Message-ID: <CACZ0kf9yHJOAVEBx4e5dc_eCRT5dScrZHzbkx3_7P2QkzaHChQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We have a lpc-3180 based board and it is up and running fine with 2.6.10
kernel version. We planned to port our board changes into 2.6.32 kernel
version.

As a part of this, we added the architecture dependent  code  (mach
files)  first. Then we changed some of the kernel upgradations.

kernel build successfully. When we booting the board with the new 2.6.32
kernel we are getting following messages and its stops.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

U-Boot 1.1.1 (Oct 10 2006 - 21:35:44)


U-Boot code: 80EC0000 -> 80EE9600  BSS: -> 80EEAEE0

SDRAM : 32M detected

RAM Configuration:

Bank #0: 80000000 31 MB

Bank #1: 00000000  0 kB

Flash:  0 kB

NAND:NAND device: Manufacturer ID: 0x20, Chip ID: 0x35 (ST Micro NAND 32MiB
1,8V 8-bit)

Scanning device for bad blocks

Using default environment


In:    serial

Out:   serial

Err:   serial

Hit any key to stop autoboot:  2 1 0

Boot reached stage 1

## Booting image at 80600000 ...

Boot reached stage 2

Boot reached stage 3

   Image Name:   Linux-2.6.32

   Image Type:   ARM Linux Kernel Image (uncompressed)

   Data Size:    1278856 Bytes =  1.2 MB

   Load Address: 80008000

   Entry Point:  80008000

Boot reached stage 4

Boot reached stage 5

Boot reached stage 6

OK

Boot reached stage 7

Boot reached stage 8

Boot reached stage 14

Boot reached stage 15


Starting kernel ...


Uncompressing
Linux.............................................................................
done, booting the kernel.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

For this we tried to add some debug messages:

The complete scenario is as follows.



We have added some of our own print messages (using putstr() etc.) by
changing the code in  arch/arm/boot/compressed/head.S &
arch/arm/boot/compressed/misc.c files. Then, we  could see those messages
before and after calling  ?decompress_kernel? routine.  So, we moved to the
next stage of the booting i.e. checking the processor type. This is done in
?__lookup_processor_type? routine which can be found in
arch/arm/kernel/head-common.S. Here too, we added one of our prints and
this time using ?printascii? routine as ?putstr? is not usable here. But
these messages are not showing up during the boot log.



This can be caused by two reasons:

1. __lookup_processor_type is not being called.

2. Some of it or entire serial interface initialization is missing.



There is less probability for the first reason. Because, after the
decompression of the kernel, immediately the control is passed to the
extracted kernel. Where ?__lookup_processor_type? is the first routine to
be called (see arch/arm/kernel/head.S line 82 in v2.6.32). So there must be
some problem with the ?printascii? routine itself (i.e. serial
communication).

can you help, where the things may go wrong....

Thanks.

-KK
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120524/ba1dabf9/attachment.html>
