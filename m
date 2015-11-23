From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 15:22:51 +0000
Subject: [PATCH v3 19/62] arm/smpboot: Move dt specific code in smp to
 seperate functions
In-Reply-To: <1447753261-7552-20-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-20-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231521160.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Partition smp initialization functions into generic and dt specific
> parts, this will be useful when introducing new functions for smp
> initialization based on acpi.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/arch/arm/arm64/smpboot.c |  7 ++++++-
>  xen/arch/arm/smpboot.c       | 29 ++++++++++++++++++-----------
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/xen/arch/arm/arm64/smpboot.c b/xen/arch/arm/arm64/smpboot.c
> index 62e6abb..7928f69 100644
> --- a/xen/arch/arm/arm64/smpboot.c
> +++ b/xen/arch/arm/arm64/smpboot.c
> @@ -70,7 +70,7 @@ int __init arch_smp_init(void)
>      return 0;
>  }
>  
> -int __init arch_cpu_init(int cpu, struct dt_device_node *dn)
> +static int __init dt_arch_cpu_init(int cpu, struct dt_device_node *dn)
>  {
>      const char *enable_method;
>  
> @@ -94,6 +94,11 @@ int __init arch_cpu_init(int cpu, struct dt_device_node *dn)
>      return 0;
>  }
>  
> +int __init arch_cpu_init(int cpu, struct dt_device_node *dn)
> +{
> +    return dt_arch_cpu_init(cpu, dn);
> +}
> +
>  int __init arch_cpu_up(int cpu)
>  {
>      if ( !smp_enable_ops[cpu].prepare_cpu )
> diff --git a/xen/arch/arm/smpboot.c b/xen/arch/arm/smpboot.c
> index a96cda2..d115228 100644
> --- a/xen/arch/arm/smpboot.c
> +++ b/xen/arch/arm/smpboot.c
> @@ -92,7 +92,7 @@ smp_clear_cpu_maps (void)
>   * MPIDR values related to logical cpus
>   * Code base on Linux arch/arm/kernel/devtree.c
>   */
> -void __init smp_init_cpus(void)
> +static void __init dt_smp_init_cpus(void)
>  {
>      register_t mpidr;
>      struct dt_device_node *cpus = dt_find_node_by_path("/cpus");
> @@ -106,16 +106,6 @@ void __init smp_init_cpus(void)
>      bool_t bootcpu_valid = 0;
>      int rc;
>  
> -    /* scan the DTB for a PSCI node and set a global variable */
> -    psci_init();
> -
> -    if ( (rc = arch_smp_init()) < 0 )
> -    {
> -        printk(XENLOG_WARNING "SMP init failed (%d)\n"
> -               "Using only 1 CPU\n", rc);
> -        return;
> -    }
> -
>      mpidr = boot_cpu_data.mpidr.bits & MPIDR_HWID_MASK;
>  
>      if ( !cpus )
> @@ -243,6 +233,23 @@ void __init smp_init_cpus(void)
>      }
>  }
>  
> +void __init smp_init_cpus(void)
> +{
> +    int rc;
> +
> +    /* initialize PSCI and set a global variable */
> +    psci_init();
> +
> +    if ( (rc = arch_smp_init()) < 0 )
> +    {
> +        printk(XENLOG_WARNING "SMP init failed (%d)\n"
> +               "Using only 1 CPU\n", rc);
> +        return;
> +    }
> +
> +    dt_smp_init_cpus();
> +}
> +
>  int __init
>  smp_get_max_cpus (void)
>  {
> -- 
> 2.1.0
> 
