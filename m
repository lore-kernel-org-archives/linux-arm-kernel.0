From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 22 Nov 2017 17:45:46 +0100
Subject: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
In-Reply-To: <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
 <20171122075345.GC26583@kroah.com>
 <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
Message-ID: <20171122164546.GB30812@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 11:15:47AM -0500, Sinan Kaya wrote:
> On 11/22/2017 2:53 AM, Greg Kroah-Hartman wrote:
> >> +++ b/include/linux/i7300_idle.h
> >> @@ -48,7 +48,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
> >>  	int i;
> >>  	struct pci_dev *memdev, *dmadev;
> >>  
> >> -	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
> >> +	memdev = pci_get_domain_bus_and_slot(0, MEMCTL_BUS, MEMCTL_DEVFN);
> > You have a pci_dev, why can't you use it here to get the domain?
> > 
> 
> Both fbd_dev and ioat_dev are output parameters. 
> 
> dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
> memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
> 
> 	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
> 		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
> 		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
> 			if (!(fbd_ioat_list[i].enabled || enable_all))
> 				continue;
> 
> 			if (fbd_dev)
> 				*fbd_dev = memdev;
> 			if (ioat_dev)
> 				*ioat_dev = dmadev;
> 
> Funny thing is nobody is calling this function. Maybe, I should just kill it
> instead.

Yes, delete it.  Why doesn't the build warn about it not being used?

thanks,

greg k-h
