From: jcm@redhat.com (Jon Masters)
Date: Fri, 12 Sep 2014 15:34:06 -0400
Subject: [PATCH v4 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
In-Reply-To: <1410530416-30200-2-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54134AAE.8090106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 09:59 AM, Hanjun Guo wrote:
> It always make sense to initialize CPU0's logical map entry from the
> hardware values, so move the initialization of cpu_logical_map(0)
> before unflatten_device_tree() which is needed by ACPI code later.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d..8f33f72 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -393,11 +393,11 @@ void __init setup_arch(char **cmdline_p)
>  
>  	efi_idmap_init();
>  
> +	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	unflatten_device_tree();
>  
>  	psci_init();
>  
> -	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	cpu_read_bootcpu_ops();
>  #ifdef CONFIG_SMP
>  	smp_init_cpus();

Thanks - this is a good fix to ensure we're always dealing with the
masked value of the MPIDR Aff bits that we care about.

Jon.
