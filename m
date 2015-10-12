From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 12 Oct 2015 13:31:09 -0500
Subject: [PATCH 03/16] irqdomain: Allow irq domain lookup by fwnode
In-Reply-To: <1444152989-31726-4-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
 <1444152989-31726-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <561BFC6D.6020500@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[RESEND] Not sure if the email went out the first time.

Hi Marc,

On 10/6/15 12:36, Marc Zyngier wrote:
> So far, our irq domains are still looked up by device node.
> Let's change this and allow a domain to be looked up using
> a fwnode_handle pointer.
>
> The existing interfaces are preserved with a couple of helpers.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   include/linux/irqdomain.h | 11 +++++++++--
>   kernel/irq/irqdomain.c    | 14 ++++++--------
>   2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 2f508f4..607c185 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -183,10 +183,17 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>   					 irq_hw_number_t first_hwirq,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data);
> -extern struct irq_domain *irq_find_matching_host(struct device_node *node,
> -						 enum irq_domain_bus_token bus_token);
> +extern struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
> +						   enum irq_domain_bus_token bus_token);
>   extern void irq_set_default_host(struct irq_domain *host);
>
> +static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
> +							enum irq_domain_bus_token bus_token)
> +{
> +	return irq_find_matching_fwnode(node ? &node->fwnode : NULL,
> +					bus_token);
> +}
> +
>   static inline struct irq_domain *irq_find_host(struct device_node *node)
>   {
>   	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 1aee5c1..10b6105 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -191,12 +191,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>   EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
>
>   /**
> - * irq_find_matching_host() - Locates a domain for a given device node
> - * @node: device-tree node of the interrupt controller
> + * irq_find_matching_fwnode() - Locates a domain for a given fwnode
> + * @fwnode: FW descriptor of the interrupt controller
>    * @bus_token: domain-specific data
>    */
> -struct irq_domain *irq_find_matching_host(struct device_node *node,
> -					  enum irq_domain_bus_token bus_token)
> +struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
> +					    enum irq_domain_bus_token bus_token)
>   {
>   	struct irq_domain *h, *found = NULL;
>   	int rc;
> @@ -212,12 +212,10 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
>   	 */
>   	mutex_lock(&irq_domain_mutex);
>   	list_for_each_entry(h, &irq_domain_list, link) {
> -		struct device_node *of_node;
> -		of_node = irq_domain_get_of_node(h);
>   		if (h->ops->match)
> -			rc = h->ops->match(h, node, bus_token);
> +			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
>   		else
> -			rc = ((of_node != NULL) && (of_node == node) &&
> +			rc = ((fwnode != NULL) && (h->fwnode == fwnode) &&
>   			      ((bus_token == DOMAIN_BUS_ANY) ||
>   			       (h->bus_token == bus_token)));
>
>

In the kernel/irq/irq_domain.c, shouldn't you also change the export 
symbol from:

     EXPORT_SYMBOL_GPL(irq_find_matching_host);

to:

     EXPORT_SYMBOL_GPL(irq_find_matching_fwnode);

at the end of this function as well?

Thanks,
Suravee
