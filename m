From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jul 2013 14:58:27 +0200
Subject: [PATCHv5 05/11] of: pci: add registry of MSI chips
In-Reply-To: <20130729142600.63eeab50@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E41F7A.4010502@gmail.com> <20130728043310.6CF1D3E08FE@localhost>
 <20130728162711.32a9a21e@skate> <20130729065431.GA1115@manwe>
 <20130729142600.63eeab50@skate>
Message-ID: <20130729125826.GH23152@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 02:26:00PM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Mon, 29 Jul 2013 08:54:31 +0200, Thierry Reding wrote:
> 
> > > So what is your suggestion to allow the PCIe controller to retrieve the
> > > correct irq_domain if we have only one DT node for the IRQ controller
> > > that registers two irq_domains ?
> > 
> > If I understand correctly, Grant isn't objecting to the introduction of
> > the lookup function, but rather its implementation. You could add a
> > pointer to a struct msi_chip within struct irq_domain and then iterate
> > over all irq_domain instances (see irq_find_host()) and find one which
> > has the correct device_node pointer and the msi_chip pointer set.
> 
> Ah ok. The only trick is that we have to change irq_find_host() to
> *not* match on MSI domains. Can you check the below patch to see if it
> matches what Grant suggested? It works for me, and it allows to completely
> remove the registry of msi_chip in drivers/of, as well as the of_node
> pointer in struct msi_chip.
> 
> Thanks!
> 
> Thomas
> 
> From c2c0137cb110270f96e1e0fa298a5d585b8d829e Mon Sep 17 00:00:00 2001
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date: Mon, 29 Jul 2013 14:12:31 +0200
> Subject: [PATCHv6 05/11] irqdomain: add support to associate an irq_domain
>  with a msi_chip
> 
> Message Signaled Interrupts are a PCI-specific mechanism that allows
> PCI devices to notify interrupts to the CPU using in-band
> messages. The PCI subsystem represents an MSI-capable interrupt
> controller as an msi_chip structure, and this patch improves the
> irqdomain subsystem with a new pointer associating an irq_domain with
> the corresponding msi_chip.
> 
> The __irq_domain_add() function is augmented with an additional
> argument, the 'msi_chip' pointer, and all callers of this function are
> updated.
> 
> A new function irq_domain_add_msi() function is added to allow the
> registration of an MSI-type irq domain.
> 
> The irq_find_host() function is modified to not match on MSI-type irq
> domains: a given DT device node may represent both a normal interrupt
> controller and a MSI interrupt controller. irq_find_host() should
> return the irq_domain that corresponds to the normal interupt

"interupt" -> "interrupt"

> controller.
> 
> An irq_find_msi() function is added to get the MSI_type irq domain

"MSI_type" -> "MSI-type".

> given a DT device node.

And "irq domain" -> "IRQ domain" in all of the above.

> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
[...]
> @@ -162,7 +167,16 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
>  					 const struct irq_domain_ops *ops,
>  					 void *host_data)
>  {
> -	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
> +	return __irq_domain_add(of_node, 0, ~0, 0, ops, NULL, host_data);
> +}
> +static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
> +						    unsigned int size,
> +						    const struct irq_domain_ops *ops,
> +						    struct msi_chip *msi_chip,
> +						    void *host_data)
> +{
> +	return __irq_domain_add(of_node, size, size, 0, ops,
> +				msi_chip, host_data);
>  }

Given that the majority of interrupt controllers probably don't have any
MSI functionality, I wonder if perhaps this should be done in a more
helper-oriented way, see below...

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
[...]
> @@ -198,6 +201,12 @@ struct irq_domain *irq_find_host(struct device_node *node)
>  	 */
>  	mutex_lock(&irq_domain_mutex);
>  	list_for_each_entry(h, &irq_domain_list, link) {
> +		/*
> +		 * We only want to match normal interrupt domains, not
> +		 * MSI domains
> +		 */
> +		if (h->msi_chip)
> +			continue;
>  		if (h->ops->match)
>  			rc = h->ops->match(h, node);
>  		else
> @@ -214,6 +223,28 @@ struct irq_domain *irq_find_host(struct device_node *node)
>  EXPORT_SYMBOL_GPL(irq_find_host);
>  
>  /**
> + * irq_find_msi() - Locates a MSI domain for a given device node
> + * @node: device-tree node of the interrupt controller
> + */
> +struct irq_domain *irq_find_msi(struct device_node *node)
> +{
> +	struct irq_domain *h, *found = NULL;
> +
> +	mutex_lock(&irq_domain_mutex);
> +	list_for_each_entry(h, &irq_domain_list, link) {
> +		if (!h->msi_chip)
> +			continue;
> +		if (h->of_node && h->of_node == node) {
> +			found = h;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&irq_domain_mutex);
> +	return found;
> +}
> +EXPORT_SYMBOL_GPL(irq_find_msi);

This doesn't quite copy what irq_find_host() does, since it ignores the
associated ops->match().

But given that ops->match() already provides a way to hook into the
lookup, perhaps we could add a function such as this:

	int irq_domain_supports_msi(struct irq_domain *d, struct device_node *node)
	{
		if ((d->of_node == NULL) || (d->of_node != node))
			return 0;

		return d->msi_chip != NULL;
	}

Then use that in drivers that expose MSI functionality via an IRQ domain
like this:

	static const struct irq_domain_ops foo_irq_domain_ops = {
		...
		.match = irq_domain_supports_msi,
		...
	};

One problem with this is that it doesn't solve your problem where two
different IRQ domains are exposed by the same device, because the
irq_find_host() will still match the MSI IRQ domain for the non-MSI
device node as well. This could be solved by adding another match
function...

This goes in hand with the helper-style API that I mentioned above. But
it's really up to Grant to decide which way he wants this to go.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/4b52a29e/attachment-0001.sig>
