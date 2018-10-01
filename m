From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Mon, 01 Oct 2018 16:44:44 +0200
Subject: [PATCH] PCI: mvebu: Fix PCI I/O mapping creation sequence
In-Reply-To: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
References: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
Message-ID: <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pond?l? 1. ??jna 2018 14:49:34 CEST, Thomas Petazzoni wrote:
> Commit ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") had the side effect that the PCI I/O mapping was created
> much earlier than before, at a point where the probe() of the driver
> could still fail. This is for example a problem if one gets an
> -EPROBE_DEFER at some point during probe(), after pci_ioremap_io() has
> been called.
>
> Indeed, there is currently no function to undo what pci_ioremap_io()
> did, and switching to pci_remap_iospace() is not an option in
> pci-mvebu due to the need for special memory attributes on Armada 38x.
>
> Reverting ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") would be a possibility, but it would require also
> reverting 42342073e38b5 ("PCI: mvebu: Convert to use pci_host_bridge
> directly"). So instead, we use an open-coded version of
> pci_host_probe() that creates the PCI I/O mapping at a point where we
> are guaranteed not to fail anymore.
>
> Reported-by: Jan Kundr?t <jan.kundrat@cesnet.cz>
> Fixes: ee1604381a371 ("PCI: mvebu: Only remap I/O space if configured")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Tested-by: Jan Kundr?t <jan.kundrat@cesnet.cz>

Just a rebuild-and-boot test. We don't use any PCIe devices yet, but I'll 
grab an ugly eBay converter and try this patch with a normal PCIe card 
later.

Thanks!

Jan
