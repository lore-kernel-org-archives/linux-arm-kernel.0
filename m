From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Jul 2015 13:39:08 +0100
Subject: [PATCH] ARM: psci: keystone: remove keystone_smp_ops code if
 psci is supported
In-Reply-To: <1435752784-30639-1-git-send-email-vitalya@ti.com>
References: <1435752784-30639-1-git-send-email-vitalya@ti.com>
Message-ID: <20150701123908.GA2310@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 01:13:03PM +0100, Vitaly Andrianov wrote:
> If we enable psci support we don't need keystone_smp_ops anymore.

You need them for existing users.

> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> ---
>  arch/arm/mach-keystone/Makefile   | 2 ++
>  arch/arm/mach-keystone/keystone.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
> index 25d9239..5cc5ca4 100644
> --- a/arch/arm/mach-keystone/Makefile
> +++ b/arch/arm/mach-keystone/Makefile
> @@ -3,7 +3,9 @@ obj-y					:= keystone.o smc.o
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
>  
> +ifneq ($(CONFIG_ARM_PSCI),y)
>  obj-$(CONFIG_SMP)			+= platsmp.o
> +endif
>  
>  # PM domain driver for Keystone SOCs
>  obj-$(CONFIG_ARCH_KEYSTONE)		+= pm_domain.o
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index e2880105..9cc489c 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -105,7 +105,9 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
>  #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
>  	.dma_zone_size	= SZ_2G,
>  #endif
> +#ifndef CONFIG_ARM_PSCI
>  	.smp		= smp_ops(keystone_smp_ops),
> +#endif

This will prevent building a kernel that supports PSCI and your legacy
SMP bringup.

I don't think this is necessary, given the code in setup_arch and the
absence of mdesc->smp_init for keystone. A single kernel can support
both, and it should support both.

Thanks,
Mark.

>  	.init_machine	= keystone_init,
>  	.dt_compat	= keystone_match,
>  	.pv_fixup	= keystone_pv_fixup,
> -- 
> 1.9.1
> 
