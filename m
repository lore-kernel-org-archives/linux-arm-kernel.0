From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Sep 2013 21:22:42 +0200
Subject: [PATCH] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20130917191342.GA4354@obsidianresearch.com>
References: <20130917183853.GC21230@obsidianresearch.com>
 <20130917210503.1ea8cdd9@skate>
 <20130917191342.GA4354@obsidianresearch.com>
Message-ID: <20130917212242.5c306871@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 17 Sep 2013 13:13:42 -0600, Jason Gunthorpe wrote:

> Well, I'm not 100% sure, but AFAICT that is how struct resources
> should be used. The start/end address are inclusive, so the resource
> (start=0,end=0) describes 1 byte at address 0.
> 
> The only way to get a 0 sized resource is (start=0,end=-1)

So in the ideal world, we would have a resource_init(&res) that would
set start=0 and end=-1 or something like that.

> Before I did this I checked other user of resource_size and found
> tests to zero, so the above seems to be correct..
> 
> Eg a quick grep shows:
>  arch/powerpc/kernel/pci-common.c: pcibios_fixup_bridge
> 
>                 if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
>                         res->flags |= IORESOURCE_UNSET;
>                         res->start = 0;
>                         res->end = -1;
>                         continue;
>                 }
> 
> Do you see something different?

Well, apparently what you did is the commonly adopted way. Maybe just
add a comment in the code above those two lines to explain what may
seem a little strange initially?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
