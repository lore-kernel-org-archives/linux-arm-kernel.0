From: slash.tmp@free.fr (Mason)
Date: Mon, 6 Mar 2017 14:49:47 +0100
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
Message-ID: <76dea81d-c524-ad40-06bf-e549bb457f59@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2017 13:42, Mason wrote:

> So the kernel panics in xhci_find_next_ext_cap()
> ( drivers/usb/host/xhci-ext-caps.h:122 )
> http://lxr.free-electrons.com/source/drivers/usb/host/xhci-ext-caps.h?v=4.9#L122
> 
> Any idea how this can happen?
> 
> 	base = ioremap_nocache(pci_resource_start(pdev, 0), len);
> 
> Could I be passing garbage to ioremap_nocache?

Oh...

I have just now understood what Ard wrote a few days ago.

The issue was that, on this platform, the PCI configuration space
and memory space are multiplexed; in other words they reside at
the same physical address, with a bit in MMIO to choose one or
the other.

I was specifying an arbitrary address for the memory space,
which doesn't make any sense, as Ard pointed out.

So quirk_usb_handoff_xhci would ioremap(0x91000000, 8192)
which is the size of the USB device's memory region, but
0x91000000 is an address in system RAM. Thus, the readl
was actually picking up random garbage in RAM, which
makes xhci_find_next_ext_cap blow up pretty fast.

[    1.265224] xhci_find_next_ext_cap: offset=0xec44

I'm off to fix my blunder.

Regards.
