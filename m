From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Apr 2013 11:01:36 +0100
Subject: [Suggestion] ARM:S5pv210: compiling issue for s5pv210 by using
 randconfig
In-Reply-To: <516E6A8E.3000001@asianux.com>
References: <514FB202.3040807@asianux.com> <515BFA8D.2000204@asianux.com>
 <20130403101018.GE11040@mudshark.cambridge.arm.com>
 <515C047A.9010906@asianux.com> <516E6A8E.3000001@asianux.com>
Message-ID: <20130417100136.GB19492@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Arnd, as he plays with randconfig too]

On Wed, Apr 17, 2013 at 10:25:34AM +0100, Chen Gang wrote:
> On 2013?04?03? 18:29, Chen Gang wrote:
>   I repeat it again (but it report another location), and put the config as attachment.

Thanks.

>   when you have time, please help check (if you have no time, I should try)
> 
>   the below is the new related information:

[...]

> arm-linux-gnu-gcc -Wp,-MD,arch/arm/vfp/.vfphw.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7.1/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-s5pv210/include -Iarch/arm/plat-samsung/include  -D__ASSEMBLY__ -mabi=apcs-gnu -mno-thumb-interwork -marm -D__LINUX_ARM_ARCH__=4 -march=armv4t -mtune=arm9tdmi -include asm/unified.h -Wa,-mfpu=softvfp+vfp -mfloat-abi=soft        -c -o arch/arm/vfp/vfphw.o arch/arm/vfp/vfphw.S
> 
> 
>   compiling err:
> 
> arch/arm/vfp/vfphw.S: Assembler messages:
> arch/arm/vfp/vfphw.S:295: Error: selected processor does not support ARM mode `mrrc p11,3,r0,r1,c0'
> arch/arm/vfp/vfphw.S:295: Error: selected processor does not support ARM mode `mrrc p11,3,r0,r1,c1'

The problem here is that you've ended up targetting a platform (s5pv210)
that selects CPU_V7. VFP is then subsequently selected, but CONFIG_MMU=n, so
7TDMI and 9TDMI (v4 CPUs, no VFP) are selectable. Selecting either of those,
causes these warnings.

Unfortunately, I'm not sure how best to fix this. Most of the !MMU CPUs are
tied to a particular board (lots of `if ARCH_INTEGRATOR' predicates), but we
don't want to do that for 7tdmi.

If we could enforce the strict exclusion of {<= ARMv5} and {ARMv6+} in the
Kconfig, that would solve your problem.

Will
