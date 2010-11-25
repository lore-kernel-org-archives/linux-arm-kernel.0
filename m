From: gadiyar@ti.com (Anand Gadiyar)
Date: Thu, 25 Nov 2010 19:24:57 +0530
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
References: <4CBD707F.6050204@ti.com>	
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>	
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4CEE6AB1.7090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/8/2010 3:18 PM, Catalin Marinas wrote:
> On Mon, 2010-11-08 at 06:05 +0000, Anand Gadiyar wrote:
>> Catalin Marinas wrote:
>>> On Tue, 2010-10-19 at 11:18 +0100, Anand Gadiyar wrote:
>>>> Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7
>>>> processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file
>>>> gets compiled when the omap2plus_defconfig is built - the
>>>> omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one
>>>> image, and has CPU_V6 and CPU_V7 both enabled.
>>>
>>> This patch should fix it:
>>>
>>>
>>> ARM: Do not enable SWP emulation if CPU_V6 && CPU_V7
>>>
>>> From: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> This option uses LDREXB/STREXB to emulate SWPB but these instructions
>>> are not supported on all the ARMv6 processors.
>>>
>>> Reported-by: Anand Gadiyar <gadiyar@ti.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Leif Lindholm <Leif.Lindholm@arm.com>
>>
>> I can't find this patch in linux-next. Hope we haven't missed it.
>> Tony acked this btw.
>>
>> Strangely, the omap2plus_defconfig in v2.6.37-rc1 no longer gets
>> CONFIG_SWP_EMULATE enabled even without this patch - I can't figure
>> out why.
> 
> Russell had a better idea for handling this, not sure whether it went
> into -next. It was basically adding -march=armv7-a to
> CFLAGS_swp_emulate.o in arch/arm/kernel/Makefile since we can't trigger
> an undef fault for SWP on ARMv6 anyway.
> 
> If it's not in yet, I can submit a patch.
> 

I tested the patch in current linux-next that adds the CFLAGS_swp_emulate.o

It doesn't solve the compile issue for omap2plus_defconfig.

Here's what a 'make V=1' throws up.

  ccache arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/kernel/.swp_emulate.o.d  -nostdinc -isystem /db/omapts/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/include -I/home/userdata/a0393673/mainline/mainline/arch/arm/include -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=6 -march=armv6 -mtune=arm1136j-s -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Wa,-march=armv7-a    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(swp_emulate)"  -D"KBUILD_MODNAME=KBUILD_STR(swp_emulate)" -c
 -o arch/arm/kernel/.tmp_swp_emulate.o arch/arm/kernel/swp_emulate.c
/tmp/ccLscgtf.s: Assembler messages:
/tmp/ccLscgtf.s:339: Error: selected processor does not support ARM mode `ldrexb r7,[r6]'
/tmp/ccLscgtf.s:340: Error: selected processor does not support ARM mode `strexb r3,r2,[r6]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel/] Error 2

- Anand
