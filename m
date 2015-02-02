From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 2 Feb 2015 13:40:33 +0000
Subject: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
In-Reply-To: <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150202134033.GR4278@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 08:45:36PM +0800, Hanjun Guo wrote:
> When system supporting both DT and ACPI but firmware providing
> no dtb, we can use this linux,uefi-stub-generated-dtb property
> to let kernel know that we can try ACPI configuration data even
> if no "acpi=force" is passed in early parameters.
> 
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: Grant Likely <grant.likely@linaro.org>
> CC: Matt Fleming <matt.fleming@intel.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm/uefi.txt         |  3 +++
>  arch/arm64/include/asm/acpi.h      |  1 +
>  arch/arm64/kernel/setup.c          | 30 ++++++++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/fdt.c |  8 ++++++++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/arm/uefi.txt b/Documentation/arm/uefi.txt
> index d60030a..5f86eae 100644
> --- a/Documentation/arm/uefi.txt
> +++ b/Documentation/arm/uefi.txt
> @@ -60,5 +60,8 @@ linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
>  --------------------------------------------------------------------------------
>  linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
>  --------------------------------------------------------------------------------
> +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB provided by
> +			       |      | firmware.
> +--------------------------------------------------------------------------------

Apologies for the late bikeshedding, but the discussion on this topic
previsously was lively enough that I thought I'd let it die down a bit
before seeing if I had anything to add.

That, and I just realised something:
One alternative to this added DT entry is that we could treat the
absence of a registered UEFI configuration table as the indication
that no HW description was provided from firmware, since the stub does
not call InstallConfigurationTable() on the DT it generates. This does
move the ability to detect to after efi_init(), but this should be
fine for ACPI-purposes.

If that is deemed undesirable, I would still prefer Catalin's
suggested name ("linux,bare-dtb"), which describes the state rather
than the route we took to get there.

>  For verbose debug messages, specify 'uefi_debug' on the kernel command line.
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 496c33b..9fcf632 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -49,6 +49,7 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  
>  #else
>  static inline void disable_acpi(void) { }
> +static inline void enable_acpi(void) { }
>  #endif /* CONFIG_ACPI */
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index fc4fb7b..510a681 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -371,6 +371,29 @@ static void __init request_standard_resources(void)
>  	}
>  }
>  
> +static int __init dt_scan_chosen(unsigned long node, const char *uname,
> +			int depth, void *data)
> +{
> +	const char *p;
> +
> +	if (depth != 1 || !data || (strcmp(uname, "chosen") != 0))
> +		return 0;
> +
> +	p = of_get_flat_dt_prop(node, "linux,uefi-stub-generated-dtb", NULL);
> +	*(bool *)data = p ? true : false;
> +
> +	return 1;
> +}
> +
> +static bool __init is_uefi_stub_generated_dtb(void)
> +{
> +	bool flag = false;
> +
> +	of_scan_flat_dt(dt_scan_chosen, &flag);
> +
> +	return flag;
> +}
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
>  void __init setup_arch(char **cmdline_p)
> @@ -399,6 +422,13 @@ void __init setup_arch(char **cmdline_p)
>  	parse_early_param();
>  
>  	/*
> +	 * If no dtb provided by firmware, enable ACPI and give system a
> +	 * chance to boot with ACPI configuration data
> +	 */
> +	if (is_uefi_stub_generated_dtb() && acpi_disabled)
> +		enable_acpi();
> +
> +	/*
>  	 *  Unmask asynchronous aborts after bringing up possible earlycon.
>  	 * (Report possible System Errors once we can report this occurred)
>  	 */
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index c846a96..3777d50 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -154,6 +154,14 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>  	if (status)
>  		goto fdt_set_fail;
>  
> +	/* Add a property to show the dtb is generated by uefi stub */
> +	if (!orig_fdt) {
> +		status = fdt_setprop(fdt, node,
> +				     "linux,uefi-stub-generated-dtb", NULL, 0);
> +		if (status)
> +			goto fdt_set_fail;
> +	}
> +
>  	return EFI_SUCCESS;
>  
>  fdt_set_fail:
> -- 
> 1.9.1
> 
