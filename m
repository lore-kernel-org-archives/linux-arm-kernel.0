From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 19 Aug 2017 12:10:48 +0100
Subject: [PATCH v3 2/8] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
In-Reply-To: <20170808122259.6299-3-rrichter@cavium.com> (Robert Richter's
 message of "Tue, 8 Aug 2017 14:22:52 +0200")
References: <20170808122259.6299-1-rrichter@cavium.com>
 <20170808122259.6299-3-rrichter@cavium.com>
Message-ID: <86wp5zx16v.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08 2017 at  2:22:52 pm BST, Robert Richter <rrichter@cavium.com> wrote:
> This allows us to use kernel core functionality (e.g. cma) for ITS
> initialization. MSIs must be up before the device_initcalls (pci and
> platform device probe) and after arch_initcalls (dma init), so
> subsys_initcall is fine.
>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 +-
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index 77931214d954..5940fdf0036e 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -193,4 +193,4 @@ static int __init its_pci_msi_init(void)
>  
>  	return 0;
>  }
> -early_initcall(its_pci_msi_init);
> +subsys_initcall(its_pci_msi_init);
> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index 249240d9a425..6ebc871ac63f 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -166,4 +166,4 @@ static int __init its_pmsi_init(void)
>  	its_pmsi_acpi_init();
>  	return 0;
>  }
> -early_initcall(its_pmsi_init);
> +subsys_initcall(its_pmsi_init);

You've missed the fsl-mc stuff in staging, which has the same behaviour,
except that it is a postcore_initcall.

More importantly, what guarantees do we have that this doesn't break
anything else? Sure, the ITS itself will work fine, but what about the
subsystems that depend on it? Just on the PCI side, I can see a bunch of
initcalls that are much earlier than subsys, and that says nothing of
other subsystems (such as the above fsl stuff).

I'm not saying that this is wrong, but I'd like some evidence that
you've done the required due diligence, ensuring this will not cause any
regression.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
