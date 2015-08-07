From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 11:48:03 +0100
Subject: [PATCH v4 09/10] PCI: ACPI: Bind GIC MSI frame to PCI host bridge
In-Reply-To: <55C4826C.80600@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
 <55C4826C.80600@linaro.org>
Message-ID: <20150807104803.GO20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 12:03:24PM +0200, Tomasz Nowicki wrote:

> >@@ -670,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
> >  	 * should be called from here.
> >  	 */
> >  	d = pci_host_bridge_of_msi_domain(bus);
> >+	if (!d)
> >+		d = pci_host_bridge_acpi_msi_domain(bus);
> 
> Please use acpi_disabled here.

> BTW. This is another place where we need to know our firmware - DT vs ACPI.
> I know we can use acpi_disabled but I think more about generic solution.
> Since we already have:
> struct fwnode_handle	*fwnode;
> we can create macro which identify h/w description style, something like:

> #define FWNODE_TYPE(dev)	dev_fwnode(dev)->type

> and then:

> switch (FWNODE_TYPE(&bus->dev)) {
> case FWNODE_OF:
> ...
> case FWNODE_ACPI:
> ...
> case FWNODE_XXX:
> ...
> }

> Root bus is special case since it has no frimware type but we could factor
> out pci_set_bus_of_node(). For platform devices we have all we need. Just
> thinking aloud, let me know your thoughts.

Not knowing the particular detail here but can we not go a step further
than that and have a fwnode_disabled() for this which does appropriate
things for both ACPI and DT?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/f5c2fece/attachment.sig>
