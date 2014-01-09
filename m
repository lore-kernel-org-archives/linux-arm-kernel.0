From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 9 Jan 2014 12:13:42 +0000
Subject: [PATCH v8 3/6] arm: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <1389206998-27875-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
 <1389206998-27875-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1389269622.27473.72.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-08 at 18:49 +0000, Stefano Stabellini wrote:
> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM.
> 
> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> runtime pvops patching needed.
> 
> This allows us to make use of steal_account_process_tick for stolen
> ticks accounting.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Christopher Covington <cov@codeaurora.org>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> CC: linux at arm.linux.org.uk
> CC: will.deacon at arm.com
> CC: nico at linaro.org
> CC: marc.zyngier at arm.com
> CC: cov at codeaurora.org
> CC: arnd at arndb.de
> CC: olof at lixom.net
> 
> ---
> 
> Changes in v7:
> - ifdef CONFIG_PARAVIRT the content of paravirt.h.
> 
> Changes in v3:
> - improve commit description and Kconfig help text;
> - no need to initialize pv_time_ops;
> - add PARAVIRT_TIME_ACCOUNTING.
> ---
>  arch/arm/Kconfig         |   20 ++++++++++++++++++++
>  arch/arm/kernel/Makefile |    1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c1f1a7e..d6c3ba1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1874,6 +1874,25 @@ config SWIOTLB
>  config IOMMU_HELPER
>  	def_bool SWIOTLB
>  
> +config PARAVIRT
> +	bool "Enable paravirtualization code"
> +	---help---
> +	  This changes the kernel so it can modify itself when it is run
> +	  under a hypervisor, potentially improving performance significantly
> +	  over full virtualization.
> +
> +config PARAVIRT_TIME_ACCOUNTING
> +	bool "Paravirtual steal time accounting"
> +	select PARAVIRT
> +	default n
> +	---help---
> +	  Select this option to enable fine granularity task steal time
> +	  accounting. Time spent executing other tasks in parallel with
> +	  the current vCPU is discounted from the vCPU power. To account for
> +	  that, there can be a small performance impact.
> +
> +	  If in doubt, say N here.
> +
>  config XEN_DOM0
>  	def_bool y
>  	depends on XEN
> @@ -1885,6 +1904,7 @@ config XEN
>  	depends on !GENERIC_ATOMIC64
>  	select ARM_PSCI
>  	select SWIOTLB_XEN
> +	select PARAVIRT
>  	help
>  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
>  
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index a30fc9b..bcd2b38 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
>  ifneq ($(CONFIG_ARCH_EBSA110),y)
>    obj-y		+= io.o
>  endif
> +obj-$(CONFIG_PARAVIRT)	+= paravirt.o
>  
>  head-y			:= head$(MMUEXT).o
>  obj-$(CONFIG_DEBUG_LL)	+= debug.o
