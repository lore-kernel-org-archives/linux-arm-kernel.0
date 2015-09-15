From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Tue, 15 Sep 2015 12:58:42 +0200
Subject: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency on
 struct device_node
In-Reply-To: <1442249047-21182-3-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
 <1442249047-21182-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <55F7F9E2.3070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 18:44, Marc Zyngier wrote:
> struct device_node is very much DT specific, and the original authors
> of the irqdomain subsystem recognized that tie, and went as far as
> mentionning that this could be replaced by some "void *token",
> should another firmware infrastructure be using it.
>
> As we move ACPI on arm64 towards this model too, it makes a lot of sense
> to perform that particular move.
>
> We replace "struct device_node *of_node" with "void *domain_token", which
> is a benign enough transformation. A non DT user of irqdomain can now
> identify its domains using this pointer.
>
> Also, in order to prevent the introduction of sideband type information,
> only DT is allowed to store a valid kernel pointer in domain_token
> (a pointer that passes the virt_addr_valid() test will be considered
> as a valid device_node).
>
> non-DT users that wish to store valid pointers in domain_token are
> required to use another structure such as an IDR.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   include/linux/irqdomain.h | 68 +++++++++++++++++++-----------------
>   kernel/irq/irqdomain.c    | 89 ++++++++++++++++++++++++++++++++++-------------
>   2 files changed, 101 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index f644fdb..ac7041b 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -17,16 +17,14 @@
>    * model). It's the domain callbacks that are responsible for setting the
>    * irq_chip on a given irq_desc after it's been mapped.
>    *
> - * The host code and data structures are agnostic to whether or not
> - * we use an open firmware device-tree. We do have references to struct
> - * device_node in two places: in irq_find_host() to find the host matching
> - * a given interrupt controller node, and of course as an argument to its
> - * counterpart domain->ops->match() callback. However, those are treated as
> - * generic pointers by the core and the fact that it's actually a device-node
> - * pointer is purely a convention between callers and implementation. This
> - * code could thus be used on other architectures by replacing those two
> - * by some sort of arch-specific void * "token" used to identify interrupt
> - * controllers.
> + * The host code and data structures are agnostic to whether or not we
> + * use an open firmware device-tree. Domains can be assigned a
> + * "void *domain_token" identifier, which is assumed to represent a
> + * "struct device_node" if the pointer is a valid virtual address.
> + *
> + * Otherwise, the value is assumed to be an opaque identifier. Should
> + * a pointer to a non "struct device_node" be required, another data
> + * structure should be used to indirect it (an IDR for example).
>    */
>
>   #ifndef _LINUX_IRQDOMAIN_H
> @@ -108,8 +106,8 @@ struct irq_domain_chip_generic;
>    * @flags: host per irq_domain flags
>    *
>    * Optional elements
> - * @of_node: Pointer to device tree nodes associated with the irq_domain. Used
> - *           when decoding device tree interrupt specifiers.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>    * @gc: Pointer to a list of generic chips. There is a helper function for
>    *      setting up one or more generic chips for interrupt controllers
>    *      drivers using the generic chip library which uses this pointer.
> @@ -130,7 +128,7 @@ struct irq_domain {
>   	unsigned int flags;
>
>   	/* Optional data */
> -	struct device_node *of_node;
> +	void *domain_token;
>   	enum irq_domain_bus_token bus_token;
>   	struct irq_domain_chip_generic *gc;
>   #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> @@ -161,70 +159,73 @@ enum {
>   	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
>   };
>
> +#ifdef CONFIG_IRQ_DOMAIN
> +extern struct device_node *irq_domain_token_to_of_node(void *domain_token);
> +
>   static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
>   {
> -	return d->of_node;
> +	return irq_domain_token_to_of_node(d->domain_token);
>   }
>
> -#ifdef CONFIG_IRQ_DOMAIN
> -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
> +struct irq_domain *__irq_domain_add(void *domain_token, int size,
>   				    irq_hw_number_t hwirq_max, int direct_max,
>   				    const struct irq_domain_ops *ops,
>   				    void *host_data);
> -struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_simple(void *domain_token,
>   					 unsigned int size,
>   					 unsigned int first_irq,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data);
> -struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_legacy(void *domain_token,
>   					 unsigned int size,
>   					 unsigned int first_irq,
>   					 irq_hw_number_t first_hwirq,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data);
> -extern struct irq_domain *irq_find_matching_host(struct device_node *node,
> +extern struct irq_domain *irq_find_matching_host(void *domain_token,
>   						 enum irq_domain_bus_token bus_token);
>   extern void irq_set_default_host(struct irq_domain *host);
>
> -static inline struct irq_domain *irq_find_host(struct device_node *node)
> +static inline struct irq_domain *irq_find_host(void *domain_token)
>   {
> -	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
> +	return irq_find_matching_host(domain_token, DOMAIN_BUS_ANY);
>   }
>
>   /**
>    * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
> - * @of_node: pointer to interrupt controller's device tree node.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>    * @size: Number of interrupts in the domain.
>    * @ops: map/unmap domain callbacks
>    * @host_data: Controller private data pointer
>    */
> -static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_node,
> +static inline struct irq_domain *irq_domain_add_linear(void *domain_token,
>   					 unsigned int size,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data)
>   {
> -	return __irq_domain_add(of_node, size, size, 0, ops, host_data);
> +	return __irq_domain_add(domain_token, size, size, 0, ops, host_data);
>   }
> -static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
> +static inline struct irq_domain *irq_domain_add_nomap(void *domain_token,
>   					 unsigned int max_irq,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data)
>   {
> -	return __irq_domain_add(of_node, 0, max_irq, max_irq, ops, host_data);
> +	return __irq_domain_add(domain_token, 0, max_irq, max_irq, ops, host_data);
>   }
>   static inline struct irq_domain *irq_domain_add_legacy_isa(
> -				struct device_node *of_node,
> +				void *domain_token,
>   				const struct irq_domain_ops *ops,
>   				void *host_data)
>   {
> -	return irq_domain_add_legacy(of_node, NUM_ISA_INTERRUPTS, 0, 0, ops,
> +	return irq_domain_add_legacy(domain_token, NUM_ISA_INTERRUPTS, 0, 0, ops,
>   				     host_data);
>   }
> -static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
> +static inline struct irq_domain *irq_domain_add_tree(void *domain_token,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data)
>   {
> -	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
> +	return __irq_domain_add(domain_token, 0, ~0, 0, ops, host_data);
>   }
>
>   extern void irq_domain_remove(struct irq_domain *host);
> @@ -292,7 +293,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
>   #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>   extern struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
>   			unsigned int flags, unsigned int size,
> -			struct device_node *node,
> +			void *domain_token,
>   			const struct irq_domain_ops *ops, void *host_data);
>   extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>   				   unsigned int nr_irqs, int node, void *arg,
> @@ -347,6 +348,11 @@ static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
>   #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>
>   #else /* CONFIG_IRQ_DOMAIN */
> +static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
> +{
> +	return d->domain_token;
> +}
> +
>   static inline void irq_dispose_mapping(unsigned int virq) { }
>   static inline void irq_domain_activate_irq(struct irq_data *data) { }
>   static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 79baaf8..a00e0ce 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -6,6 +6,7 @@
>   #include <linux/irq.h>
>   #include <linux/irqdesc.h>
>   #include <linux/irqdomain.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/of.h>
> @@ -27,9 +28,24 @@ static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>   				  irq_hw_number_t hwirq, int node);
>   static void irq_domain_check_hierarchy(struct irq_domain *domain);
>
> +struct device_node *irq_domain_token_to_of_node(void *domain_token)
> +{
> +	/*
> +	 * Assume that anything represented by a valid kernel address
> +	 * is a device_node. Anything else must be a "small integer",
> +	 * and indirected by some other structure (an IDR, for
> +	 * example) if a pointer is required.
> +	 */
> +	if (virt_addr_valid(domain_token))
> +		return domain_token;
> +
> +	return NULL;
> +}
> +
>   /**
>    * __irq_domain_add() - Allocate a new irq_domain data structure
> - * @of_node: optional device-tree node of the interrupt controller
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>    * @size: Size of linear map; 0 for radix mapping only
>    * @hwirq_max: Maximum number of interrupts supported by controller
>    * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
> @@ -40,13 +56,15 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain);
>    * Allocates and initialize and irq_domain structure.
>    * Returns pointer to IRQ domain, or NULL on failure.
>    */
> -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
> +struct irq_domain *__irq_domain_add(void *domain_token, int size,
>   				    irq_hw_number_t hwirq_max, int direct_max,
>   				    const struct irq_domain_ops *ops,
>   				    void *host_data)
>   {
> +	struct device_node *of_node;
>   	struct irq_domain *domain;
>
> +	of_node = irq_domain_token_to_of_node(domain_token);
>   	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>   			      GFP_KERNEL, of_node_to_nid(of_node));

