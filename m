From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 11:54:30 +0000
Subject: [PATCH v3 10/62] arm/acpi: Move end_boot_allocator after
 acpi_boot_table_init
In-Reply-To: <1447753261-7552-11-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-11-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231154050.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> If ACPI is initialized after the boot allocator has ended(the system
> state is not early boot), assert happens in acpi_os_zalloc_memory and
> acpi_boot_table_init will fail. So it needs to move end_boot_allocator
> after acpi_boot_table_init.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

This is the reason why you are calling acpi_boot_table_init before
vm_init, correct?


>  xen/arch/arm/setup.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/xen/arch/arm/setup.c b/xen/arch/arm/setup.c
> index 768312f..c15a09d 100644
> --- a/xen/arch/arm/setup.c
> +++ b/xen/arch/arm/setup.c
> @@ -613,8 +613,6 @@ static void __init setup_mm(unsigned long dtb_paddr, size_t dtb_size)
>         allocator. */
>      init_xenheap_pages(pfn_to_paddr(xenheap_mfn_start),
>                         pfn_to_paddr(boot_mfn_start));
> -
> -    end_boot_allocator();
>  }
>  #else /* CONFIG_ARM_64 */
>  static void __init setup_mm(unsigned long dtb_paddr, size_t dtb_size)
> @@ -682,8 +680,6 @@ static void __init setup_mm(unsigned long dtb_paddr, size_t dtb_size)
>  
>      setup_frametable_mappings(ram_start, ram_end);
>      max_page = PFN_DOWN(ram_end);
> -
> -    end_boot_allocator();
>  }
>  #endif
>  
> @@ -757,6 +753,8 @@ void __init start_xen(unsigned long boot_phys_offset,
>      /* Parse the ACPI tables for possible boot-time configuration */
>      acpi_boot_table_init();
>  
> +    end_boot_allocator();
> +
>      vm_init();
>      dt_unflatten_host_device_tree();
>  
> -- 
> 2.1.0
> 
