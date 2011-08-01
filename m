From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 01 Aug 2011 18:26:52 +0100 (BST)
Subject: [PATCH] arm: fix compile failure in orion5x/dns323-setup.c
In-Reply-To: <1312216934-29710-1-git-send-email-paul.gortmaker@windriver.com>
References: <1312216934-29710-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <alpine.LFD.2.00.1108011825190.18706@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Aug 2011, Paul Gortmaker wrote:

> Upstream commit d5341942d784134f2997b3ff82cd63cf71d1f932 "PCI: Make the
> struct pci_dev * argument of pci_fixup_irqs const." leaked an extra
> "const" into an actual call site (vs a proto/decl) which causes this:
> 
> arch/arm/mach-orion5x/dns323-setup.c: In function 'dns323_pci_map_irq':
> arch/arm/mach-orion5x/dns323-setup.c:80: error: expected expression before 'const'
> arch/arm/mach-orion5x/dns323-setup.c:80: error: too few arguments to function 'orion5x_pci_map_irq'
> make[3]: *** [arch/arm/mach-orion5x/dns323-setup.o] Error 1
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>
 
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index a6eddae..c105556 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -77,7 +77,7 @@ static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	/*
>  	 * Check for devices with hard-wired IRQs.
>  	 */
> -	irq = orion5x_pci_map_irq(const dev, slot, pin);
> +	irq = orion5x_pci_map_irq(dev, slot, pin);
>  	if (irq != -1)
>  		return irq;
>  
> -- 
> 1.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
