From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Sep 2015 15:31:24 +0100
Subject: [PATCH] arm64: dmi: initialize DMI earlier in boot
In-Reply-To: <1442585666-14093-1-git-send-email-msalter@redhat.com>
References: <1442585666-14093-1-git-send-email-msalter@redhat.com>
Message-ID: <20150918143124.GA31683@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 03:14:26PM +0100, Mark Salter wrote:
> Currently, DMI initialization takes place in a core initcall. This
> limits how early in boot the kernel can make DMI-based decisions
> about firmware/hardware quirks. This patch moves DMI initialization
> to setup_arch() so that DMI info is available before initcalls run.

Which firmware/hardware quirks in particular necessitate moving this?

> 
> ---
>  arch/arm64/include/asm/dmi.h | 19 ++++++++++++++++---
>  arch/arm64/kernel/efi.c      | 15 ---------------
>  arch/arm64/kernel/setup.c    |  5 +++++
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
> index 69d37d8..e6389fd 100644
> --- a/arch/arm64/include/asm/dmi.h
> +++ b/arch/arm64/include/asm/dmi.h
> @@ -16,16 +16,29 @@
>  
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/memblock.h>

Nit: please keep includes ordered (given they were already).

[...]

> @@ -413,20 +412,6 @@ static int __init arm64_enable_runtime_services(void)
>  }
>  early_initcall(arm64_enable_runtime_services);
>  
> -static int __init arm64_dmi_init(void)
> -{
> -	/*
> -	 * On arm64, DMI depends on UEFI, and dmi_scan_machine() needs to
> -	 * be called early because dmi_id_init(), which is an arch_initcall
> -	 * itself, depends on dmi_scan_machine() having been called already.
> -	 */
> -	dmi_scan_machine();
> -	if (dmi_available)
> -		dmi_set_dump_stack_arch_desc();
> -	return 0;
> -}
> -core_initcall(arm64_dmi_init);
> -
>  static void efi_set_pgd(struct mm_struct *mm)
>  {
>  	if (mm == &init_mm)
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index dc9eb5f..200c2e9 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -46,6 +46,7 @@
>  #include <linux/efi.h>
>  #include <linux/personality.h>
>  #include <linux/psci.h>
> +#include <linux/dmi.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/fixmap.h>
> @@ -436,6 +437,10 @@ void __init setup_arch(char **cmdline_p)
>  	relocate_initrd();
>  	request_standard_resources();
>  
> +	dmi_scan_machine();
> +	if (dmi_available)
> +		dmi_set_dump_stack_arch_desc();

We should have a comment as to why this needs to happen so early (much
like we used to).

Mark.
