From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 01 Sep 2015 01:00:39 +0200
Subject: Possible regression: module insertion, relocation misalignement
In-Reply-To: <87egil26sn.fsf@belgarion.home> (Robert Jarzmik's message of
 "Sat, 29 Aug 2015 22:12:08 +0200")
References: <87egil26sn.fsf@belgarion.home>
Message-ID: <87vbbvysfc.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
> Hello,
>
> I have a strange regression with linux-next on module insertion. The stack I get
> when inserting a module is in [3]. I'm using the gcc in [1], and added a small
> print in [2]. This happens on a pxa310 cm-x300 platform.
>
> As far as I understand the Oops, this is an unaligned access on the following
> relocation (0xbf009a26):
> 	*(u32 *)loc += sym->st_value;
>
> This happens regardless of the module I try, by that fat.ko, pxa3xx-nand.ko, etc
> .. I add that I have not changed my toolchain for quite some time.
Hi Russell,

After digging a bit in the problem, and even if I don't understand why this
happens, I know at least _what_ happens. I'd like to know if this is specific to
xscale or a wider problem, hence this mail to you.

The summary of my problem :
 - on linux-next (20150828), module insertion Oopses (see [3])
 - the Oops is as far as I understand an unaligned access (message above)
   It is in arch/arm/kernel/module.h, the line:
		*(u32 *)loc += sym->st_value;
 - the unalignement comes from a relocation in section __bug_table (see [1])
   The address is 0xbf0021ea.
 - the module readelf in [2] shows the relocation in __bug_table

Do you know if other ARM platform are affected, and if an alignement of "1" is
normal for a __bug_table section (as opposed to an alignement of 4) ? And I'm
wondering how it is I have never seen that before also ...

If I have omitted some data, please tell me so that I can complete this report.

Cheers.

-- 
Robert

[1] module.c kernel debug messages
==================================
init_module: umod=000b5018, len=28664, uargs=000b5008
Core section allocation order:
	.text
	.exit.text
	.note.gnu.build-id
	.ARM.extab
	.ARM.exidx
	.rodata.str
	__bug_table
	.ARM.extab.init.text
	.ARM.exidx.init.text
	.ARM.extab.exit.text
	.ARM.exidx.exit.text
	.rodata
	__param
	.rodata.str1.8
	.data
	.gnu.linkonce.this_module
	.bss
Init section allocation order:
	.init.text
	.symtab
	.strtab
final section addresses:
	0xbf0020d0 .note.gnu.build-id
	0xbf000000 .text
	0xbf007000 .init.text
	0xbf0020c4 .exit.text
	0xbf0020f4 .ARM.extab
	0xbf0020f4 .ARM.exidx
	0xbf0021ac .rodata.str
	0xbf0021ea __bug_table
	0xbf002202 .ARM.extab.init.text
	0xbf002204 .ARM.exidx.init.text
	0xbf00220c .ARM.extab.exit.text
	0xbf00220c .ARM.exidx.exit.text
	0xbf002218 .rodata
	0xbf002490 __param
	0xbf0024a8 .rodata.str1.8
	0xbf002938 .data
	0xbf004d00 .gnu.linkonce.this_module
	0xbf004e80 .bss
	0xbf007014 .symtab
	0xbf007aa4 .strtab
Absolute symbol: 0x00000000
Absolute symbol: 0x00000000
...

