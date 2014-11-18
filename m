From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 18 Nov 2014 21:45:49 +0800
Subject: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
In-Reply-To: <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <546B4D8D.2020605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 2014?10?17? 21:36, Hanjun Guo wrote:
> It always make sense to initialize CPU0's logical map entry from the
> hardware values, so move the initialization of cpu_logical_map(0)
> before unflatten_device_tree() which is needed by ACPI code later.
>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Could you merge this patch first in 3.19? It was acked by Olof and
Mark, and it will make sense without ACPI too.

Thanks
Hanjun

> ---
>   arch/arm64/kernel/setup.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d..8f33f72 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -393,11 +393,11 @@ void __init setup_arch(char **cmdline_p)
>
>   	efi_idmap_init();
>
> +	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	unflatten_device_tree();
>
>   	psci_init();
>
> -	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	cpu_read_bootcpu_ops();
>   #ifdef CONFIG_SMP
>   	smp_init_cpus();
>
