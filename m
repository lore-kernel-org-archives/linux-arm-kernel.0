From: mboards@prograde.net (Michael Cashwell)
Date: Thu, 29 Apr 2010 13:16:53 -0400
Subject: Decompression failure in an inexplicable case
In-Reply-To: <1272555653.15152.3.camel@e102109-lin.cambridge.arm.com>
References: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
	<1272555653.15152.3.camel@e102109-lin.cambridge.arm.com>
Message-ID: <773E4B72-D9DA-475B-A9BD-6DC540C62325@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 29, 2010, at 11:40 AM, Catalin Marinas wrote:

> On Thu, 2010-04-29 at 16:27 +0100, Michael Cashwell wrote:
>> If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel builds and runs seemingly fine.
>> 
>> But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support then kernel builds OK (including full mrproper cleanings in between):
> 
> I had some issues a few weeks ago with the decompressing:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/73476
> 
> That seemed to do with the size of the Image file and randomly removing parts of it made it work. Unfortunately, I couldn't reproduce it so that others can try.

OK, thank you!  (I was wondering what happened to the ... dots during decompression.)

It was the sense that random size/layout changes were involved that worried me. Contrary to that thread, I'm seeing this with a kernel of about 1.66MB.

-rwxr-xr-x 1 cashwell cashwell  1813956 2010-04-29 12:45 arch/arm/boot/compressed/vmlinux
-rw-rw-r-- 1 cashwell cashwell  1736932 2010-04-29 12:45 arch/arm/boot/uImage
-rwxr-xr-x 1 cashwell cashwell  1736868 2010-04-29 12:45 arch/arm/boot/zImage
-rwxr-xr-x 1 cashwell cashwell 36840120 2010-04-29 12:31 vmlinux

And for me the *smaller* kernel (without cpufreq debugging) fails.

I tried applying Uwe's patches from 2010-02-03 09:41:07 GMT and got this during the build:
arch/arm/boot/compressed/misc.c: In function 'decompress_kernel':
arch/arm/boot/compressed/misc.c:308: warning: passing argument 4 of 'gunzip' from incompatible pointer type
arch/arm/boot/compressed/misc.c:297: warning: unused variable 'tmp'

I fixed those (deleted the tmp variable and change the first arg of the flush function from char * to void * and defined buff by casting the first arg).

That built but I still get:

Bytes transferred = 1736932 (1a80e4 hex)
## Booting image at a2000000 ...
   Image Name:   2.6.33.2-gum1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1736868 Bytes =  1.7 MB
   Load Address: a1000000
   Entry Point:  a1000000
   Verifying Checksum ... OK

Starting kernel at address a1000000 ...

Uncompressing Linux..............................................................................................................

uncompression error

 -- System halted

I've also defined DEBUG in arch/arm/boot/compressed/head.S as Uwe also advised. The output and result was unchanged but the dots progressed much more slowly.

Lastly, I just tried using LZO compression instead as the thread also mentioned. After a quick "sudo yum install lzop" it built. Interestingly it's about 6% larger than with GZIP, but it seems to work better:

TFTP of 'cashwell/netboot/GUM1/boot/uImage' from server 10.18.1.11; our IP address is 10.18.17.1 to address 0xa2000000
Loading: #################################################################
         ################################################################
Bytes transferred = 1883320 (1cbcb8 hex)
## Booting image at a2000000 ...
   Image Name:   2.6.33.2-gum1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1883256 Bytes =  1.8 MB
   Load Address: a1000000
   Entry Point:  a1000000
   Verifying Checksum ... OK

Starting kernel at address a1000000 ...

Uncompressing Linux................. done, booting the kernel.
Linux version 2.6.33.2 (cashwell at mec-fedora12.argon.local) (gcc version 4.3.4 (GCC) ) #1 PREEMPT Thu Apr 29 12:31:38 EDT 2010
CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
Machine: Gumstix Verdex PRO
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c0358ff0, node_mem_map c0376000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
CCSR: 30000310, MDREFR: 201fc031
...

Fewer dots is interesting. But at least this helps me chalk this up to GZIP code being broken somehow.

LZO seems to be the winner.

Thanks!
-Mike
