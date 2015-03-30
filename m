From: dobatog@gmail.com (Gabriel Dobato)
Date: Mon, 30 Mar 2015 09:01:54 +0200
Subject: Fwd: Ask for help: ARM: mvebu: add NAND support for dove
In-Reply-To: <55188BFD.5070908@vanguardiasur.com.ar>
References: <551713D8.3060809@gmail.com> <551714F8.2050401@gmail.com>
 <55188BFD.5070908@vanguardiasur.com.ar>
Message-ID: <5518F4E2.1050505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sebastian,

> #address-cells and #size-cells of &nand below is <1> each, so above
> should be 32b values. If it would be 64b it would have to be split
> into two 32b values anyway.

Yes, you are right. I have to change it.

> As said above, I doubt Dove NFC is fully compatible with Armada 370 NFC.
> Ezequiel can tell for sure, as he probably knows Marvell NFC best.

I am not sure, that's why I am asking for help. Looking at 
Specification, they seem to be similar enough. Ezequiel told me that 
pxa3xx-nand driver should be more or less compatible (using
"marvell,armada370-nand" string for the compatible property).

>
> There is a clock gate for NFC, check Dove FS, Clock Gating Control
> register, bit 10. Above should be:
>
>     clocks = <&gate_clk 10>;

As always, you found it. After changing it :

root at debug:~# flash_eraseall /dev/mtd0
flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please 
use it
Erasing 128 Kibyte @ 1fee0000 -- 99 % complete flash_erase: Skipping bad 
block at 1ff00000
flash_erase: Skipping bad block at 1ff20000
flash_erase: Skipping bad block at 1ff40000
flash_erase: Skipping bad block at 1ff60000
flash_erase: Skipping bad block at 1ff80000
flash_erase: Skipping bad block at 1ffa0000
flash_erase: Skipping bad block at 1ffc0000
flash_erase: Skipping bad block at 1ffe0000
Erasing 128 Kibyte @ 1ffe0000 -- 100 % complete



root at debug:~# nandwrite -p /dev/mtd0 /uImage
Writing data to block 0 at offset 0x0
Writing data to block 1 at offset 0x20000
Writing data to block 2 at offset 0x40000
Writing data to block 3 at offset 0x60000
Writing data to block 4 at offset 0x80000
Writing data to block 5 at offset 0xa0000
Writing data to block 6 at offset 0xc0000
Writing data to block 7 at offset 0xe0000
Writing data to block 8 at offset 0x100000
Writing data to block 9 at offset 0x120000
Writing data to block 10 at offset 0x140000
Writing data to block 11 at offset 0x160000
Writing data to block 12 at offset 0x180000
Writing data to block 13 at offset 0x1a0000
Writing data to block 14 at offset 0x1c0000
Writing data to block 15 at offset 0x1e0000
Writing data to block 16 at offset 0x200000
Writing data to block 17 at offset 0x220000
Writing data to block 18 at offset 0x240000
Writing data to block 19 at offset 0x260000
Writing data to block 20 at offset 0x280000
Writing data to block 21 at offset 0x2a0000
Writing data to block 22 at offset 0x2c0000
Writing data to block 23 at offset 0x2e0000
Writing data to block 24 at offset 0x300000
Writing data to block 25 at offset 0x320000
Writing data to block 26 at offset 0x340000
Writing data to block 27 at offset 0x360000
root at debug:~#

CM-A510>> nboot 200000 nand0 0
no partition number specified

Loading from nand0, offset 0x0
Bad block table found at page 262080, version 0x01
Bad block table found at page 262016, version 0x01
    Image Name:   Linux kernel
    Created:      2015-03-30   6:41:19 UTC
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3637235 Bytes =  3.5 MB
    Load Address: 00008000
    Entry Point:  00008000
CM-A510>> bootm
## Booting kernel from Legacy Image at 00200000 ...
    Image Name:   Linux kernel
    Created:      2015-03-30   6:41:19 UTC
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3637235 Bytes =  3.5 MB
    Load Address: 00008000
    Entry Point:  00008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Booting Linux on physical CPU 0x0
...



> On 30/03/15 01:34, Ezequiel Garcia wrote:
>> Maybe a silly question, but does your bootloader initializes the
>> controller? Are you able to read/write/erase using it?
>>
>> The current pxa3xx-nand driver relies on that for Armada370/XP, as
>> timing setup is not properly handled.

Ezequiel,

Yes, it initializes the controller.


Gabriel Dobato
