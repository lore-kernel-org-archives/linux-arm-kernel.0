From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Feb 2013 16:04:58 -0200
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <20130207125801.GA19091@S2101-09.ap.freescale.net>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 10:58 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Feb 07, 2013 at 09:47:58AM -0200, Fabio Estevam wrote:
>> Hi,
>>
>> When booting linux-next 20130207 I get no kernel console output on a
>> mx28evk. After selecting earlyprintk and CONFIG_DEBUG_LL=y support I
>> get:
>>
>>   LD      vmlinux
>>   SORTEX  vmlinux
>> sort done marker at 514bcc
>>   SYSMAP  System.map
>>   OBJCOPY arch/arm/boot/Image
>>   Kernel: arch/arm/boot/Image is ready
>>   GZIP    arch/arm/boot/compressed/piggy.gzip
>>   AS      arch/arm/boot/compressed/debug.o
>> arch/arm/boot/compressed/debug.S: Assembler messages:
>> arch/arm/boot/compressed/debug.S:6: Error: garbage following
>> instruction -- `ldr
>> r2,=IOMEM((0xf4000000+((((0x80000000+0x074000))&0x80000000)>>7)+((((0x80000000+0x074000))&0x000fffff))))'
>>
>> Is this a known issue?
>>
> Yes.  The following change should fix the problem.

Yes, it fixes the build issue and now I get:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc6-next-20130207-dirty
(fabio at fabio-Latitude-E6410) (gcc version 4.4.4 (4.4.4_09.06.2010) )
#1062
Thu Feb 7 16:00:51 BRST 2013
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Freescale i.MX28 (Device Tree), model:
Freescale i.MX28 Evaluation Kit
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Internal error: Oops - undefined instruction: 0 [#1] ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.8.0-rc6-next-20130207-dirty #1062)
[    0.000000] PC is at paging_init+0x63c/0x6fc
[    0.000000] LR is at paging_init+0x614/0x6fc
[    0.000000] pc : [<c04fc48c>]    lr : [<c04fc464>]    psr: 600000d3
[    0.000000] sp : c051df60  ip : 00100000  fp : 000000cf
[    0.000000] r10: 0000000f  r9 : 000001cf  r8 : 00000009
[    0.000000] r7 : c051df68  r6 : c0531f20  r5 : f5100000  r4 : 00000000
[    0.000000] r3 : 20000001  r2 : f5200000  r1 : f5100000  r0 : c7ffdfa0
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[    0.000000] Control: 0005317f  Table: 40004000  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc051c1b8)
[    0.000000] Stack: (0xc051df60 to 0xc051e000)
[    0.000000] df60: 00000000 c0513270 ffff0000 00047fff 00001000
00000008 41069265 c0513270
[    0.000000] df80: c0558534 40008000 c05141e0 c051dfdc 41069265
4051323c 00000000 c04f9d34
[    0.000000] dfa0: 00000000 00053177 00000001 c052403c c05141dc
c05278bc 40004000 41069265
[    0.000000] dfc0: 4051323c c04f8630 00000000 00000000 00000000
00000000 00000000 c05141e0
[    0.000000] dfe0: 00000000 00053175 c052403c c05141dc c05278bc
40008040 00000000 00000000
[    0.000000] [<c04fc48c>] (paging_init+0x63c/0x6fc) from
[<c04f9d34>] (setup_arch+0x340/0x5b4)
[    0.000000] [<c04f9d34>] (setup_arch+0x340/0x5b4) from [<c04f8630>]
(start_kernel+0x74/0x298)
[    0.000000] [<c04f8630>] (start_kernel+0x74/0x298) from
[<40008040>] (0x40008040)
[    0.000000] Code: 1affffd9 ee074f9a ee084f16 ee084f15 (ee074fd5)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
