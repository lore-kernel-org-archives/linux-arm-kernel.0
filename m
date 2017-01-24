From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Jan 2017 17:02:24 +0100
Subject: [PATCH 31/37] misc: Add host side pci driver for pci test
 function device
In-Reply-To: <1484216786-17292-32-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-32-git-send-email-kishon@ti.com>
Message-ID: <20170124160224.GA23528@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 03:56:20PM +0530, Kishon Vijay Abraham I wrote:
> Add PCI endpoint test driver that can verify base address
> register, legacy interrupt/MSI interrupt and read/write/copy
> buffers between host and device. The corresponding pci-epf-test
> function driver should be used on the EP side.

Just curious:  what would you think of a text based (e.g. debugfs)
interface to avoid the need for a userspace tool here?

> +static const struct pci_device_id pci_endpoint_test_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);

Also this looks really odd, and dangerous.  Probing for any
TI device will bind to all kinds of legit devices.  It would
be good if you could squeeze out a single id for this device
out of the TI group responsible for allocating it.  Otherwise
we might try some other venues, e.g. Red Hat through Qumranet
has PCI IDs available for virtio, which might have some left
for other Linux uses.

In general I fear the PCI ID allocation will become a worse
and worse issue once your framework goes in and we'll grow
more PCI device models in the kernel.
