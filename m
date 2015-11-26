From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 16:18:51 +0000
Subject: [PATCH v3 39/62] arm/acpi: Read acpi memory info from uefi
In-Reply-To: <1447753261-7552-40-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-40-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511261618010.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> ACPI memory is seperate from conventional memory and should be marked
> as reserved while passing to DOM0. Create a new meminfo structure to
> store all the acpi tables listed in uefi.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/arch/arm/efi/efi-boot.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/xen/arch/arm/efi/efi-boot.h b/xen/arch/arm/efi/efi-boot.h
> index e427e5f..c58caca 100644
> --- a/xen/arch/arm/efi/efi-boot.h
> +++ b/xen/arch/arm/efi/efi-boot.h
> @@ -17,6 +17,9 @@ void __flush_dcache_area(const void *vaddr, unsigned long size);
>  static struct file __initdata dtbfile;
>  static void __initdata *fdt;
>  static void __initdata *memmap;
> +#ifdef CONFIG_ACPI
> +static struct meminfo __initdata acpi_mem;
> +#endif
>  
>  static int __init setup_chosen_node(void *fdt, int *addr_cells, int *size_cells)
>  {
> @@ -129,6 +132,9 @@ static EFI_STATUS __init efi_process_memory_map_bootinfo(EFI_MEMORY_DESCRIPTOR *
>  {
>      int Index;
>      int i = 0;
> +#ifdef CONFIG_ACPI
> +    int j = 0;
> +#endif
>      EFI_MEMORY_DESCRIPTOR *desc_ptr = map;
>  
>      for ( Index = 0; Index < (mmap_size / desc_size); Index++ )
> @@ -148,10 +154,27 @@ static EFI_STATUS __init efi_process_memory_map_bootinfo(EFI_MEMORY_DESCRIPTOR *
>              bootinfo.mem.bank[i].size = desc_ptr->NumberOfPages * EFI_PAGE_SIZE;
>              ++i;
>          }
> +#ifdef CONFIG_ACPI
> +        else if ( desc_ptr->Type == EfiACPIReclaimMemory )
> +        {
> +            if ( j >= NR_MEM_BANKS )
> +            {
> +                PrintStr(L"Error: All " __stringify(NR_MEM_BANKS)
> +                          " acpi meminfo mem banks exhausted.\r\n");
> +                return EFI_LOAD_ERROR;
> +            }
> +            acpi_mem.bank[j].start = desc_ptr->PhysicalStart;
> +            acpi_mem.bank[j].size  = desc_ptr->NumberOfPages * EFI_PAGE_SIZE;
> +            ++j;
> +        }
> +#endif
>          desc_ptr = NextMemoryDescriptor(desc_ptr, desc_size);
>      }
>  
>      bootinfo.mem.nr_banks = i;
> +#ifdef CONFIG_ACPI
> +    acpi_mem.nr_banks = j;
> +#endif
>      return EFI_SUCCESS;
>  }
>  
> -- 
> 2.1.0
> 
