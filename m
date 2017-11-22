From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 22 Nov 2017 08:53:45 +0100
Subject: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
Message-ID: <20171122075345.GC26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:31:14AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  include/linux/i7300_idle.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
> index 4dbe651..58cd9c6 100644
> --- a/include/linux/i7300_idle.h
> +++ b/include/linux/i7300_idle.h
> @@ -48,7 +48,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
>  	int i;
>  	struct pci_dev *memdev, *dmadev;
>  
> -	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
> +	memdev = pci_get_domain_bus_and_slot(0, MEMCTL_BUS, MEMCTL_DEVFN);

You have a pci_dev, why can't you use it here to get the domain?

>  	if (!memdev)
>  		return -ENODEV;
>  
> @@ -61,7 +61,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
>  	if (pci_tbl[i].vendor == 0)
>  		return -ENODEV;
>  
> -	dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
> +	dmadev = pci_get_domain_bus_and_slot(0, IOAT_BUS, IOAT_DEVFN);

Same here.

thanks,

greg k-h
