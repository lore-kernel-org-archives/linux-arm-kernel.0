From: n.kinar@usask.ca (Nicholas Kinar)
Date: Sat, 14 May 2011 21:48:08 -0600
Subject: Kernel oops with undefined instruction when accessing memory on an
	AT91 custom system
In-Reply-To: <4DCEE989.4000401@atmel.com>
References: <4DCEADB5.9010905@usask.ca> <4DCEE989.4000401@atmel.com>
Message-ID: <4DCF4CF8.3020209@usask.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre wrote:
> Just a piece of advice about the hardware :
>
> 0/ can you tell us if the very same kernel revision and memtest goes 
> smoothly on an Atmel at91sam9rl-ek board (the Evaluation Kit): if you 
> have one...
> 1/ try to test the same condition with another hardware. If you built 
> several of your custom hardware, running on another chip / board can 
> give clues
> 2/ try the same test with caches disabled (kernel configuration 
> option). That can also give you an idea about the software/hardware 
> location of the issue: be aware that a cache enabled ARM9 does more 
> demanding accesses to the external SDRAM: that can highlight some 
> routing / noise issues.

Thank you very much for your response, Nicolas; this is very much 
appreciated!  To answer your questions:

0/  I do not own an Atmel at91sam9rl-ek board (I wish that I did), but I 
would hope to obtain one of these in the near future.
1/  I am building this hardware for a research project, so I've only 
created only one PCB.  Eventually, I intend to make many more copies of 
this design.
2/  I've tried the same test with all of the caches disabled, and the 
system runs very slowly (and consumes more power).  However, I still 
receive a kernel oops when running the mtest program (the SD card was 
not mounted and the caches were off):

