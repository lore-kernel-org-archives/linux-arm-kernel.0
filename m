From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Dec 2015 19:26:26 +0800
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
Message-ID: <5666BE62.7090409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fu Wei,

On 12/08/2015 03:03 PM, fu.wei at linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> This commit provides APEI arch-specific bits for aarch64
>
> Meanwhile, add a new subfunction "hest_ia_init" for
> "acpi_disable_cmcff" which is used by IA-32 Architecture
> Corrected Machine Check (CMC).
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
> Changelog:
> v4: Rebase to latest kernel version(4.4-rc4).
>      Move arch_apei_flush_tlb_one into header file as a inline function
>      Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".
>
> v3: https://lkml.org/lkml/2015/12/3/521
>      Remove "acpi_disable_cmcff" from arm64 code,
>      and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"
>
> v2: https://lkml.org/lkml/2015/12/2/432
>      Rebase to latest kernel version(4.4-rc3).
>      Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c
>
> v1: https://lkml.org/lkml/2015/8/14/199
>      Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
>      Delete arch/arm64/kernel/apei.c.
>      Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".
>
>   arch/arm64/Kconfig            |  1 +
>   arch/arm64/include/asm/acpi.h |  5 +++++
>   drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
>   3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 871f217..58c8992 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>   	select ACPI_CCA_REQUIRED if ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select HAVE_ACPI_APEI if ACPI
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index caafd63..31d3d9a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>
>   #include <asm/cputype.h>
>   #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>
>   /* Macros for consistency checks of the GICC subtable of MADT */
>   #define ACPI_MADT_GICC_LENGTH	\
> @@ -94,6 +95,10 @@ static inline const char *acpi_get_enable_method(int cpu)
>
>   #ifdef	CONFIG_ACPI_APEI
>   pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);

How bout adding a empty line here?

Except that,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
