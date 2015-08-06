From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Thu, 06 Aug 2015 13:34:52 -0400
Subject: Fw: drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such
 file or directory
In-Reply-To: <20150806170426.GM1820@rric.localhost>
References: <20150806170426.GM1820@rric.localhost>
Message-ID: <55C39ABC.5020101@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2015 01:04 PM, Robert Richter wrote:
> Boris,
>
> we are working on acpi pci support for arm64. For this we are enabling
> PCI_MMCONFIG on arm64 which breaks compiling drivers/xen/pci.c.
>
> Looking into it there is x86 code in generic driver code introduced
> with:
>
>   8deb3eb1461e xen/mcfg: Call PHYSDEVOP_pci_mmcfg_reserved for MCFG areas.
>
> This implements:
>
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 18fff88254eb..d15f6e80479f 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -26,6 +26,7 @@
>   #include <asm/xen/hypervisor.h>
>   #include <asm/xen/hypercall.h>
>   #include "../pci/pci.h"
> +#include <asm/pci_x86.h>
>   
>   static bool __read_mostly pci_seg_supported = true;
>   
> @@ -192,3 +193,49 @@ static int __init register_xen_pci_notifier(void)
>   }
>   
>   arch_initcall(register_xen_pci_notifier);
> +
> +#ifdef CONFIG_PCI_MMCONFIG
> +static int __init xen_mcfg_late(void)
> +{
> +       struct pci_mmcfg_region *cfg;
> +       int rc;
> +
> +       if (!xen_initial_domain())
> +               return 0;
> +
> +       if ((pci_probe & PCI_PROBE_MMCONF) == 0)
> +               return 0;
> [...]
>
> There are no defines for pci_probe and PCI_PROBE_MMCONF other than for
> the x86 architecture.
>
> I see several ways to fix that:
>
>   * moving code to arch/x86/pci/xen.c,

If this routine is not going to be used by ARM I think this would be the 
way to go. Stefano --- will this be needed by ARM?

>
>   * make code dependent on arch X86,
>
>   * make 'if (pci_probe & PCI_PROBE_MMCONF) ...' an arch function to be
>     implemented by archs,

Otherwise I'd go with this.

-boris

>
>   * reworking the code by removing the check (not sure if that could be
>     done).
>
> I don't think PCI_XEN is enabled yet for arm64, so we just disalbe it
> for !X86 or move it to arch/x86. I suggest the latter. Is there any
> preference you have?
