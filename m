From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 5 Apr 2017 11:52:54 -0500
Subject: [PATCH v6 01/23] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
In-Reply-To: <20170405085243.18123-2-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
 <20170405085243.18123-2-kishon@ti.com>
Message-ID: <20170405165254.GA17066@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 02:22:21PM +0530, Kishon Vijay Abraham I wrote:
> Introduce a new EP core layer in order to support endpoint functions in
> linux kernel. This comprises the EPC library (Endpoint Controller Library)
> and EPF library (Endpoint Function Library). EPC library implements
> functions specific to an endpoint controller and EPF library implements
> functions specific to an endpoint function.
> ...

> +/**
> + * pci_epf_linkup() - Notify the function driver that EPC device has
> + *		      established a connection with the Root Complex.
> + * @epf: the EPF device bound to the EPC device which has established
> + *	 the connection with the host
> + *
> + * Invoke to notify the function driver that EPC device has established
> + * a connection with the Root Complex.
> + */
> +void pci_epf_linkup(struct pci_epf *epf)
> +{
> +	if (!epf->driver)
> +		dev_WARN(&epf->dev, "epf device not bound to driver\n");
> +
> +	epf->driver->ops->linkup(epf);

I don't understand what's going on here.  We warn if epf->driver is
NULL, but the next thing we do is dereference it.

For NULL pointers that are symptoms of Linux defects, I usually prefer
not to check at all so that a dereference generates an oops and we can
debug the problem.  For NULL pointers caused by user error, we would
generally return an error that percolates up to the user.

I haven't competely wrapped my head around this endpoint support, but
I assume a NULL pointer here would be caused by user error, not
necessarily a Linux defect.  So why would we dereference a NULL
pointer?  And what happens when we do?  Is this just going to oops an
embedded Linux running inside the endpoint?  Is that the correct
behavior?

Bjorn
