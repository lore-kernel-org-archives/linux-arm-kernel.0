From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 13 Apr 2016 18:57:33 +0800
Subject: [PATCH v9] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1459867788-14678-1-git-send-email-fu.wei@linaro.org>
References: <1459867788-14678-1-git-send-email-fu.wei@linaro.org>
Message-ID: <570E261D.8050503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/4/5 22:49, fu.wei at linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> This commit provides APEI arch-specific bits for aarch64
>
> Meanwhile,
> (1)add a new subfunction "hest_ia32_init" for
> "acpi_disable_cmcff" which is used by IA-32 Architecture
> Corrected Machine Check (CMC).
> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
> a generic place.
> (3)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> [Fu Wei: improve && upstream]
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
> Changelog:
> v9: Improve the comment for arch_apei_flush_tlb_one.
>      Using select "HAVE_ACPI_APEI if (ACPI && EFI)" to fix the EFI dependence
>      problem.
>
> v8: https://lkml.org/lkml/2016/3/29/132
>      Fix a "undefined reference" bug by selecting EFI when ACPI_APEI is set
>      on ARM64.
>
> v7: https://lkml.org/lkml/2016/3/17/183
>      Add comment for arch_apei_flush_tlb_one in arch/arm64/include/asm/acpi.h
>
> v6: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006644.html
>      Move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
>      a generic place.
>      Delete HAVE_ACPI_APEI_HEST_IA32.
>
> v5: https://lkml.org/lkml/2015/12/10/131
>      Add "HAVE_ACPI_APEI_HEST_IA32" instead of
>      "#if defined(__i386__) || defined(__x86_64__)".
>
> v4: https://lkml.org/lkml/2015/12/8/188
>      Rebase to latest kernel version(4.4-rc4).
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
>   arch/arm64/include/asm/acpi.h | 15 ++++++++++++++-
>   arch/x86/kernel/acpi/apei.c   |  3 ---
>   drivers/acpi/apei/hest.c      | 18 +++++++++++++++---
>   4 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..308fdb1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>   	select ACPI_CCA_REQUIRED if ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select HAVE_ACPI_APEI if (ACPI && EFI)

Alphabetical order please, as people already strictly
did that in arch/arm64/Kconfig, with this fixed, my
ack is still valid.

Thanks
Hanjun
