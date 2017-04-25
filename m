From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Apr 2017 16:35:37 -0700
Subject: Duplicate .plt sections warning with CONFIG_ARM_MODULE_PLTS
Message-ID: <1fb01fb6-3306-1d96-1da0-5b732555dfaf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

While using CONFIG_ARM_MODULES_PLTS=y along with a large kernel module,
I was able to have the kernel/module.c::add_sect_attrs() to complain
about duplicate .plt sections found, each section gets its own sysfs
attribute created under /sys/module/<modname>/sections/<sectname>

And indeed the module has the following section headers and contents
(see below). Is this something that looks legit or should we patch
kernel/module.c to detect such duplicates and generate unique sysfs
attribute section names instead? There does not appear to be any
functional issue with that.

Thanks!

Contents of section .plt:
 0000 00                                   .
Contents of section .init.plt:
 0001 00                                   .
Contents of section .plt:
 0000 00

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg
Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00
0   0  0
  [ 1] .text             PROGBITS        00000000 000034 48d360 00  AX
0   0  4
  [ 2] .rel.text         REL             00000000 68d0c4 14a980 08
48   1  4
  [ 3] .text.unlikely    PROGBITS        00000000 48d394 001a30 00  AX
0   0  4
  [ 4] .rel.text.unlikel REL             00000000 7d7a44 000700 08
48   3  4
  [ 5] .rodata           PROGBITS        00000000 48edc8 0b1fa4 00   A
0   0  8
  [ 6] .rel.rodata       REL             00000000 7d8144 025938 08
48   5  4
  [ 7] .rodata.str1.1    PROGBITS        00000000 540d6c 10b88a 01 AMS
0   0  1
  [ 8] .ARM.extab.text.u PROGBITS        00000000 64c5f8 000060 00   A
0   0  4
  [ 9] .ARM.exidx.text.u ARM_EXIDX       00000000 64c658 000090 00  AL
3   0  4
  [10] .rel.ARM.exidx.te REL             00000000 7fda7c 000148 08
48   9  4
  [11] __ksymtab_strings PROGBITS        00000000 64c6e8 00da64 00   A
0   0  1
  [12] .modinfo          PROGBITS        00000000 65a14c 0000a0 00   A
0   0  4
  [13] __param           PROGBITS        00000000 65a1ec 000020 00   A
0   0  4
  [14] .rel__param       REL             00000000 7fdbc4 000030 08
48  13  4
  [15] .alt.smp.init     PROGBITS        00000000 65a20c 000028 00   A
0   0  4
  [16] .rel.alt.smp.init REL             00000000 7fdbf4 000028 08
48  15  4
  [17] __ex_table        PROGBITS        00000000 65a238 000008 00   A
0   0  8
  [18] .rel__ex_table    REL             00000000 7fdc1c 000010 08
48  17  4
  [19] .ARM.extab        PROGBITS        00000000 65a240 002730 00   A
0   0  4
  [20] .ARM.exidx        ARM_EXIDX       00000000 65c970 01b658 00  AL
1   0  4
  [21] .rel.ARM.exidx    REL             00000000 7fdc2c 01f798 08
48  20  4
  [22] __versions        PROGBITS        00000000 677fc8 001840 00   A
0   0  4
  [23] .note.gnu.build-i NOTE            00000000 679808 000048 00   A
0   0  4
  [24] .plt              PROGBITS        00000000 679850 000001 00  WA
0   0  1
  [25] .init.plt         PROGBITS        00000001 679851 000001 00  WA
0   0  1
  [26] .plt              PROGBITS        00000000 679852 000001 00  WA
0   0  1
  [27] .data             PROGBITS        00000000 679854 0039e8 00  WA
0   0  4
  [28] .rel.data         REL             00000000 81d3c4 001ca0 08
48  27  4
  [29] .init.plt         PROGBITS        00000000 67d23c 000001 00  WA
0   0  1
  [30] .gnu.linkonce.thi PROGBITS        00000000 67d240 000168 00  WA
0   0  4
  [31] .rel.gnu.linkonce REL             00000000 81f064 000010 08
48  30  4
  [32] .bss              NOBITS          00000000 67d3a8 04dbac 00  WA
0   0  8
  [33] .comment          PROGBITS        00000000 67d3a8 009106 01  MS
0   0  1
  [34] .note.GNU-stack   PROGBITS        00000000 6864ae 000000 00   X
0   0  1
  [35] .ARM.attributes   ARM_ATTRIBUTES  00000000 6864ae 000031 00
0   0  1
  [36] __ksymtab         PROGBITS        00000000 6864e0 0036b8 00   A
0   0  4
  [37] .rel__ksymtab     REL             00000000 81f074 006d70 08
48  36  4
  [38] __kcrctab         PROGBITS        00000000 689b98 001b5c 00   A
0   0  4
  [39] .rel__kcrctab     REL             00000000 825de4 0036b8 08
48  38  4
  [40] .debug_info       PROGBITS        00000000 68b6f4 000490 00
0   0  1
  [41] .rel.debug_info   REL             00000000 82949c 000408 08
48  40  4
  [42] .debug_abbrev     PROGBITS        00000000 68bb84 0000f8 00
0   0  1
  [43] .debug_aranges    PROGBITS        00000000 68bc7c 000018 00
0   0  1
  [44] .rel.debug_arange REL             00000000 8298a4 000008 08
48  43  4
  [45] .debug_line       PROGBITS        00000000 68bc94 000190 00
0   0  1
  [46] .debug_str        PROGBITS        00000000 68be24 000900 01  MS
0   0  1
  [47] .shstrtab         STRTAB          00000000 68c724 0001cd 00
0   0  1
  [48] .symtab           SYMTAB          00000000 8298ac 0ffc50 10
49 49732  4
  [49] .strtab           STRTAB          00000000 9294fc 0f5791 00
0   0  1

-- 
Florian
