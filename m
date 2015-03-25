From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 17:25:52 +0000
Subject: [patch v11 14/23] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1427205776-5060-15-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325172552.GK14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:47PM +0800, Hanjun Guo wrote:
> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> from the GICC Structure introduced by ACPI 5.1, since MPIDR for ARM64 is
> 64-bit, so typedef u64 for phys_cpuid_t.
> 
> The ARM architecture defines the MPIDR register as the CPU hardware
> identifier. This patch adds the code infrastructure to retrieve the MPIDR
> values from the ARM ACPI GICC structure in order to look-up the kernel CPU
> hardware ids required by the ACPI core code to identify CPUs.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h | 12 ++++++++++++
>  drivers/acpi/processor_core.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 9719921..eea0bc3 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -13,6 +13,8 @@
>  #define _ASM_ACPI_H
>  
>  #include <linux/mm.h>
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> @@ -27,6 +29,9 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  }
>  #define acpi_os_ioremap acpi_os_ioremap
>  
> +typedef u64 phys_cpuid_t;
> +#define PHYS_CPUID_INVALID INVALID_HWID
> +

This should have been defined in the previous patch (though it defaults
to -1, so not too bad).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
