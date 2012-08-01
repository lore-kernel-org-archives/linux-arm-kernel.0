From: sandro.viti@gmail.com (Sandro Viti)
Date: Wed, 01 Aug 2012 08:06:40 -0000
Subject: Kernel relocate on beaglebone
Message-ID: <18095ED2-616B-46FB-8404-2E5D344185F2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

i'm trying to relocate kernel to load on a different address than the usual 0x80008000 that is the start of my 256M ddr. The platform is a beaglebone. Kernel is 3.2.21 Debian Squeeze based on Robert CNelson work (http://eewiki.net/display/linuxonarm/BeagleBone).


This is needed for me because i need to reserve 16M at the start of ddr to be used as a special buffer for data to be sent.


This is my output from "cat /proc/iomem" of the standard build:
80000000-8fffffff : System RAM
   80008000-806a6fff : Kernel text
   806e6000-8076fb1b : Kernel data

I tried to change the address where the kernel is loaded, thus the ZRELADDRESS option in the build_kernel.sh to something bigger than 0x80008000, let's say 0x8A008000, but the u-boot loader hangs just after extracting the kernel.
This is the output:
Hit any key to stop autoboot:  0 
SD/MMC found on device 0
reading uEnv.txt

316 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
reading uImage

2658120 bytes read
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   VISALINUX
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2658056 Bytes = 2.5 MiB
   Load Address: 8a008000
   Entry Point:  8a008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

Then it hangs..

I also then tried to tweak values on arch/arm/mach-omap2/Makefile.boot to:

zreladdr-y +: 0x8a008000

params_phys-y := 0x82000100

Initrd_phys-y := 0x82800000

But nothing change

Any of you have some info to share to understand why this is happening and what is the best way to do this shift in kernel loading?

Thanks

Alex Viti
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120801/30c41a73/attachment-0001.html>
