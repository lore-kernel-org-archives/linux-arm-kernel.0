From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 9 Mar 2015 15:01:19 +0000
Subject: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
In-Reply-To: <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:
> CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
> world we will have PCIe in most cases, but some of them may not,
> make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.
> 
> With that case, we need some arch dependent PCI functions to
> access the config space before the PCI root bridge is created, and
> pci_acpi_scan_root() to create the PCI root bus. So introduce
> some stub function here to make ACPI core compile and revisit
> them later when implemented on ARM64.
> 
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/pci.h |  6 ++++++
>  arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 872ba93..fded096 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -24,6 +24,12 @@
>   */
>  #define PCI_DMA_BUS_IS_PHYS	(0)

Hanjun,

>  
> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +	/* no legacy IRQ on arm64 */
> +	return -ENODEV;
> +}
> +

Could you explain to me what situation you encountered where you needed
to define this? I'm trying to figure out when this would be needed and the
only thing I can come up with would be for drivers/pnp/resource.c, but that
is guarded by #ifdef CONFIG_PCI, which would mean that you should move this
a bit further down in the file, but also contradicts the last comment on
this patch (i.e. PCI on ACPI is not really implemented, so presumably
CONFIG_PCI is not enabled?)

Best regards,
Liviu


>  extern int isa_dma_bridge_buggy;
>  
>  #ifdef CONFIG_PCI
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 6f93c24..4095379 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -10,6 +10,7 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -46,3 +47,27 @@ int pcibios_add_device(struct pci_dev *dev)
>  
>  	return 0;
>  }
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return -ENXIO;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_ACPI
> +/* Root bridge scanning */
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	/* TODO: Should be revisited when implementing PCI on ACPI */
> +	return NULL;
> +}
> +#endif
> -- 
> 1.9.1
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
