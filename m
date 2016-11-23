From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 23 Nov 2016 16:07:22 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161123154829.GA2489@afzalpc>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
Message-ID: <5835BEBA.8050905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/16 15:48, Afzal Mohammed wrote:
> Hi,
> 
> On Tue, Nov 22, 2016 at 04:57:31PM +0000, Vladimir Murzin wrote:
> 
>> I used defconfigs
> 
> Which defconfig was used ?
> 

I had a script to traverse config directory, but seems that I messed
things up.

Now I'm running allmodconfig per Arnd suggestion.

> multi_v7_defconfig, MMU & SMP disabled - thus spake the compiler,
> 
> kernel/built-in.o: In function `kimage_free_entry':
> memremap.c:(.text+0x4dafc): undefined reference to
> `arch_phys_to_idmap_offset'
> memremap.c:(.text+0x4db04): undefined reference to
> `arch_phys_to_idmap_offset'
> kernel/built-in.o: In function `kimage_alloc_page':
> memremap.c:(.text+0x4dbc0): undefined reference to
> `arch_phys_to_idmap_offset'
> memremap.c:(.text+0x4dbc8): undefined reference to
> `arch_phys_to_idmap_offset'
> memremap.c:(.text+0x4dc1c): undefined reference to
> `arch_phys_to_idmap_offset'
> kernel/built-in.o:memremap.c:(.text+0x4dc30): more undefined
> references to `arch_phys_to_idmap_offset' follow

I think this one is fixed by

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8e7496c..c3349b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2019,7 +2019,7 @@ config XIP_PHYS_ADDR
 config KEXEC
        bool "Kexec system call (EXPERIMENTAL)"
        depends on (!SMP || PM_SLEEP_SMP)
-       depends on !CPU_V7M
+       depends on MMU
        select KEXEC_CORE
        help
          kexec is a system call that implements the ability to shutdown your

but there are others I'm working on.

> 
> multi_v7_defconfig & MMU disabled, stderr was more verbose and was
> unhappy with Kconfig dependencies,
> 
> warning: (SOC_IMX31 && SOC_IMX35 && SOC_VF610 && REALVIEW_DT) selects
> SMP_ON_UP which has unmet direct dependencies (SMP && !XIP_KERNEL &&
> MMU)
> warning: (SOC_IMX31 && SOC_IMX35 && SOC_VF610 && REALVIEW_DT) selects
> SMP_ON_UP which has unmet direct dependencies (SMP && !XIP_KERNEL &&
> MMU)

These we fixed in 9001214 ("ARM: imx: no need to select SMP_ON_UP explicitly")

> 
> Ulterior motive here is to try !MMU on Cortex A
> 

Thanks for trying it. Just a gentle remainder not to forget to set DRAM_BASE
and DRAM_SIZE ;)

> Regards
> afzal
> 
