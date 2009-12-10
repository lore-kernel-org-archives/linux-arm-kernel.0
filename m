From: Virupax.SS@Lntemsys.com (Virupax.SS at Lntemsys.com)
Date: Thu, 10 Dec 2009 17:12:56 +0530
Subject: Enabling DEBUG in head.S file makes the kernel work
Message-ID: <OFBC3EDCAB.AF6E2F03-ON65257688.003CA125-65257688.00403272@lntemsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I am using Linux 2.6.27 kernel on  at91sam9g20 Controller. The kernel 
boots fine on all the boards i have here , but on one board kernel does 
not boot and gives 

## Booting kernel from Legacy Image at 20400000 ...
   Image Name:   Linux-2.6.27
   Created:      2009-12-10   6:28:11 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1690656 Bytes =  1.6 MB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
RFS-NAND

Starting kernel ...

Uncompressing 
Linux.............................................................
................................................

crc error

 -- System halted


Error message.

If i add 
#define DEBUG on top of the "arch/arm/boot/compressed/head.S" file, the 
kernel boots up upto the login prompt , but still the login will not be 
possible.
RFS shall not be mounted correctly in this case.


## Booting kernel from Legacy Image at 20400000 ...
   Image Name:   Linux-2.6.27
   Created:      2009-12-10   6:29:18 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1690624 Bytes =  1.6 MB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
RFS-NAND

Starting kernel ...

Uncompressing 
Linux.............................................................
................................................ done, booting the kernel.

41069265:00000658:00055078
201BE040-20509540>20008000
20509540
20008000: E321F0D3 EE109F10 EB000055 E1B0A005  0A000051 EB00006A E1B08005 
0A0000
4E
20008020: EB000079 EB000013 E59FD0BC E28FE000  E28AF010 E3800002 E3A0501F 
EE035F
10
20008040: EE024F10 EA000005 E1A00000 E1A00000  E1A00000 E1A00000 E1A00000 
E1A000
00
20008060: E1A00000 EE010F10 EE103F10 E1A03003  E1A03003 E1A0F00D E59F4064 
E1A000
04
20008080: E3A03000 E2806901 E4803004 E4803004  E4803004 E4803004 E1300006 
1AFFFF
F9
200080A0: E59A7008 E1A06A2F E1873A06 E7843106  E2840A03 E5A03000 E59F6028 
E28000
04
200080C0: E0846926 E1500006 E2833601 94803004  9AFFFFFB E2840A03 E3876202 
E58060
00
200080E0: E1A0F00E 20004000 C0372AA7 C0008114  C0334000 C0334000 C0353500 
C0372A
A8
Linux version 2.6.27 (root at developer-desktop) (gcc version 4.3.2 
(crosstool-NG-1
.3.1) ) #4 Tue Dec 8 12:37:45 IST 2009
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
Machine: Atmel AT91SAM9G20-EK
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 396 MHz, master 132 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 set
..
..
..
...
...
.
(none) login: root
/bin/bash: symbol lookup error: /usr/lib/libncurses.so.5: undefined 
symbol: _nc_`isable_period

(none) login



The below part of the code in the head.S is making the difference between 
the working and non working of the kernel ( w.r.t DEBUG)

#ifndef DEBUG
                orr     r0, r0, #0x000d         @ Write buffer, mmu
#endif
                mov     r1, #-1
                mcr     p15, 0, r3, c2, c0, 0   @ load page table pointer
                mcr     p15, 0, r1, c3, c0, 0   @ load domain access 
control
                b       1f
                .align  5                       @ cache line aligned
1:              mcr     p15, 0, r0, c1, c0, 0   @ load control register
                mrc     p15, 0, r0, c1, c0, 0   @ and read it back to
                sub     pc, lr, r0, lsr #32     @ properly flush pipeline


It will be helpful if some one can point to why the error is there , is it 
because of the faulty board(controller).



Thanks and regards

Virupax




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091210/b616b2d2/attachment-0001.htm>
