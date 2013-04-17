From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 17 Apr 2013 13:02:33 +0200
Subject: [Suggestion] ARM:S5pv210: compiling issue for s5pv210 by using
 randconfig
In-Reply-To: <201304171253.20284.arnd@arndb.de>
References: <514FB202.3040807@asianux.com> <516E6A8E.3000001@asianux.com>
 <20130417100136.GB19492@mudshark.cambridge.arm.com>
 <201304171253.20284.arnd@arndb.de>
Message-ID: <20130417110233.GD4998@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:53 Wed 17 Apr     , Arnd Bergmann wrote:
> On Wednesday 17 April 2013, Will Deacon wrote:
> > > arm-linux-gnu-gcc -Wp,-MD,arch/arm/vfp/.vfphw.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7.1/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-s5pv210/include -Iarch/arm/plat-samsung/include  -D__ASSEMBLY__ -mabi=apcs-gnu -mno-thumb-interwork -marm -D__LINUX_ARM_ARCH__=4 -march=armv4t -mtune=arm9tdmi -include asm/unified.h -Wa,-mfpu=softvfp+vfp -mfloat-abi=soft        -c -o arch/arm/vfp/vfphw.o arch/arm/vfp/vfphw.S
> > > 
> > > 
> > >   compiling err:
> > > 
> > > arch/arm/vfp/vfphw.S: Assembler messages:
> > > arch/arm/vfp/vfphw.S:295: Error: selected processor does not support ARM mode `mrrc p11,3,r0,r1,c0'
> > > arch/arm/vfp/vfphw.S:295: Error: selected processor does not support ARM mode `mrrc p11,3,r0,r1,c1'
> > 
> > The problem here is that you've ended up targetting a platform (s5pv210)
> > that selects CPU_V7. VFP is then subsequently selected, but CONFIG_MMU=n, so
> > 7TDMI and 9TDMI (v4 CPUs, no VFP) are selectable. Selecting either of those,
> > causes these warnings.
> > 
> > Unfortunately, I'm not sure how best to fix this. Most of the !MMU CPUs are
> > tied to a particular board (lots of `if ARCH_INTEGRATOR' predicates), but we
> > don't want to do that for 7tdmi.
> > 
> > If we could enforce the strict exclusion of {<= ARMv5} and {ARMv6+} in the
> > Kconfig, that would solve your problem.
> 
> I have not tried to get no-MMU kernels to build in general. I think the way
> it should be done is to not offer any user-selectable CPU types at all but
> always select the CPU from the board.
> 
> For randconfig tests, I would recommend turning on CONFIG_MMU unconditionally
> using an appropriate KCONFIG_ALLCONFIG= file.
> 
> The alternative is to use the patch below, but it may be incomplete: I could
> not find anything other than AT91x40 in the kernel that actually has an
> ARM7TDMI or ARM9TDMI.
> 
> 	Arnd
> 
> diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
> index 6c24985..dc972e1 100644
> --- a/arch/arm/mach-at91/Kconfig.non_dt
> +++ b/arch/arm/mach-at91/Kconfig.non_dt
> @@ -47,6 +47,7 @@ config ARCH_AT91X40
>  	select ARCH_USES_GETTIMEOFFSET
>  	select MULTI_IRQ_HANDLER
>  	select SPARSE_IRQ
> +	select CPU_ARM7TDMI
>  
>  endchoice
>  
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 84af266..c5e4ef0 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -6,7 +6,6 @@ comment "Processor Type"
>  
>  # ARM7TDMI
>  config CPU_ARM7TDMI
> -	bool "Support ARM7TDMI processor"
whith the bool type at least
>  	depends on !MMU
>  	select CPU_32v4T
>  	select CPU_ABRT_LV4T
> @@ -56,7 +55,6 @@ config CPU_ARM740T
>  
>  # ARM9TDMI
>  config CPU_ARM9TDMI
> -	bool "Support ARM9TDMI processor"
>  	depends on !MMU
>  	select CPU_32v4T
>  	select CPU_ABRT_NOMMU
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
