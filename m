From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Feb 2015 17:17:39 -0500 (EST)
Subject: [PATCH 3/4] arm-cci: Split the code for PMU vs driver support
In-Reply-To: <1424783863-9894-4-git-send-email-suzuki.poulose@arm.com>
References: <1424783863-9894-1-git-send-email-suzuki.poulose@arm.com>
 <1424783863-9894-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <alpine.LFD.2.11.1502241659270.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Feb 2015, Suzuki K. Poulose wrote:

> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This patch separates the PMU driver code from the low level
> CCI driver code, and enables the CCI400-PMU for ARM64.
> 
> Introduces config options for both.
> 
>  - ARM_CCI400_MCPM	- controls the low level MCPM driver code for CCI
>  - ARM_CCI400_PMU	- controls the PMU driver code
>  - ARM_CCI400_COMMON	- CCI400 specific details shared by MCPM
> 			  and PMU
> Changes:
>  - ARM_CCI 		- common code for probing the CCI devices
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

Comments inline.

> ---
>  arch/arm/mach-exynos/Kconfig   |    2 +-
>  arch/arm/mach-vexpress/Kconfig |    4 ++--
>  drivers/bus/Kconfig            |   28 +++++++++++++++++++++++-----
>  drivers/bus/arm-cci.c          |   25 +++++++++++++++++++++----
>  include/linux/arm-cci.h        |    7 ++++++-
>  5 files changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 603820e..9bc8b4d 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -123,7 +123,7 @@ config SOC_EXYNOS5800
>  config EXYNOS5420_MCPM
>  	bool "Exynos5420 Multi-Cluster PM support"
>  	depends on MCPM && SOC_EXYNOS5420
> -	select ARM_CCI
> +	select ARM_CCI400_MCPM
>  	select ARM_CPU_SUSPEND
>  	help
>  	  This is needed to provide CPU and cluster power management
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index d6b16d9..097912f 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -53,7 +53,7 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
>  config ARCH_VEXPRESS_DCSCB
>  	bool "Dual Cluster System Control Block (DCSCB) support"
>  	depends on MCPM
> -	select ARM_CCI
> +	select ARM_CCI400_MCPM
>  	help
>  	  Support for the Dual Cluster System Configuration Block (DCSCB).
>  	  This is needed to provide CPU and cluster power management
> @@ -71,7 +71,7 @@ config ARCH_VEXPRESS_SPC
>  config ARCH_VEXPRESS_TC2_PM
>  	bool "Versatile Express TC2 power management"
>  	depends on MCPM
> -	select ARM_CCI
> +	select ARM_CCI400_MCPM
>  	select ARCH_VEXPRESS_SPC
>  	help
>  	  Support for CPU and cluster power management on Versatile Express
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index b99729e..91dd013 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -43,12 +43,30 @@ config OMAP_INTERCONNECT
>  	help
>  	  Driver to enable OMAP interconnect error handling driver.
>  
> -config ARM_CCI
> -	bool "ARM CCI driver support"
> -	depends on ARM && OF && CPU_V7
> +config ARM_CCI400_MCPM
> +	bool
> +	depends on ARM && OF && CPU_V7 && MCPM

MCPM is not an actual dependency and therefore should probably not be 
added here.  You removed the prompt string therefore this will only be 
selectable explicitly as needed.

Also, shouldn't it select ARM_CCI400_COMMON ?

> +	help
> +	  Low level power management driver for CCI400 cache coherent
> +	  interconnect for ARM platforms.
> +
> +config ARM_CCI400_PMU
> +	bool "ARM CCI400 PMU support"
> +	depends on ARM || ARM64
> +	depends on HW_PERF_EVENTS
> +	select ARM_CCI400_COMMON
>  	help
> -	  Driver supporting the CCI cache coherent interconnect for ARM
> -	  platforms.
> +	  Support for PMU events monitoring on the ARM CCI cache coherent
> +	  interconnect.
> +
> +	  If unsure, say N
> +
> +config ARM_CCI400_COMMON
> +	bool
> +	select ARM_CCI
> +
> +config ARM_CCI
> +	bool

Surely you could do with only one of ARM_CCI or ARM_CCI400_COMMON?  
Personally I'd go with the later as it is more precise.

