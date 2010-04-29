From: mboards@prograde.net (Michael Cashwell)
Date: Thu, 29 Apr 2010 11:27:03 -0400
Subject: Decompression failure in an inexplicable case
Message-ID: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'm working on a custom 2.6.33.2 port to Gumstix Verdex XL6P (PXA270) that is exhibiting odd behavior.

If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel builds and runs seemingly fine.

But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support then kernel builds OK (including full mrproper cleanings in between):
...
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  AS      arch/arm/boot/compressed/head.o
  GZIP    arch/arm/boot/compressed/piggy.gzip
  CC      arch/arm/boot/compressed/misc.o
  AS      arch/arm/boot/compressed/head-xscale.o
  SHIPPED arch/arm/boot/compressed/lib1funcs.S
  AS      arch/arm/boot/compressed/lib1funcs.o
  AS      arch/arm/boot/compressed/piggy.gzip.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
#### Exporting linux-2.6.33.2-arm-gum to netboot.
Image Name:   2.6.33.2-gum1
Created:      Wed Apr 28 16:12:14 2010
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    1736780 Bytes = 1696.07 kB = 1.66 MB
Load Address: 0xA1000000
Entry Point:  0xA1000000

but fails to run:

TFTP of 'GUM1/boot/uImage' from server 10.18.1.11; our IP address is 10.18.17.1 to address 0xa2000000
Loading: #################################################################
         ######################################################
Bytes transferred = 1736844 (1a808c hex)
## Booting image at a2000000 ...
   Image Name:   2.6.33.2-gum1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1736780 Bytes =  1.7 MB
   Load Address: a1000000
   Entry Point:  a1000000
   Verifying Checksum ... OK

Starting kernel at address a1000000 ...

Uncompressing Linux...

uncompression error

 -- System halted

As noted on another thread, I'm working on cpufreq-pxa2xx.c but I can't see how anything done there could directly cause the decompression to fail. Surely decompression is way too early for any code in cpu-freq to be called. (Yes?)

My hunch is that some subtle image/map linker issue is causing the non-cpufreq-debug case to lay the image out just so the decompressor gets confused but the cause and effect seem so random I'm not sure where to look.

I've seen this sort of thing before on boards where SDRAM is flakey but again, this is an unmodified commercial Gumstix board (in fact, several of them) so this seems unlikely.

I can leave cpufreq debugging compiled in and not pass a "cpufreq.debug=" kernel arg but I don't want to sweep this under the rug.

Anyone have any ideas? Is there any way to get more info from the decompressor or tests I can conduct against the zImage to determine what's wrong?

-Mike
