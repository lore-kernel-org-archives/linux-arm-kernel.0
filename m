From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 14:13:21 +0000
Subject: [PATCH v3 51/62] arm/acpi: Prepare EFI system table for Dom0
In-Reply-To: <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271412150.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c |  2 ++
>  xen/common/efi/boot.c       | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  xen/include/asm-arm/setup.h |  3 +++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/xen/arch/arm/domain_build.c b/xen/arch/arm/domain_build.c
> index da4e271..9d667ea 100644
> --- a/xen/arch/arm/domain_build.c
> +++ b/xen/arch/arm/domain_build.c
> @@ -1735,6 +1735,8 @@ static int prepare_acpi(struct domain *d, struct kernel_info *kinfo)
>          return rc;
>  
>      acpi_map_rest_tables(d);
> +    acpi_create_efi_system_table(d->arch.efi_acpi_gpa, d->arch.efi_acpi_table,
> +                                 tbl_add);
>  
>      return 0;
>  }
> diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
> index 6a48624..75835ae 100644
> --- a/xen/common/efi/boot.c
> +++ b/xen/common/efi/boot.c
> @@ -1192,6 +1192,70 @@ int __init estimate_efi_size(int mem_nr_banks)
>  
>      return size;
>  }
> +
> +static uint32_t __init xz_crc32(uint8_t *buf, size_t size, uint32_t crc)
> +{
> +    uint32_t xz_crc32_table[256];
> +    const uint32_t poly = 0xEDB88320;
> +    uint32_t i;
> +    uint32_t j;
> +    uint32_t r;
> +
> +    for (i = 0; i < 256; ++i) {
> +        r = i;
> +        for (j = 0; j < 8; ++j)
> +            r = (r >> 1) ^ (poly & ~((r & 1) - 1));
> +
> +        xz_crc32_table[i] = r;
> +    }
> +
> +    crc = ~crc;
> +    while (size != 0) {
> +            crc = xz_crc32_table[*buf++ ^ (crc & 0xFF)] ^ (crc >> 8);
> +            --size;
> +    }
> +
> +    return ~crc;
> +}

I agree with Julien that we should reuse the existing functions for this


> +void __init acpi_create_efi_system_table(paddr_t paddr, void *efi_acpi_table,
> +                                         struct membank tbl_add[])
> +{
> +    u64 table_addr, table_size, offset = 0;
> +    u8 *base_ptr;
> +    EFI_CONFIGURATION_TABLE *efi_conf_tbl;
> +    EFI_SYSTEM_TABLE *efi_sys_tbl;
> +    EFI_SYSTEM_TABLE *est = (EFI_SYSTEM_TABLE *)maddr_to_virt(efi.est);
> +
> +    table_addr = paddr + acpi_get_table_offset(tbl_add, TBL_EFIT);
> +    table_size = sizeof(EFI_SYSTEM_TABLE) + sizeof(EFI_CONFIGURATION_TABLE)
> +                 + sizeof(XEN_EFI_FW_VENDOR);
> +    base_ptr = efi_acpi_table + acpi_get_table_offset(tbl_add, TBL_EFIT);
> +    efi_sys_tbl = (EFI_SYSTEM_TABLE *)base_ptr;
> +
> +    memcpy((EFI_TABLE_HEADER *)&(efi_sys_tbl->Hdr),
> +           (EFI_TABLE_HEADER *)&(est->Hdr), sizeof(EFI_TABLE_HEADER));
> +    efi_sys_tbl->Hdr.HeaderSize = table_size;
> +
> +    efi_sys_tbl->FirmwareRevision = est->FirmwareRevision;
> +    efi_sys_tbl->NumberOfTableEntries = 1;
> +    offset += sizeof(EFI_SYSTEM_TABLE);
> +    memcpy((u16 *)(base_ptr + offset), XEN_EFI_FW_VENDOR,
> +           sizeof(XEN_EFI_FW_VENDOR));
> +    efi_sys_tbl->FirmwareVendor = (CHAR16 *)(table_addr + offset);
> +
> +    offset += sizeof(XEN_EFI_FW_VENDOR);
> +    efi_conf_tbl = (EFI_CONFIGURATION_TABLE *)(base_ptr + offset);
> +    efi_conf_tbl->VendorGuid = (EFI_GUID)ACPI_20_TABLE_GUID;
> +    efi_conf_tbl->VendorTable = (VOID *)tbl_add[TBL_RSDP].start;
> +    efi_sys_tbl->ConfigurationTable = (EFI_CONFIGURATION_TABLE *)(table_addr
> +                                                                  + offset);
> +    efi_sys_tbl->Hdr.CRC32 = xz_crc32((uint8_t *)efi_sys_tbl,
> +                                      efi_sys_tbl->Hdr.HeaderSize, 0);
> +
> +    tbl_add[TBL_EFIT].start = table_addr;
> +    tbl_add[TBL_EFIT].size = table_size;
> +}
>  #endif

I also agree with Julien that acpi_create_efi_system_table shouldn't be
here. You should be able to move the function to
xen/arch/arm/domain_build.c.

The rest is OK.


>  #ifndef CONFIG_ARM /* TODO - runtime service support */
> diff --git a/xen/include/asm-arm/setup.h b/xen/include/asm-arm/setup.h
> index b759813..2d65796 100644
> --- a/xen/include/asm-arm/setup.h
> +++ b/xen/include/asm-arm/setup.h
> @@ -53,6 +53,9 @@ void copy_from_paddr(void *dst, paddr_t paddr, unsigned long len);
>  
>  int estimate_efi_size(int mem_nr_banks);
>  
> +void acpi_create_efi_system_table(paddr_t paddr, void *efi_acpi_table,
> +                                  struct membank tbl_add[]);
> +
>  int construct_dom0(struct domain *d);
>  
>  void discard_initial_modules(void);
> -- 
> 2.1.0
> 