Starting test run with 8 megabyte heap.
Setting up 2048 4096kB pages for test...Unable to handle kernel paging 
request at virtual address bffe974c
pgd = c3368000
[bffe974c] *pgd=00000000
Internal error: Oops: 80000005 [#1]
last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.37 #17)
PC is at 0xbffe974c
LR is at 0x0
pc : [<bffe974c>]    lr : [<00000000>]    psr: 20000013
sp : c3367e88  ip : 00000000  fp : c3073060
r10: c3339e7c  r9 : 00000202  r8 : 4059f000
r7 : 00000000  r6 : c333a0d0  r5 : c02dc000  r4 : c3366000
r3 : 00000000  r2 : 00000000  r1 : 00000030  r0 : 00000030
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005217b  Table: 23368000  DAC: 00000015
Process mtest (pid: 844, stack limit = 0xc3366270)
Stack: (0xc3367e88 to 0xc3368000)
7e80:                   00000001 c0072d98 0000000e ffffffff fefff000 
c0021b94
7ea0: 0000019f c3368000 0000067c c0284000 00000000 40439008 c3ada360 
c3073060
7ec0: 00000817 c333a0d0 4059f008 c3ada360 c3073060 00000817 c3367fb0 
c3073094
7ee0: 00011664 c00273c0 00000801 c0077dfc c0257f38 00011670 00000817 
c3367fb0
7f00: 4059f008 00011630 00011638 c00212e8 40aff000 00000000 c333a0ec 
00000008
7f20: c3073060 c0078724 00100077 c3ada360 c384ee78 c0259948 c384ee70 
c002de78
7f40: c3ada360 c384ee70 c0259910 c384ee70 c3367f7c c38d801c c3ada360 
00000017
7f60: c384ee40 c0259910 00000000 c3ada360 c3367fac c3367f80 c01c2558 
c002ff90
7f80: 00000077 ffffffff 00011670 00011678 00011634 00000000 ffffffff 
00011670
7fa0: 00011678 00011634 00011644 c0021ea0 402fe008 000002a1 002a1000 
00001000
7fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
00011664
7fe0: 00012008 be889d10 402dca64 00008e78 80000010 ffffffff 00000000 
00000000
Code: bad PC value
---[ end trace 505a2dae356acb1c ]---
note: mtest[844] exited with preempt_count 1
BUG: scheduling while atomic: mtest/844/0x40000001
Modules linked in:
[<c00262fc>] (unwind_backtrace+0x0/0xec) from [<c01c22a0>] 
(schedule+0x4c/0x338)
[<c01c22a0>] (schedule+0x4c/0x338) from [<c01c26b8>] 
(_cond_resched+0x3c/0x58)
[<c01c26b8>] (_cond_resched+0x3c/0x58) from [<c0034618>] 
(put_files_struct+0x84/0xe0)
[<c0034618>] (put_files_struct+0x84/0xe0) from [<c0035bb0>] 
(do_exit+0x1a4/0x5d4)
[<c0035bb0>] (do_exit+0x1a4/0x5d4) from [<c0025308>] (die+0x194/0x1c4)
[<c0025308>] (die+0x194/0x1c4) from [<c00272c4>] 
(__do_kernel_fault+0x64/0x84)
[<c00272c4>] (__do_kernel_fault+0x64/0x84) from [<c00275c0>] 
(do_translation_fault+0xa0/0xb0)
[<c00275c0>] (do_translation_fault+0xa0/0xb0) from [<c0021254>] 
(do_PrefetchAbort+0x34/0x94)
[<c0021254>] (do_PrefetchAbort+0x34/0x94) from [<c0021c70>] 
(__pabt_svc+0x50/0x80)
Exception stack(0xc3367e40 to 0xc3367e88)
7e40: 00000030 00000030 00000000 00000000 c3366000 c02dc000 c333a0d0 
00000000
7e60: 4059f000 00000202 c3339e7c c3073060 00000000 c3367e88 00000000 
bffe974c
7e80: 20000013 ffffffff
[<c0021c70>] (__pabt_svc+0x50/0x80) from [<bffe974c>] (0xbffe974c)
Segmentation fault

Here's another kernel oops that I receive when running the mtest program 
(the SD card was not mounted and the caches were off).  This is only a 
few of the many kernel oops that occur:

# ./mtest
Starting test run with 8 megabyte heap.
Setting up 2048 4096kB pages for test...Internal error: Oops - undefined 
instruction: 0 [#1]
last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.37 #17)
PC is at v4wb_clear_user_highpage+0x44/0x7c
LR is at 0x0
pc : [<c0029728>]    lr : [<00000000>]    psr: 20000013
sp : c3369e88  ip : 00000000  fp : c30787e0
r10: c336d8b8  r9 : 00000202  r8 : 4042e000
r7 : 00000000  r6 : c3348e90  r5 : c02dc000  r4 : c3368000
r3 : 00000000  r2 : 00000000  r1 : 00000023  r0 : c2c00740
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005217b  Table: 23384000  DAC: 00000015
Process mtest (pid: 912, stack limit = 0xc3368270)
Stack: (0xc3369e88 to 0xc336a000)
9e80:                   00000001 c0072d98 0000000e 00000000 00000000 
c002c878
9ea0: 0000002e c3384000 000000b8 00000000 00000000 000402d6 402d6000 
c30787e0
9ec0: 00000000 c3348e90 4042e008 c3adb960 c30787e0 00000817 c3369fb0 
c3078814
9ee0: 00011664 c00273c0 00000801 c0077dfc c0257f38 00011670 00000817 
c3369fb0
9f00: 4042e008 00011630 00011638 c00212e8 40adc000 00000000 c3348eac 
0000008b
9f20: c30787e0 c0078724 00100077 c3adb960 c384ee78 c0259948 c384ee70 
c002de78
9f40: c3adb960 c384ee70 c0259910 c384ee70 c3369f7c c38d801c c3adb960 
00000017
9f60: c384ee40 c0259910 00000000 c3adb960 c3369fac c3369f80 c01c2558 
c002ff90
9f80: 00000077 ffffffff 00011670 00011678 00011634 00000000 ffffffff 
00011670
9fa0: 00011678 00011634 00011644 c0021ea0 402db008 00000153 00153000 
00001000
9fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
00011664
9fe0: 00012008 bec08d00 402b9a64 00008e78 80000010 ffffffff 00000000 
00000000
[<c0029728>] (v4wb_clear_user_highpage+0x44/0x7c) from [<c0072d98>] 
(handle_mm_fault+0x1d0/0xaa8)
[<c0072d98>] (handle_mm_fault+0x1d0/0xaa8) from [<c00273c0>] 
(do_page_fault+0xdc/0x1d0)
[<c00273c0>] (do_page_fault+0xdc/0x1d0) from [<c00212e8>] 
(do_DataAbort+0x34/0x94)
[<c00212e8>] (do_DataAbort+0x34/0x94) from [<c0021ea0>] 
(ret_from_exception+0x0/0x10)
Exception stack(0xc3369fb0 to 0xc3369ff8)
9fa0:                                     402db008 00000153 00153000 
00001000
9fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
00011664
9fe0: 00012008 bec08d00 402b9a64 00008e78 80000010 ffffffff
Code: e3a00000 e3a00000 e3a00000 e3a00000 (ee070000)
---[ end trace 505a2dae356acb1c ]---
note: mtest[912] exited with preempt_count 1
BUG: scheduling while atomic: mtest/912/0x40000001
Modules linked in:
[<c00262fc>] (unwind_backtrace+0x0/0xec) from [<c01c22a0>] 
(schedule+0x4c/0x338)
[<c01c22a0>] (schedule+0x4c/0x338) from [<c01c26b8>] 
(_cond_resched+0x3c/0x58)
[<c01c26b8>] (_cond_resched+0x3c/0x58) from [<c0034618>] 
(put_files_struct+0x84/0xe0)
[<c0034618>] (put_files_struct+0x84/0xe0) from [<c0035bb0>] 
(do_exit+0x1a4/0x5d4)
[<c0035bb0>] (do_exit+0x1a4/0x5d4) from [<c0025308>] (die+0x194/0x1c4)
[<c0025308>] (die+0x194/0x1c4) from [<c0021200>] (do_undefinstr+0x154/0x174)
[<c0021200>] (do_undefinstr+0x154/0x174) from [<c0021c04>] 
(__und_svc+0x44/0x60)
Exception stack(0xc3369e40 to 0xc3369e88)
9e40: c2c00740 00000023 00000000 00000000 c3368000 c02dc000 c3348e90 
00000000
9e60: 4042e000 00000202 c336d8b8 c30787e0 00000000 c3369e88 00000000 
c0029728
9e80: 20000013 ffffffff
[<c0021c04>] (__und_svc+0x44/0x60) from [<c0029728>] 
(v4wb_clear_user_highpage+0x44/0x7c)
[<c0029728>] (v4wb_clear_user_highpage+0x44/0x7c) from [<c0072d98>] 
(handle_mm_fault+0x1d0/0xaa8)
[<c0072d98>] (handle_mm_fault+0x1d0/0xaa8) from [<c00273c0>] 
(do_page_fault+0xdc/0x1d0)
[<c00273c0>] (do_page_fault+0xdc/0x1d0) from [<c00212e8>] 
(do_DataAbort+0x34/0x94)
[<c00212e8>] (do_DataAbort+0x34/0x94) from [<c0021ea0>] 
(ret_from_exception+0x0/0x10)
Exception stack(0xc3369fb0 to 0xc3369ff8)
9fa0:                                     402db008 00000153 00153000 
00001000
9fc0: 0001166c 00011670 00011678 00011634 00011644 00011630 00011638 
00011664
9fe0: 00012008 bec08d00 402b9a64 00008e78 80000010 ffffffff
Internal error: Oops - undefined instruction: 0 [#2]
last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
Modules linked in:
CPU: 0    Tainted: G      D      (2.6.37 #17)
PC is at v5tj_early_abort+0x0/0x38
LR is at __dabt_usr+0x38/0x60
pc : [<c0029600>]    lr : [<c0021cd8>]    psr: 90000093
sp : c30b3fb0  ip : 4021c2d0  fp : 000ab008
r10: 00000000  r9 : 00000000  r8 : 000ae170
r7 : 0000000c  r6 : be81c993  r5 : 4024ce6c  r4 : ffffffff
r3 : 20000010  r2 : 4021c30c  r1 : 0000000b  r0 : 00052173
Flags: NzcV  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005217b  Table: 2333c000  DAC: 00000015
Process sh (pid: 836, stack limit = 0xc30b2270)
Stack: (0xc30b3fb0 to 0xc30b4000)
3fa0:                                     0000000b 0000000b 0000000b 
ffff59de
3fc0: 4024284a 4024ce6c be81c993 0000000c 000ae170 00000000 00000000 
000ab008
3fe0: 4021c2d0 be81c968 00036f20 4021c30c 20000010 ffffffff 00000000 
00000000
[<c0029600>] (v5tj_early_abort+0x0/0x38) from [<000ab008>] (0xab008)
Code: 00000000 00000000 00000000 00000000 (ee150000)
---[ end trace 505a2dae356acb1d ]---
Internal error: Oops - undefined instruction: 0 [#3]
last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
Modules linked in:
CPU: 0    Tainted: G      D      (2.6.37 #17)
PC is at v5tj_early_abort+0x0/0x38
LR is at __dabt_svc+0x40/0x60
pc : [<c0029600>]    lr : [<c0021b40>]    psr: 60000093
sp : c3369de0  ip : c02fe2c0  fp : c3078660
r10: c30a9ffc  r9 : 20000013  r8 : befffff0
r7 : 00000000  r6 : c30798b8  r5 : c3369e14  r4 : ffffffff
r3 : a0000013  r2 : c00296f0  r1 : c0072d98  r0 : c3369e28
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005217b  Table: 2307c000  DAC: 00000017
Process init (pid: 913, stack limit = 0xc3368270)
Stack: (0xc3369de0 to 0xc336a000)
9de0: 00000001 befffff0 00000000 00000001 00000001 c02fe2a0 c30798b8 
00000000
9e00: befffff0 000005f7 c30a9ffc c3078660 c02fe2c0 c3369e28 c0072d98 
c00296f0
9e20: a0000013 ffffffff c0273e9c c007b3d4 c3078660 00000001 c30798b8 
c026bccc
9e40: 00000000 00000001 c333efb8 c30798b8 00000000 befffff0 000005f7 
c30a9ffc
9e60: c3078660 c0072d88 c30be440 c3369f08 c3369f48 fffffdee 000001ff 
c333c000
9e80: 000007fc c0082284 00000000 00000000 00000013 c30af200 00000000 
00000000
9ea0: 00000000 c30798b8 00000017 befffff0 c3368000 c3adb960 00000001 
c0073720
9ec0: c3078660 00000020 00000080 c3368000 c33515c0 00000001 00000000 
0000000c
9ee0: 00000000 00000000 c335f00c c0087f80 00000017 c3369f04 00000000 
00000000
9f00: c33515c0 c30be448 00000080 00000ffc 0000000c c335f000 befffff0 
c008810c
9f20: bec2aa74 c33515c0 00000000 00000000 c3368000 c3351670 c335f000 
bf000000
9f40: 00000080 c335f000 00000001 000ab008 c3369fb0 bec2aa7c bec2aa74 
c008827c
9f60: c33515c0 c00883ac c30bea40 00000000 c335f000 bec2aa7c 000ab008 
c3369fb0
9f80: c00220a4 c3368000 00000000 c0024c28 00000001 bec2ac7e bec2ac7e 
00000000
9fa0: 0000000b c0021f20 bec2ac7e bec2ac7e bec2ac7e bec2aa7c 000ab008 
000a9698
9fc0: bec2ac7e bec2ac7e 00000000 0000000b 401d4e6c 0000d5ac 0000beec 
bec2aa74
9fe0: bec2aa78 bec2aa30 401bdefc 4017c05c a0000010 bec2ac7e 00000000 
00000000
[<c0029600>] (v5tj_early_abort+0x0/0x38) from [<c3078660>] (0xc3078660)
Code: 00000000 00000000 00000000 00000000 (ee150000)
---[ end trace 505a2dae356acb1e ]---



Here's another kernel oops that just happened randomly when I was 
typing.  The SD card was mounted when this occurred:

Internal error: Oops - undefined instruction: 0 [#1]
last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.37 #17)
PC is at ubi_sysfs_close+0x2/0xc4
LR is at nand_write_page_raw+0x34/0x3c
pc : [<c016fffe>]    lr : [<c0167a5c>]    psr: 40000033
sp : c3befd88  ip : 000000ff  fp : c3866228
r10: c3878000  r9 : 00000100  r8 : 00000003
r7 : 00000000  r6 : c3bec100  r5 : c386ffff  r4 : c386ffff
r3 : 000000ff  r2 : fffffff0  r1 : c3879500  r0 : c5000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment kernel
Control: 0005217b  Table: 23364000  DAC: 00000017
Process ubifs_bgt1_0 (pid: 786, stack limit = 0xc3bee270)
Stack: (0xc3befd88 to 0xc3bf0000)
fd80:                   c3866228 c3866000 00000033 c0167bd4 c3beb000 
c0267d14
fda0: c3866000 c3866000 c3866228 c3beb000 00001c79 c3866000 00001000 
c3866228
fdc0: c38661f4 c0167df0 00000000 c3866000 c3866228 00001000 00001000 
00000000
fde0: 00001c79 c0168cec 00000000 00000000 00000000 0000000c 0007ffff 
00000000
fe00: 00001c79 0000003f 00000000 00000000 00000080 00000000 c3beb000 
c3beb000
fe20: 00000000 00001000 c3866000 c3866228 00001000 01c79000 00000000 
00000000
fe40: 00000000 c0168ed4 c38661f4 00000050 01279000 00000000 00001000 
c3beb000
fe60: c392a000 c0160c94 00001000 c3befe9c c3beb000 00000002 00038000 
00000049
fe80: 00039000 c0174d38 00001000 c3befe9c c3beb000 c01731cc 00038000 
c3ae02e0
fea0: 00000018 00038000 c3ae02e0 00000018 00038000 c0173cec 00001000 
00000001
fec0: 0902fb54 00000000 c3bee000 c3819be0 00000001 00000001 00000000 
c3819be0
fee0: 00000001 c3819c10 c3adb6a0 c3adb6d0 c3beb000 00000018 c3922600 
00000049
ff00: 00000000 c3adb6d0 c3adb6a0 00000001 00000004 00038000 c3ae02e0 
00000018
ff20: 00001000 c3beb000 00000000 00000002 00000000 c017270c 00038000 
00001000
ff40: 00000002 00000001 00000003 c3ad5088 c3b5b000 c3b5b000 00000001 
00000003
ff60: 00000088 c00e6a28 00001000 00000002 c01c2558 c3ad5088 c3ad50ac 
c3b5b000
ff80: 00000001 c00e6c28 00000004 c3b5b000 c3bee000 c3b5b15c 00000004 
00000003
ffa0: 00000001 c00ee8c0 c00ee854 c3beffd4 c381be14 c3b5b000 c00ee854 
00000000
ffc0: 00000000 c0048dfc c00228e4 00000000 c3b5b000 00000000 c3beffd8 
c3beffd8
ffe0: 00000000 c381be14 c0048d7c c00228e4 00000013 c00228e4 33c8534d 
13cc13cc
[<c016fffe>] (ubi_sysfs_close+0x2/0xc4) from [<c3866000>] (0xc3866000)
Code: c026 9f3c c026 4010 (e92d)


Here is a very strange clue about the problem: using "cp -R", I can 
recursively copy any directory from the root file system to the mounted 
SD card using the AT91 mmc driver.  However, when I try to recursively 
copy a directory from the SD card to the root file system with the 
caches enabled, I receive a kernel oops.  When I turn the caches off, I 
do not receive the kernel oops.

>
>> I've tried a number of different kernels, including linux-2.6.39-rc6 
>> and the official ARM kernel pulled from git.  I've also tried 
>> building with the arm-none-linux-gnueabi-gcc from CodeSourcery, but 
>> similar problems still arise.
>
> You can test a proven kernel going to www.linux4sam.org: but you will 
> need the at91sam9rl-ek to use the binary provided there (sources 
> available also of course).
>
Yes - I would like to test a proven kernel on the at91sam9rl-ek 
hardware, but at this time I do not have the evaluation kit.  Is there a 
"known good" kernel source and binary version of compiler that I could 
download?  I could then build the known good kernel source using the 
binary version of the compiler.  Could you recommend a combination of 
kernel source and compiler that should run on the at91sam9rl-ek hardware?

Once again, thank you very much for your response, Nicolas!

Nicholas
