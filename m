From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 May 2013 17:03:47 +0100
Subject: [PATCH v3 3/4] arm: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <1368027714-14506-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305081446580.18865@kaball.uk.xensource.com>
 <1368027714-14506-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <518A7763.4050509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 08/05/13 16:41, Stefano Stabellini wrote:
> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM.
> 
> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> runtime pvops patching needed.
> 
> This allows us to make use of steal_account_process_tick for stolen
> ticks accounting.
> 
> Changes in v3:
> - improve commit description and Kconfig help text;
> - no need to initialize pv_time_ops;
> - add PARAVIRT_TIME_ACCOUNTING.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: linux at arm.linux.org.uk
> CC: will.deacon at arm.com
> CC: nico at linaro.org
> CC: marc.zyngier at arm.com
> CC: cov at codeaurora.org
> CC: arnd at arndb.de
> CC: olof at lixom.net
> ---
>  arch/arm/Kconfig                |   20 ++++++++++++++++++++
>  arch/arm/include/asm/paravirt.h |   19 +++++++++++++++++++
>  arch/arm/kernel/Makefile        |    1 +
>  arch/arm/kernel/paravirt.c      |   25 +++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/paravirt.h
>  create mode 100644 arch/arm/kernel/paravirt.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 344e299..89ee2f1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1887,12 +1887,32 @@ config XEN_DOM0
>  	def_bool y
>  	depends on XEN
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

Surely you meant "depends on" instead of "select" here? Otherwise I
don't really see the point of PARAVIRT...

> +	default n
> +	---help---
> +	  Select this option to enable fine granularity task steal time
> +	  accounting. Time spent executing other tasks in parallel with
> +	  the current vCPU is discounted from the vCPU power. To account for
> +	  that, there can be a small performance impact.
> +
> +	  If in doubt, say N here.
> +
>  config XEN
>  	bool "Xen guest support on ARM (EXPERIMENTAL)"
>  	depends on ARM && AEABI && OF
>  	depends on CPU_V7 && !CPU_V6
>  	depends on !GENERIC_ATOMIC64
>  	select ARM_PSCI
> +	select PARAVIRT
>  	help
>  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
>  
-- 
Jazz is not dead. It just smells funny...
