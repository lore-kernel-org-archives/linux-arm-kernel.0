From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Oct 2017 17:04:37 +0100
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <20171030155511.GQ20805@n2100.armlinux.org.uk> (Russell King's
 message of "Mon, 30 Oct 2017 15:55:12 +0000")
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <CAKv+Gu95RR3SBb1dydKVVeQQ5+Ui56TcWLfNh=rfmw8_Ty=F7g@mail.gmail.com>
 <87a8083cc2.fsf@free-electrons.com>
 <CAKv+Gu9=xLfyM7ZkK4vNmMkhL2fJnvZmOv-dNNzesk9myadCCA@mail.gmail.com>
 <8760aw3c5p.fsf@free-electrons.com>
 <CAKv+Gu-9pQjBb0YXADRT87qpFb6ttT3tLGBnGNgZj3B1VDRN6Q@mail.gmail.com>
 <871slk3b2k.fsf@free-electrons.com>
 <20171030155511.GQ20805@n2100.armlinux.org.uk>
Message-ID: <877evc1v1m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., oct. 30 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Mon, Oct 30, 2017 at 04:33:07PM +0100, Gregory CLEMENT wrote:
>> Humm no, actually it was with the wrong branch. If I have the patch
>> "ARM: verify size of zImage" then arch/arm/boot/compressed/vmlinux is
>> not generated.
>> 
>> But if I remove this patch then I can generate this file and so:
>> arm-linux-gnueabi-readelf -S ../build/arch/arm/boot/compressed/vmlinux
>> There are 22 section headers, starting at offset 0x4b402c:
>> 
>> Section Headers:
>>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>>   [ 1] .text             PROGBITS        00000000 010000 005ef8 00  AX  0   0 32
>>   [ 2] .rodata           PROGBITS        00005ef8 015ef8 000d4c 00   A  0   0  4
>>   [ 3] .piggydata        PROGBITS        00006c44 016c44 48a552 00   A  0   0  1
>>   [ 4] .got.plt          PROGBITS        00491198 4a1198 00000c 04  WA  0   0  4
>>   [ 5] .got              PROGBITS        004911a4 4a11a4 000028 00  WA  0   0  4
>>   [ 6] .pad              PROGBITS        004911cc 4a11cc 000004 00  WA  0   0  1
>>   [ 7] .bss              NOBITS          004911d0 4a11d0 00001c 00  WA  0   0  4
>>   [ 8] .stack            NOBITS          004911f0 4a11d0 001000 00  WA  0   0  1
>>   [ 9] .comment          PROGBITS        00000000 4a11d0 00001c 01  MS  0   0  1
>>   [10] .ARM.attributes   ARM_ATTRIBUTES  00000000 4a11ec 00002d 00      0   0  1
>>   [11] .debug_line       PROGBITS        00000000 4a1219 00281b 00      0   0  1
>>   [12] .debug_info       PROGBITS        00000000 4a3a34 0066cb 00      0   0  1
>>   [13] .debug_abbrev     PROGBITS        00000000 4aa0ff 0013ea 00      0   0  1
>>   [14] .debug_aranges    PROGBITS        00000000 4ab4f0 0001a8 00      0   0  8
>>   [15] .debug_str        PROGBITS        00000000 4ab698 0019b4 01  MS  0   0  1
>>   [16] .debug_ranges     PROGBITS        00000000 4ad050 000640 00      0   0  8
>>   [17] .debug_frame      PROGBITS        00000000 4ad690 001010 00      0   0  4
>>   [18] .debug_loc        PROGBITS        00000000 4ae6a0 003643 00      0   0  1
>>   [19] .symtab           SYMTAB          00000000 4b1ce4 0015b0 10     20 225  4
>>   [20] .strtab           STRTAB          00000000 4b3294 000cc5 00      0   0  1
>>   [21] .shstrtab         STRTAB          00000000 4b3f59 0000d2 00      0   0  1
>
> I don't like readelf's output - please can you post the output of
> arm-linux-objdump -h ../build/arch/arm/boot/compressed/vmlinux
> instead.
Here it is:

arm-linux-gnueabi-objdump -h  ../build/arch/arm/boot/compressed/vmlinux

../build/arch/arm/boot/compressed/vmlinux:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00005ef8  00000000  00000000  00010000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000d4c  00005ef8  00005ef8  00015ef8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .piggydata    0048a552  00006c44  00006c44  00016c44  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .got.plt      0000000c  00491198  00491198  004a1198  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  4 .got          00000028  004911a4  004911a4  004a11a4  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  5 .pad          00000004  004911cc  004911cc  004a11cc  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  6 .bss          0000001c  004911d0  004911d0  004a11d0  2**2
                  ALLOC
  7 .stack        00001000  004911f0  004911f0  004a11d0  2**0
                  ALLOC
  8 .comment      0000001c  00000000  00000000  004a11d0  2**0
                  CONTENTS, READONLY
  9 .ARM.attributes 0000002d  00000000  00000000  004a11ec  2**0
                  CONTENTS, READONLY
 10 .debug_line   0000281b  00000000  00000000  004a1219  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .debug_info   000066cb  00000000  00000000  004a3a34  2**0
                  CONTENTS, READONLY, DEBUGGING
 12 .debug_abbrev 000013ea  00000000  00000000  004aa0ff  2**0
                  CONTENTS, READONLY, DEBUGGING
 13 .debug_aranges 000001a8  00000000  00000000  004ab4f0  2**3
                  CONTENTS, READONLY, DEBUGGING
 14 .debug_str    000019b4  00000000  00000000  004ab698  2**0
                  CONTENTS, READONLY, DEBUGGING
 15 .debug_ranges 00000640  00000000  00000000  004ad050  2**3
                  CONTENTS, READONLY, DEBUGGING
 16 .debug_frame  00001010  00000000  00000000  004ad690  2**2
                  CONTENTS, READONLY, DEBUGGING
 17 .debug_loc    00003643  00000000  00000000  004ae6a0  2**0
                  CONTENTS, READONLY, DEBUGGING
Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
