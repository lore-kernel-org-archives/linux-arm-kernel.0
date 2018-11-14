From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 14 Nov 2018 16:37:59 +0000
Subject: [PATCH] arm64: acpi/pci: WARN() when ignoring _DSM request to
 preserve PCI resources
In-Reply-To: <20181112111511.12091-1-ard.biesheuvel@linaro.org>
References: <20181112111511.12091-1-ard.biesheuvel@linaro.org>
Message-ID: <20181114163747.GA15275@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 12:15:11PM +0100, Ard Biesheuvel wrote:
> On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
> hierarchy at boot. This is a departure from what is customary on ACPI
> systems, and may break assumptions in some places (e.g., CCIX), that
> the OS will honour the PCI resource allocation as configured by the
> firmware.

Hi Ard,

actually that's partially true, ie on arm64 ACPI we do not reassign bus
numbers if firmware values are set-up with "valid" values, ie
PCI_REASSIGN_ALL_BUS flag isn't set.

Whether that's supposed to be part of the "resources" this _DSM affect I
do not know, what I know is that if we change the default behaviour
we seriously risk running into regressions, however we slice it.

> ACPI already specifies a device specific ACPI method (_DSM) for PCI
> root bridge nodes that tells us whether the firmware thinks the
> configuration should be ignored or preserved, but unfortunately, we
> cannot simply change the behavior of the OS and start honouring
> these requests unconditionally, given that firmware implementations
> in the field may issue the _DSM request inadvertently and still rely
> on the OS to create the resource allocation from scratch.
> 
> So as a preliminary step, let's issue a warning about this case,
> increasing the likelihood that we can fix this behavior at some
> point in the future.

I see what you want to achieve and that's reasonable, minus my
remark above, we should decide what we do on that because that's
inconsistent with the warning produced if the _DSM is present
and returns 0.

Thanks,
Lorenzo

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/pci.c  | 15 +++++++++++++++
>  include/linux/pci-acpi.h |  7 ++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index bb85e2f4603f..318ca865c41f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	union acpi_object *obj;
>  
>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
> @@ -193,6 +194,20 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> +	/*
> +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +	 * Configuration', which tells us whether the firmware wants us to
> +	 * preserve or ignore the firmware's configuration of the PCI resource
> +	 * tree for this root bridge.
> +	 */
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +				IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		WARN_ONCE(obj->integer.value == 0,
> +			  "Firmware did not request its PCI resource allocation to be ignored, but ignoring it anyway\n");
> +
> +	ACPI_FREE(obj);
> +
>  	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
>  
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 8082b612f561..62b7fdcc661c 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
>  extern const guid_t pci_acpi_dsm_guid;
> -#define DEVICE_LABEL_DSM	0x07
> -#define RESET_DELAY_DSM		0x08
> -#define FUNCTION_DELAY_DSM	0x09
> +#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> +#define DEVICE_LABEL_DSM		0x07
> +#define RESET_DELAY_DSM			0x08
> +#define FUNCTION_DELAY_DSM		0x09
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> -- 
> 2.17.1
> 
