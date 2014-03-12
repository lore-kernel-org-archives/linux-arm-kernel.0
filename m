From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 12 Mar 2014 17:41:33 +0900
Subject: [PATCH v6 3/3] arm64: Add architecture support for PCI
In-Reply-To: <1394020150-1875-4-git-send-email-Liviu.Dudau@arm.com>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020150-1875-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <000101cf3dce$df2c1840$9d8448c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 05, 2014 8:49 PM, Liviu Dudau wrote:
> 
> Use the generic host bridge functions to provide support for
> PCI Express on arm64. There is no support for ISA memory.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  arch/arm64/Kconfig            |  19 +++-
>  arch/arm64/include/asm/Kbuild |   1 +
>  arch/arm64/include/asm/io.h   |   3 +-
>  arch/arm64/include/asm/pci.h  |  49 +++++++++
>  arch/arm64/kernel/Makefile    |   1 +
>  arch/arm64/kernel/pci.c       | 173 ++++++++++++++++++++++++++++++++
>  6 files changed, 244 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pci.h
>  create mode 100644 arch/arm64/kernel/pci.c

[.....]

> --- /dev/null
> +++ b/arch/arm64/include/asm/pci.h

[.....]

> +
> +static inline int pci_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
> +
> +	if (bridge)
> +		return bridge->domain_nr;
> +
> +	return 0;
> +}

Hi Liviu Dudau,

When CONFIG_PCI=n, the following build errors happen. :-(
Would you confirm this?

In file included from include/linux/pci.h:1393:0,
                 from drivers/scsi/scsi_lib.c:19:
arch/arm64/include/asm/pci.h:31:19: error: redefinition of 'pci_domain_nr'
 static inline int pci_domain_nr(struct pci_bus *bus)
                   ^
In file included from drivers/scsi/scsi_lib.c:19:0:
include/linux/pci.h:1383:19: note: previous definition of 'pci_domain_nr' was here
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
                   ^
             .....

Best regards,
Jingoo Han
