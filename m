From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:14:07 +0000
Subject: [Xen-devel] [PATCH v3 40/62] arm/acpi: Estimate memory required
 for acpi/efi tables
In-Reply-To: <1447753261-7552-41-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-41-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565C67BF.4040804@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
> index 53c7452..78d8ae9 100644
> --- a/xen/common/efi/boot.c
> +++ b/xen/common/efi/boot.c
> @@ -13,6 +13,7 @@
>  #include <xen/multiboot.h>
>  #include <xen/pci_regs.h>
>  #include <xen/pfn.h>
> +#include <asm/acpi.h>
>  #if EFI_PAGE_SIZE != PAGE_SIZE
>  # error Cannot use xen/pfn.h here!
>  #endif
> @@ -1171,6 +1172,26 @@ efi_start(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
>      for( ; ; ); /* not reached */
>  }
>  
> +#ifdef CONFIG_ACPI
> +/* Constant to indicate "Xen" in unicode u16 format */
> +static const u16 XEN_EFI_FW_VENDOR[] ={0x0058,0x0065,0x006E,0x0000};
> +
> +int __init estimate_efi_size(int mem_nr_banks)
> +{
> +    int size;
> +    int est_size = sizeof(EFI_SYSTEM_TABLE);
> +    int ect_size = sizeof(EFI_CONFIGURATION_TABLE);
> +    int emd_size = sizeof(EFI_MEMORY_DESCRIPTOR);
> +    int fw_vendor_size = sizeof(XEN_EFI_FW_VENDOR);
> +
> +    size = PAGE_ALIGN(est_size + ect_size + fw_vendor_size)
> +           + PAGE_ALIGN(emd_size *
> +                        (mem_nr_banks + acpi_mem.nr_banks + TBL_MMAX));
> +
> +    return size;
> +}
> +#endif
> +

efi/boot.c only contains code related to the stub EFI. This is not the
case of this code.

Moreover, this code won't compile on x86 because acpi_mem is only
defined for ARM.

Regards,

-- 
Julien Grall
