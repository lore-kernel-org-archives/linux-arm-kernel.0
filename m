From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 May 2014 15:44:55 +0800
Subject: [PATCH 13/16] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <1401041942-23471-14-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
 <1401041942-23471-14-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140527074455.GA7834@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 08:18:59PM +0200, Christoffer Dall wrote:
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index c4ae171..b93e34a 100644
> --- a/arch/arm/include/asm/psci.h
> +++ b/arch/arm/include/asm/psci.h
> @@ -29,16 +29,19 @@ struct psci_operations {
>  	int (*cpu_off)(struct psci_power_state state);
>  	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
>  	int (*migrate)(unsigned long cpuid);
> +	int (*affinity_info)(unsigned long target_affinity,
> +			unsigned long lowest_affinity_level);
> +	int (*migrate_info_type)(void);
>  };
>  
>  extern struct psci_operations psci_ops;
>  extern struct smp_operations psci_smp_ops;
>  
>  #ifdef CONFIG_ARM_PSCI
> -void psci_init(void);
> +int psci_init(void);
>  bool psci_smp_available(void);
>  #else
> -static inline void psci_init(void) { }
> +static inline int psci_init(void) { }

The change introduces the following compile warning on
imx_v6_v7_defconfig build.

In file included from ../arch/arm/kernel/setup.c:40:0:
../arch/arm/include/asm/psci.h: In function ?psci_init?:
../arch/arm/include/asm/psci.h:44:1: warning: no return statement in function returning non-void [-Wreturn-type]

Shawn

>  static inline bool psci_smp_available(void) { return false; }
>  #endif
