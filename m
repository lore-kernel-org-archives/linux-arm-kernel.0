From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 16:43:55 +0000
Subject: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
In-Reply-To: <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
Message-ID: <20170320164354.GQ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 03:14:16PM +0000, Lorenzo Pieralisi wrote:
> The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> and Posting") define rules for PCI configuration space transactions
> ordering and posting, that state that configuration writes have to
> be non-posted transactions.
> 
> Current ioremap interface on ARM provides mapping functions that
> provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
> memory type) aka posted writes, so PCI host controller drivers have
> no arch interface to remap PCI configuration space with memory
> attributes that comply with the PCI specifications for configuration
> space.
> 
> Implement an ARM specific pci_remap_cfgspace() interface that allows to
> map PCI config memory regions with MT_UNCACHED memory type (ie strongly
> ordered - non-posted writes), providing a remap function that complies
> with PCI specifications for config space transactions.

Doesn't this have the side effect that configuration writes can bypass
writes to device memory if there isn't an intervening dsb?  (They
probably can do on some CPUs today anyway.)

So, in any case, this looks like an improvement:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
