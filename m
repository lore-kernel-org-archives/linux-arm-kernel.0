From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 15:27:25 +0000
Subject: [PATCH v3 20/62] arm/acpi: Add ACPI support for SMP initialization
In-Reply-To: <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231523290.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and Parking
> protocol, but the Parking protocol is only specified for ARMv7 now, so
> make PSCI as the only way for the SMP boot protocol before some updates
> for the ACPI spec or the Parking protocol spec.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/arm64/smpboot.c |  7 ++++++-
>  xen/arch/arm/psci.c          | 30 +++++++++++++++++++++++-------
>  xen/arch/arm/smpboot.c       |  7 ++++++-
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/xen/arch/arm/arm64/smpboot.c b/xen/arch/arm/arm64/smpboot.c
> index 7928f69..93cb6b3 100644
> --- a/xen/arch/arm/arm64/smpboot.c
> +++ b/xen/arch/arm/arm64/smpboot.c
> @@ -7,6 +7,7 @@
>  #include <xen/vmap.h>
>  #include <asm/io.h>
>  #include <asm/psci.h>
> +#include <asm/acpi.h>
>  
>  struct smp_enable_ops {
>          int             (*prepare_cpu)(int);
> @@ -96,7 +97,11 @@ static int __init dt_arch_cpu_init(int cpu, struct dt_device_node *dn)
>  
>  int __init arch_cpu_init(int cpu, struct dt_device_node *dn)
>  {
> -    return dt_arch_cpu_init(cpu, dn);
> +    if( acpi_disabled )
> +        return dt_arch_cpu_init(cpu, dn);
> +    else
> +        /* acpi only supports psci at present */
> +        return smp_psci_init(cpu);
>  }
>  
>  int __init arch_cpu_up(int cpu)
> diff --git a/xen/arch/arm/psci.c b/xen/arch/arm/psci.c
> index d800cb6..dede0e1 100644
> --- a/xen/arch/arm/psci.c
> +++ b/xen/arch/arm/psci.c
> @@ -22,6 +22,7 @@
>  #include <xen/mm.h>
>  #include <xen/smp.h>
>  #include <asm/psci.h>
> +#include <asm/acpi.h>
>  
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for
> @@ -86,6 +87,9 @@ int __init psci_init_0_1(void)
>      int ret;
>      const struct dt_device_node *psci;
>  
> +    if ( !acpi_disabled )
> +        return -EINVAL;

It might be worth printing an error message here


>      psci = dt_find_compatible_node(NULL, NULL, "arm,psci");
>      if ( !psci )
>          return -EOPNOTSUPP;
> @@ -116,15 +120,24 @@ int __init psci_init_0_2(void)
>          { /* sentinel */ },
>      };
>      int ret;
> -    const struct dt_device_node *psci;
>  
> -    psci = dt_find_matching_node(NULL, psci_ids);
> -    if ( !psci )
> -        return -EOPNOTSUPP;
> +    if( acpi_disabled )
> +    {
> +        const struct dt_device_node *psci;
>  
> -    ret = psci_is_smc_method(psci);
> -    if ( ret )
> -        return -EINVAL;
> +        psci = dt_find_matching_node(NULL, psci_ids);
> +        if ( !psci )
> +            return -EOPNOTSUPP;
> +
> +        ret = psci_is_smc_method(psci);
> +        if ( ret )
> +            return -EINVAL;
> +    }
> +    else
> +    {
> +        if ( acpi_psci_hvc_present() )
> +            return -EINVAL;

and also here


> +    }
>  
>      psci_ver = call_smc(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
>  
> @@ -148,6 +161,9 @@ int __init psci_init(void)
>  {
>      int ret;
>  
> +    if( !acpi_disabled && !acpi_psci_present() )
> +        return -EOPNOTSUPP;
> +
>      ret = psci_init_0_2();
>      if ( ret )
>          ret = psci_init_0_1();
> diff --git a/xen/arch/arm/smpboot.c b/xen/arch/arm/smpboot.c
> index d115228..513f1f6 100644
> --- a/xen/arch/arm/smpboot.c
> +++ b/xen/arch/arm/smpboot.c
> @@ -31,6 +31,7 @@
>  #include <xen/console.h>
>  #include <asm/gic.h>
>  #include <asm/psci.h>
> +#include <asm/acpi.h>
>  
>  cpumask_t cpu_online_map;
>  cpumask_t cpu_present_map;
> @@ -247,7 +248,11 @@ void __init smp_init_cpus(void)
>          return;
>      }
>  
> -    dt_smp_init_cpus();
> +    if ( acpi_disabled )
> +        dt_smp_init_cpus();
> +    else
> +        acpi_smp_init_cpus();
> +
>  }
>  
>  int __init
> -- 
> 2.1.0
> 
