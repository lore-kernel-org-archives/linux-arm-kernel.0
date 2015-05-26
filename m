From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 26 May 2015 17:58:44 +0100
Subject: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
In-Reply-To: <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150526165844.GD2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
> ARM64 ACPI based PCI host bridge init needs a arch dependent
> struct pci_controller to accommodate common PCI host bridge
> code which is introduced later, or it will lead to compile
> errors on ARM64.

Hi Hanjun,

Two questions: why don't you introduce this patch next to the
one that is going to make use of it (or even merge it there)?
Second, why is the whole struct pci_controller not surrounded
by #ifdef CONFIG_ACPI as you are implying that this is needed
only for ACPI?

Btw, looking through the whole series I'm not (yet) convinced
that this is needed at all.

Best regards,
Liviu

> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pci.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72..7088495 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -10,6 +10,16 @@
>  #include <asm-generic/pci-bridge.h>
>  #include <asm-generic/pci-dma-compat.h>
>  
> +struct acpi_device;
> +
> +struct pci_controller {
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *companion;	/* ACPI companion device */
> +#endif
> +	int		segment;	/* PCI domain */
> +	int		node;		/* NUMA node */
> +};
> +
>  #define PCIBIOS_MIN_IO		0x1000
>  #define PCIBIOS_MIN_MEM		0
>  
> -- 
> 1.9.1
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
