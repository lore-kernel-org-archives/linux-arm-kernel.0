From: Wei.Yang@windriver.com (Yang,Wei)
Date: Wed, 2 Jul 2014 17:19:40 +0800
Subject: [PATCH v1] ARM:sa1100: Remove a redundant spin lock
In-Reply-To: <1404200488-7809-1-git-send-email-Wei.Yang@windriver.com>
References: <1404200488-7809-1-git-send-email-Wei.Yang@windriver.com>
Message-ID: <53B3CEAC.9080609@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

What about this patch?

Thanks
Wei
On 07/01/2014 03:41 PM, Wei.Yang at windriver.com wrote:
> From: Yang Wei <Wei.Yang@windriver.com>
>
> The pair read/write of accessing pci confiuration space function
> has already protected by pci_lock. so remove nano_lock.
>
> Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
> ---
>   arch/arm/mach-sa1100/pci-nanoengine.c |    9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
> index ff02e2d..b944c99 100644
> --- a/arch/arm/mach-sa1100/pci-nanoengine.c
> +++ b/arch/arm/mach-sa1100/pci-nanoengine.c
> @@ -30,7 +30,6 @@
>   #include <mach/nanoengine.h>
>   #include <mach/hardware.h>
>   
> -static DEFINE_SPINLOCK(nano_lock);
>   
>   static int nanoengine_get_pci_address(struct pci_bus *bus,
>   	unsigned int devfn, int where, unsigned long *address)
> @@ -52,7 +51,6 @@ static int nanoengine_read_config(struct pci_bus *bus, unsigned int devfn, int w
>   {
>   	int ret;
>   	unsigned long address;
> -	unsigned long flags;
>   	u32 v;
>   
>   	/* nanoEngine PCI bridge does not return -1 for a non-existing
> @@ -64,15 +62,12 @@ static int nanoengine_read_config(struct pci_bus *bus, unsigned int devfn, int w
>   		goto exit_function;
>   	}
>   
> -	spin_lock_irqsave(&nano_lock, flags);
>   
>   	ret = nanoengine_get_pci_address(bus, devfn, where, &address);
>   	if (ret != PCIBIOS_SUCCESSFUL)
>   		return ret;
>   	v = __raw_readl(address);
>   
> -	spin_unlock_irqrestore(&nano_lock, flags);
> -
>   	v >>= ((where & 3) * 8);
>   	v &= (unsigned long)(-1) >> ((4 - size) * 8);
>   
> @@ -86,13 +81,11 @@ static int nanoengine_write_config(struct pci_bus *bus, unsigned int devfn, int
>   {
>   	int ret;
>   	unsigned long address;
> -	unsigned long flags;
>   	unsigned shift;
>   	u32 v;
>   
>   	shift = (where & 3) * 8;
>   
> -	spin_lock_irqsave(&nano_lock, flags);
>   
>   	ret = nanoengine_get_pci_address(bus, devfn, where, &address);
>   	if (ret != PCIBIOS_SUCCESSFUL)
> @@ -113,8 +106,6 @@ static int nanoengine_write_config(struct pci_bus *bus, unsigned int devfn, int
>   	}
>   	__raw_writel(v, address);
>   
> -	spin_unlock_irqrestore(&nano_lock, flags);
> -
>   	return PCIBIOS_SUCCESSFUL;
>   }
>   
