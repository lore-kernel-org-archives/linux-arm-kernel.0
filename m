From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 16:57:31 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <16587553.f9R1mxJih5@wuerfel>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel>
Message-ID: <583478FB.4020008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 10:17, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 9:26:08 AM CET Vladimir Murzin wrote:
>> With this patch applied potentially any platform can be built in NOMMU
>> configurations if CONFIG_EXPERT is selected. However, there is no
>> guaranty that platform can successfully run such Image. So the main
>> motivation behind of this patch:
>> - bring build coverage for NOMMU configurations
>> - allow known working NOMMU platforms (like R-class) to be used
>> - pave a way to add support for single address space (aka 1:1 mapping)
>>   for MMU platforms, so they can be usable in NOMMU configurations
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> I'd have to give this a spin with my randconfig build setup, I'd
> rather not introduce build regressions. Have you tried an
> allmodconfig build with CONFIG_MMU disabled?

I used defconfigs and just got results for allmodconfig apart of complain on
isb instruction in arch/arm/kernel/head-nommu.S [1] there are several link
time errors [2].

> 
> Can you provide a git tree that I can try pulling in?
> 

Unfortunately, I can't provide you with git tree at the moment I'll try to
do something around this before proposing the next version.

> Another question is what architecture levels and what platforms
> we want to support without MMU. The only ARMv4/v5 platform we
> still have that can actually use NOMMU cores is Integrator
> with its ARM7TDMI, ARM920T and ARM966E core tiles (and possibly
> others I couldn't immediately find). Do we actually care about
> them any more now that all the NOMMU world is ARMv7-M? Are
> there any benefits in running an ARM920T or ARM926E core
> with MMU disabled, and does this work with your patches?
> 

I don't have such hardware, so I can't acctually test it - it is why "there is
no guaranty" :( OTOH, if sombody has these platforms these pathces is a good
start to try NOMMU.

> If not, we could limit it to ARMv7-A/R and possibly ARMv6.
> Depending on how the build tests go, a per-platform opt-in
> might be easier than having an opt-out for things that
> don't work.
> 
> 	Arnd
> 

[1]
  AS      arch/arm/kernel/head-nommu.o
arch/arm/kernel/head-nommu.S: Assembler messages:
arch/arm/kernel/head-nommu.S:223: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:231: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:235: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:244: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:248: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:258: Error: selected processor does not support ARM mode `isb'
arch/arm/kernel/head-nommu.S:265: Error: selected processor does not support ARM mode `isb'
make[1]: *** [arch/arm/kernel/head-nommu.o] Error 1

[2]
arch/arm/kernel/head-nommu.o: In function `secondary_startup':
(.text+0x1c): undefined reference to `__setup_mpu'
arch/arm/kernel/head-nommu.o: In function `stext':
(.head.text+0x30): undefined reference to `__setup_mpu'
arch/arm/kernel/built-in.o: In function `setup_arch':
arch/arm/kernel/smccc-call.o:(.init.text+0xa50): undefined reference to `erratum_a15_798181_init'
kernel/built-in.o: In function `kimage_free_entry':
memremap.c:(.text+0xd3d9c): undefined reference to `arch_phys_to_idmap_offset'
kernel/built-in.o: In function `kimage_alloc_page':
memremap.c:(.text+0xd4338): undefined reference to `arch_phys_to_idmap_offset'
kernel/built-in.o: In function `kimage_alloc_control_pages':
memremap.c:(.text+0xd4ac8): undefined reference to `arch_phys_to_idmap_offset'
kernel/built-in.o: In function `kimage_load_segment':
memremap.c:(.text+0xd4f40): undefined reference to `arch_phys_to_idmap_offset'
kernel/built-in.o: In function `crash_free_reserved_phys_range':
memremap.c:(.text+0xd50bc): undefined reference to `arch_phys_to_idmap_offset'
arch/arm/mach-mediatek/built-in.o: In function `__mtk_smp_prepare_cpus':
mediatek.c:(.init.text+0xe8): undefined reference to `secondary_startup_arm'
arch/arm/mach-qcom/built-in.o: In function `qcom_smp_prepare_cpus':
platsmp.c:(.init.text+0xe8): undefined reference to `secondary_startup_arm'
mm/built-in.o: In function `do_mmu_notifier_register':
usercopy.c:(.text+0x34d10): undefined reference to `mm_take_all_locks'
usercopy.c:(.text+0x34d9c): undefined reference to `mm_drop_all_locks'
usercopy.c:(.text+0x34de4): undefined reference to `mm_take_all_locks'
make: *** [vmlinux] Error 1

Cheers
Vladimir