>  config ARM_CCN
>  	bool "ARM CCN driver support"
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index fe9fa46..7e330fe 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -32,6 +32,7 @@
>  static void __iomem *cci_ctrl_base;
>  static unsigned long cci_ctrl_phys;
>  
> +#ifdef CONFIG_ARM_CCI400_MCPM
>  struct cci_nb_ports {
>  	unsigned int nb_ace;
>  	unsigned int nb_ace_lite;
> @@ -42,12 +43,19 @@ static const struct cci_nb_ports cci400_ports = {
>  	.nb_ace_lite = 3
>  };
>  
> +#define CCI400_MCPM_PORTS_DATA	(&cci400_ports)

I'm a bit uneasy with the conflation of MCPM in here.  Sure (most) MCPM 
backends are the only users of this code, but that doesn't mean MCPM has 
to have exclusive access.  Having "MCPM" entranched into the code and 
config symbols like that is misrepresenting this code somewhat.

> +#else
> +#define CCI400_MCPM_PORTS_DATA	(NULL)
> +#endif
> +
>  static const struct of_device_id arm_cci_matches[] = {
> -	{.compatible = "arm,cci-400", .data = &cci400_ports },
> +#ifdef CONFIG_ARM_CCI400_COMMON
> +	{.compatible = "arm,cci-400", .data = CCI400_MCPM_PORTS_DATA },
> +#endif
>  	{},
>  };
>  
> -#ifdef CONFIG_HW_PERF_EVENTS
> +#ifdef CONFIG_ARM_CCI400_PMU
>  
>  #define DRIVER_NAME		"CCI-400"
>  #define DRIVER_NAME_PMU		DRIVER_NAME " PMU"
> @@ -981,6 +989,7 @@ static int cci_pmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pr_info("ARM %s PMU driver probed", pmu->model->name);

Wouldn't this addition fit better in one of the previous patches?

>  	return 0;
>  }
>  
> @@ -1019,14 +1028,16 @@ static int __init cci_platform_init(void)
>  	return platform_driver_register(&cci_platform_driver);
>  }
>  
> -#else /* !CONFIG_HW_PERF_EVENTS */
> +#else /* !CONFIG_ARM_CCI400_PMU */
>  
>  static int __init cci_platform_init(void)
>  {
>  	return 0;
>  }
>  
> -#endif /* CONFIG_HW_PERF_EVENTS */
> +#endif /* CONFIG_ARM_CCI400_PMU */
> +
> +#ifdef CONFIG_ARM_CCI400_MCPM
>  
>  #define CCI_PORT_CTRL		0x0
>  #define CCI_CTRL_STATUS		0xc
> @@ -1457,6 +1468,12 @@ static int cci_probe_ports(struct device_node *np)
>  
>  	return 0;
>  }
> +#else /* !CONFIG_ARM_CCI400_MCPM */
> +static inline int cci_probe_ports(struct device_node *np)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARM_CCI400_MCPM */
>  
>  static int cci_probe(void)
>  {
> diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
> index aede5c7..77d06f5 100644
> --- a/include/linux/arm-cci.h
> +++ b/include/linux/arm-cci.h
> @@ -30,12 +30,16 @@ struct device_node;
>  
>  #ifdef CONFIG_ARM_CCI
>  extern bool cci_probed(void);
> +#else
> +static inline bool cci_probed(void) { return false; }
> +#endif
> +
> +#ifdef CONFIG_ARM_CCI400_MCPM
>  extern int cci_ace_get_port(struct device_node *dn);
>  extern int cci_disable_port_by_cpu(u64 mpidr);
>  extern int __cci_control_port_by_device(struct device_node *dn, bool enable);
>  extern int __cci_control_port_by_index(u32 port, bool enable);
>  #else
> -static inline bool cci_probed(void) { return false; }
>  static inline int cci_ace_get_port(struct device_node *dn)
>  {
>  	return -ENODEV;
> @@ -51,6 +55,7 @@ static inline int __cci_control_port_by_index(u32 port, bool enable)
>  	return -ENODEV;
>  }
>  #endif
> +
>  #define cci_disable_port_by_device(dev) \
>  	__cci_control_port_by_device(dev, false)
>  #define cci_enable_port_by_device(dev) \
> -- 
> 1.7.9.5
> 
> 
> 