While we are here, do you think it makes sense to abstract 
of_node_to_nid as well? Then we would really remove device_node 
dependency for irqdomain.

Thanks,
Tomasz

>   	if (WARN_ON(!domain))
> @@ -56,7 +74,7 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
>   	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
>   	domain->ops = ops;
>   	domain->host_data = host_data;
> -	domain->of_node = of_node_get(of_node);
> +	domain->domain_token = of_node_get(of_node) ?: domain_token;
>   	domain->hwirq_max = hwirq_max;
>   	domain->revmap_size = size;
>   	domain->revmap_direct_max_irq = direct_max;
> @@ -102,14 +120,15 @@ void irq_domain_remove(struct irq_domain *domain)
>
>   	pr_debug("Removed domain %s\n", domain->name);
>
> -	of_node_put(domain->of_node);
> +	of_node_put(irq_domain_get_of_node(domain));
>   	kfree(domain);
>   }
>   EXPORT_SYMBOL_GPL(irq_domain_remove);
>
>   /**
>    * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs
> - * @of_node: pointer to interrupt controller's device tree node.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>    * @size: total number of irqs in mapping
>    * @first_irq: first number of irq block assigned to the domain,
>    *	pass zero to assign irqs on-the-fly. If first_irq is non-zero, then
> @@ -125,18 +144,20 @@ EXPORT_SYMBOL_GPL(irq_domain_remove);
>    * irqs get mapped dynamically on the fly. However, if the controller requires
>    * static virq assignments (non-DT boot) then it will set that up correctly.
>    */
> -struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_simple(void *domain_token,
>   					 unsigned int size,
>   					 unsigned int first_irq,
>   					 const struct irq_domain_ops *ops,
>   					 void *host_data)
>   {
> +	struct device_node *of_node;
>   	struct irq_domain *domain;
>
> -	domain = __irq_domain_add(of_node, size, size, 0, ops, host_data);
> +	domain = __irq_domain_add(domain_token, size, size, 0, ops, host_data);
>   	if (!domain)
>   		return NULL;
>
> +	of_node = irq_domain_token_to_of_node(domain_token);
>   	if (first_irq > 0) {
>   		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
>   			/* attempt to allocated irq_descs */
> @@ -155,7 +176,8 @@ EXPORT_SYMBOL_GPL(irq_domain_add_simple);
>
>   /**
>    * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
> - * @of_node: pointer to interrupt controller's device tree node.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>    * @size: total number of irqs in legacy mapping
>    * @first_irq: first number of irq block assigned to the domain
>    * @first_hwirq: first hwirq number to use for the translation. Should normally
> @@ -168,7 +190,7 @@ EXPORT_SYMBOL_GPL(irq_domain_add_simple);
>    * for all legacy interrupts except 0 (which is always the invalid irq for
>    * a legacy controller).
>    */
> -struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_legacy(void *domain_token,
>   					 unsigned int size,
>   					 unsigned int first_irq,
>   					 irq_hw_number_t first_hwirq,
> @@ -177,7 +199,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>   {
>   	struct irq_domain *domain;
>
> -	domain = __irq_domain_add(of_node, first_hwirq + size,
> +	domain = __irq_domain_add(domain_token, first_hwirq + size,
>   				  first_hwirq + size, 0, ops, host_data);
>   	if (domain)
>   		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
> @@ -188,10 +210,12 @@ EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
>
>   /**
>    * irq_find_matching_host() - Locates a domain for a given device node
> - * @node: device-tree node of the interrupt controller
> + * @domain_token: global identifier of the interrupt controller. If this
> + *                is a valid kernel pointer, it is assumed to be a
> + *                struct device_node pointer.
>    * @bus_token: domain-specific data
>    */
> -struct irq_domain *irq_find_matching_host(struct device_node *node,
> +struct irq_domain *irq_find_matching_host(void *domain_token,
>   					  enum irq_domain_bus_token bus_token)
>   {
>   	struct irq_domain *h, *found = NULL;
> @@ -208,12 +232,16 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
>   	 */
>   	mutex_lock(&irq_domain_mutex);
>   	list_for_each_entry(h, &irq_domain_list, link) {
> -		if (h->ops->match)
> +		if (h->ops->match) {
> +			struct device_node *node;
> +			node = irq_domain_get_of_node(h);
>   			rc = h->ops->match(h, node, bus_token);
> -		else
> -			rc = ((h->of_node != NULL) && (h->of_node == node) &&
> +		} else {
> +			rc = ((h->domain_token != NULL) &&
> +			      (h->domain_token == domain_token) &&
>   			      ((bus_token == DOMAIN_BUS_ANY) ||
>   			       (h->bus_token == bus_token)));
> +		}
>
>   		if (rc) {
>   			found = h;
> @@ -336,10 +364,12 @@ EXPORT_SYMBOL_GPL(irq_domain_associate);
>   void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
>   			       irq_hw_number_t hwirq_base, int count)
>   {
> +	struct device_node *of_node;
>   	int i;
>
> +	of_node = irq_domain_get_of_node(domain);
>   	pr_debug("%s(%s, irqbase=%i, hwbase=%i, count=%i)\n", __func__,
> -		of_node_full_name(domain->of_node), irq_base, (int)hwirq_base, count);
> +		of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
>
>   	for (i = 0; i < count; i++) {
>   		irq_domain_associate(domain, irq_base + i, hwirq_base + i);
> @@ -359,12 +389,14 @@ EXPORT_SYMBOL_GPL(irq_domain_associate_many);
>    */
>   unsigned int irq_create_direct_mapping(struct irq_domain *domain)
>   {
> +	struct device_node *of_node;
>   	unsigned int virq;
>
>   	if (domain == NULL)
>   		domain = irq_default_domain;
>
> -	virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +	of_node = irq_domain_get_of_node(domain);
> +	virq = irq_alloc_desc_from(1, of_node_to_nid(of_node));
>   	if (!virq) {
>   		pr_debug("create_direct virq allocation failed\n");
>   		return 0;
> @@ -399,6 +431,7 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
>   unsigned int irq_create_mapping(struct irq_domain *domain,
>   				irq_hw_number_t hwirq)
>   {
> +	struct device_node *of_node;
>   	int virq;
>
>   	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
> @@ -419,9 +452,11 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>   		return virq;
>   	}
>
> +	of_node = irq_domain_get_of_node(domain);
> +
>   	/* Allocate a virtual interrupt number */
>   	virq = irq_domain_alloc_descs(-1, 1, hwirq,
> -				      of_node_to_nid(domain->of_node));
> +				      of_node_to_nid(of_node));
>   	if (virq <= 0) {
>   		pr_debug("-> virq allocation failed\n");
>   		return 0;
> @@ -433,7 +468,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>   	}
>
>   	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
> -		hwirq, of_node_full_name(domain->of_node), virq);
> +		hwirq, of_node_full_name(of_node), virq);
>
>   	return virq;
>   }
> @@ -460,10 +495,12 @@ EXPORT_SYMBOL_GPL(irq_create_mapping);
>   int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
>   			       irq_hw_number_t hwirq_base, int count)
>   {
> +	struct device_node *of_node;
>   	int ret;
>
> +	of_node = irq_domain_get_of_node(domain);
>   	ret = irq_alloc_descs(irq_base, irq_base, count,
> -			      of_node_to_nid(domain->of_node));
> +			      of_node_to_nid(of_node));
>   	if (unlikely(ret < 0))
>   		return ret;
>
> @@ -590,14 +627,16 @@ static int virq_debug_show(struct seq_file *m, void *private)
>   		   "name", "mapped", "linear-max", "direct-max", "devtree-node");
>   	mutex_lock(&irq_domain_mutex);
>   	list_for_each_entry(domain, &irq_domain_list, link) {
> +		struct device_node *of_node;
>   		int count = 0;
> +		of_node = irq_domain_token_get_node(domain);
>   		radix_tree_for_each_slot(slot, &domain->revmap_tree, &iter, 0)
>   			count++;
>   		seq_printf(m, "%c%-16s  %6u  %10u  %10u  %s\n",
>   			   domain == irq_default_domain ? '*' : ' ', domain->name,
>   			   domain->revmap_size + count, domain->revmap_size,
>   			   domain->revmap_direct_max_irq,
> -			   domain->of_node ? of_node_full_name(domain->of_node) : "");
> +			   of_node ? of_node_full_name(of_node) : "");
>   	}
>   	mutex_unlock(&irq_domain_mutex);
>
> @@ -755,7 +794,7 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
>    * @parent:	Parent irq domain to associate with the new domain
>    * @flags:	Irq domain flags associated to the domain
>    * @size:	Size of the domain. See below
> - * @node:	Optional device-tree node of the interrupt controller
> + * @domain_token:	Optional global identifier of the interrupt controller
>    * @ops:	Pointer to the interrupt domain callbacks
>    * @host_data:	Controller private data pointer
>    *
> @@ -768,16 +807,16 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
>   struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
>   					    unsigned int flags,
>   					    unsigned int size,
> -					    struct device_node *node,
> +					    void *domain_token,
>   					    const struct irq_domain_ops *ops,
>   					    void *host_data)
>   {
>   	struct irq_domain *domain;
>
>   	if (size)
> -		domain = irq_domain_add_linear(node, size, ops, host_data);
> +		domain = irq_domain_add_linear(domain_token, size, ops, host_data);
>   	else
> -		domain = irq_domain_add_tree(node, ops, host_data);
> +		domain = irq_domain_add_tree(domain_token, ops, host_data);
>   	if (domain) {
>   		domain->parent = parent;
>   		domain->flags |= flags;
>