[2] readelf -Sr pxa3xx_nand.ko
==============================
There are 36 section headers, starting at offset 0x6a58:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .note.gnu.build-i NOTE            00000000 000034 000024 00   A  0   0  4
  [ 2] .text             PROGBITS        00000000 000058 0020c4 00  AX  0   0  4
  [ 3] .rel.text         REL             00000000 006378 0004b8 08   I 34   2  4
  [ 4] .init.text        PROGBITS        00000000 00211c 000014 00  AX  0   0  4
  [ 5] .rel.init.text    REL             00000000 006830 000018 08   I 34   4  4
  [ 6] .exit.text        PROGBITS        00000000 002130 00000c 00  AX  0   0  4
  [ 7] .rel.exit.text    REL             00000000 006848 000010 08   I 34   6  4
  [ 8] .ARM.extab        PROGBITS        00000000 00213c 000000 00   A  0   0  1
  [ 9] .ARM.exidx        ARM_EXIDX       00000000 00213c 0000b8 00  AL  2   0  4
  [10] .rel.ARM.exidx    REL             00000000 006858 0000c0 08   I 34   9  4
  [11] .rodata.str       PROGBITS        00000000 0021f4 00003e 01 AMS  0   0  1
  [12] __bug_table       PROGBITS        00000000 002232 000018 00   A  0   0  1
  [13] .rel__bug_table   REL             00000000 006918 000020 08   I 34  12  4
  [14] .ARM.extab.init.t PROGBITS        00000000 00224a 000000 00   A  0   0  1
  [15] .ARM.exidx.init.t ARM_EXIDX       00000000 00224c 000008 00  AL  4   0  4
  [16] .rel.ARM.exidx.in REL             00000000 006938 000010 08   I 34  15  4
  [17] .ARM.extab.exit.t PROGBITS        00000000 002254 000000 00   A  0   0  1
  [18] .ARM.exidx.exit.t ARM_EXIDX       00000000 002254 000008 00  AL  6   0  4
  [19] .rel.ARM.exidx.ex REL             00000000 006948 000010 08   I 34  18  4
  [20] .rodata           PROGBITS        00000000 002260 000278 00   A  0   0  8
  [21] .modinfo          PROGBITS        00000000 0024d8 000138 00   A  0   0  8
  [22] __param           PROGBITS        00000000 002610 000014 00   A  0   0  4
  [23] .rel__param       REL             00000000 006958 000020 08   I 34  22  4
  [24] .rodata.str1.8    PROGBITS        00000000 002628 000490 01 AMS  0   0  8
  [25] .data             PROGBITS        00000000 002ab8 0023c0 00  WA  0   0  4
  [26] .rel.data         REL             00000000 006978 0000d0 08   I 34  25  4
  [27] .gnu.linkonce.thi PROGBITS        00000000 004e80 000180 00  WA  0   0 32
  [28] .rel.gnu.linkonce REL             00000000 006a48 000010 08   I 34  27  4
  [29] .bss              NOBITS          00000000 005000 000000 00  WA  0   0  4
  [30] .comment          PROGBITS        00000000 005000 000030 01  MS  0   0  1
  [31] .note.GNU-stack   PROGBITS        00000000 005030 000000 00      0   0  1
  [32] .ARM.attributes   ARM_ATTRIBUTES  00000000 005030 00002b 00      0   0  1
  [33] .shstrtab         STRTAB          00000000 00505b 00016a 00      0   0  1
  [34] .symtab           SYMTAB          00000000 0051c8 000a90 10     35 121  4
  [35] .strtab           STRTAB          00000000 005c58 000720 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
...
Relocation section '.rel__bug_table' at offset 0x6918 contains 4 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000202 R_ARM_ABS32       00000000   .text
00000004  00000702 R_ARM_ABS32       00000000   .rodata.str
0000000c  00000202 R_ARM_ABS32       00000000   .text
00000010  00000702 R_ARM_ABS32       00000000   .rodata.str


[3] Backtrace
=============
apply_relocate(): pxa3xx_nand: section 13 reloc 0 sym ''
RJK: apply_relocate():97 dstsec=e49e8c38 dstsec->sh_addr=bf0021ea rel=e49e8918 rel->r_offset=0x0 sec_shdr={addr=0x0 off=0x0 size=0x0 flags=0x0}
Unable to handle kernel paging request at virtual address bf0021ea
pgd = e1cd0000
[bf0021ea] *pgd=c1cce851, *pte=c1cde04f, *ppte=c1cde01f
Internal error: Oops: 23 [#1] ARM
Modules linked in:
CPU: 0 PID: 606 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #887
Hardware name: CM-X300 module
task: e1c68700 ti: e1c3e000 task.ti: e1c3e000
PC is at apply_relocate+0x2f4/0x3d4
LR is at 0xbf0021ea
pc : [<c000e7c8>]    lr : [<bf0021ea>]    psr: 80000013
sp : e1c3fe30  ip : 60000013  fp : e49e8c60
r10: e49e8fa8  r9 : 00000000  r8 : e49e7c58
r7 : e49e8c38  r6 : e49e8a58  r5 : e49e8920  r4 : e49e8918
r3 : bf0021ea  r2 : bf007034  r1 : 00000000  r0 : bf000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: c1cd0018  DAC: 00000051
Process insmod (pid: 606, stack limit = 0xe1c3e198)
Stack: (0xe1c3fe30 to 0xe1c40000)
fe20:                                     ???????? ???????? ???????? ????????
fe40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
fe60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
fe80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
fea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
fec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
fee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ff00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ff20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ff40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ff60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ff80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ffa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ffc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
ffe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
[<c000e7c8>] (apply_relocate) from [<c005ce5c>] (load_module+0x1248/0x1f5c)
[<c005ce5c>] (load_module) from [<c005dc54>] (SyS_init_module+0xe4/0x170)
[<c005dc54>] (SyS_init_module) from [<c000a420>] (ret_fast_syscall+0x0/0x38)
Code: bad PC value
---[ end trace 53a5b8d1316bd52d ]---

[4] gcc version
===============
rj at belgarion:~/mio_linux/kernel$ arm-linux-gnueabi-gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/arm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-linux-gnueabi/4.9/lto-wrapper
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion=' 4.9.2-10' --with-bugurl=file:///usr/share/doc/gcc-4.9/README.Bugs --enable-languages=c,c++,go,fortran,objc --prefix=/usr --program-suffix=-4.9 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.9 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --enable-gnu-unique-object --disable-libitm --disable-libquadmath --enable-plugin --with-system-zlib --enable-objc-gc --enable-multiarch --disable-sjlj-exceptions --with-arch=armv4t --with-float=soft --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=arm-linux-gnueabi --program-prefix=arm-linux-gnueabi-
Thread model: posix
gcc version 4.9.2 ( 4.9.2-10) 
