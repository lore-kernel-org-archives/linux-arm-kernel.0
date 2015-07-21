From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Jul 2015 18:56:23 +0100
Subject: [PATCH 2/5] genirq: irqdomain: Remove irqdomain dependency on
 struct device_node
In-Reply-To: <1437473280-11431-3-git-send-email-marc.zyngier@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150721175623.GA32187@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 11:07:57AM +0100, Marc Zyngier wrote:
> struct device_node is very much DT specific, and the original authors
> of the irqdomain subsystem recognized that tie, and went as far as
> mentionning that this could be replaced by some "void *token",
> should another firmware infrastructure be using it.

Yes, that's similar to the problem Rafael solved with fwnode_handle,
I do not know if we can extend the fwnode_handle to manage these
generic tokens too, but the approach you have taken seem the right
one to me (and you are doing this for components that are not really
attached to struct device so I am not sure the fwnode_handle approach
can be shoehorned to solve it).

[...]

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 995d217..27f4ec7 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -6,6 +6,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -27,9 +28,24 @@ static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>                                   irq_hw_number_t hwirq, int node);
>  static void irq_domain_check_hierarchy(struct irq_domain *domain);
> 
> +struct device_node *irq_domain_token_to_of_node(void *domain_token)
> +{
> +       /*
> +        * Assume that anything represented by a valid kernel address
> +        * is a device_node. Anything else must be a "small integer",
> +        * and indirected by some other structure (an IDR, for
> +        * example) if a pointer is required.
> +        */

Or we can convert the opaque token to a struct like fwnode_handle (or
even augment it for this purpose but in the ACPI irqdomain lookup
context it is not necessarily well defined - ie you are doing it for
components (GIC) that are not really attached to struct device).

The rest of the patch is a conversion of the existing code to the opaque
token approach, so once we agreed on the token format we agreed on
the patch, I am fine as it is (we might need an IDR though for other
use cases not covered by this set).

Thanks for putting it together.

Lorenzo

> +       if (virt_addr_valid(domain_token))
> +               return domain_token;
> +
> +       return NULL;
> +}
> +
>  /**
>   * __irq_domain_add() - Allocate a new irq_domain data structure
> - * @of_node: optional device-tree node of the interrupt controller
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>   * @size: Size of linear map; 0 for radix mapping only
>   * @hwirq_max: Maximum number of interrupts supported by controller
>   * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
> @@ -40,13 +56,15 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain);
>   * Allocates and initialize and irq_domain structure.
>   * Returns pointer to IRQ domain, or NULL on failure.
>   */
> -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
> +struct irq_domain *__irq_domain_add(void *domain_token, int size,
>                                     irq_hw_number_t hwirq_max, int direct_max,
>                                     const struct irq_domain_ops *ops,
>                                     void *host_data)
>  {
> +       struct device_node *of_node;
>         struct irq_domain *domain;
> 
> +       of_node = irq_domain_token_to_of_node(domain_token);
>         domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>                               GFP_KERNEL, of_node_to_nid(of_node));
>         if (WARN_ON(!domain))
> @@ -56,7 +74,7 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
>         INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
>         domain->ops = ops;
>         domain->host_data = host_data;
> -       domain->of_node = of_node_get(of_node);
> +       domain->domain_token = of_node_get(of_node) ?: domain_token;
>         domain->hwirq_max = hwirq_max;
>         domain->revmap_size = size;
>         domain->revmap_direct_max_irq = direct_max;
> @@ -102,14 +120,15 @@ void irq_domain_remove(struct irq_domain *domain)
> 
>         pr_debug("Removed domain %s\n", domain->name);
> 
> -       of_node_put(domain->of_node);
> +       of_node_put(irq_domain_get_of_node(domain));
>         kfree(domain);
>  }
>  EXPORT_SYMBOL_GPL(irq_domain_remove);
> 
>  /**
>   * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs
> - * @of_node: pointer to interrupt controller's device tree node.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>   * @size: total number of irqs in mapping
>   * @first_irq: first number of irq block assigned to the domain,
>   *     pass zero to assign irqs on-the-fly. If first_irq is non-zero, then
> @@ -125,18 +144,20 @@ EXPORT_SYMBOL_GPL(irq_domain_remove);
>   * irqs get mapped dynamically on the fly. However, if the controller requires
>   * static virq assignments (non-DT boot) then it will set that up correctly.
>   */
> -struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_simple(void *domain_token,
>                                          unsigned int size,
>                                          unsigned int first_irq,
>                                          const struct irq_domain_ops *ops,
>                                          void *host_data)
>  {
> +       struct device_node *of_node;
>         struct irq_domain *domain;
> 
> -       domain = __irq_domain_add(of_node, size, size, 0, ops, host_data);
> +       domain = __irq_domain_add(domain_token, size, size, 0, ops, host_data);
>         if (!domain)
>                 return NULL;
> 
> +       of_node = irq_domain_token_to_of_node(domain_token);
>         if (first_irq > 0) {
>                 if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
>                         /* attempt to allocated irq_descs */
> @@ -155,7 +176,8 @@ EXPORT_SYMBOL_GPL(irq_domain_add_simple);
> 
>  /**
>   * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
> - * @of_node: pointer to interrupt controller's device tree node.
> + * @domain_token: optional firmware-specific identifier for
> + *                the interrupt controller
>   * @size: total number of irqs in legacy mapping
>   * @first_irq: first number of irq block assigned to the domain
>   * @first_hwirq: first hwirq number to use for the translation. Should normally
> @@ -168,7 +190,7 @@ EXPORT_SYMBOL_GPL(irq_domain_add_simple);
>   * for all legacy interrupts except 0 (which is always the invalid irq for
>   * a legacy controller).
>   */
> -struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
> +struct irq_domain *irq_domain_add_legacy(void *domain_token,
>                                          unsigned int size,
>                                          unsigned int first_irq,
>                                          irq_hw_number_t first_hwirq,
> @@ -177,7 +199,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>  {
>         struct irq_domain *domain;
> 
> -       domain = __irq_domain_add(of_node, first_hwirq + size,
> +       domain = __irq_domain_add(domain_token, first_hwirq + size,
>                                   first_hwirq + size, 0, ops, host_data);
>         if (domain)
>                 irq_domain_associate_many(domain, first_irq, first_hwirq, size);
> @@ -191,7 +213,7 @@ EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
>   * @node: device-tree node of the interrupt controller
>   * @data: domain-specific data
>   */
> -struct irq_domain *irq_find_matching_host(struct device_node *node,
> +struct irq_domain *irq_find_matching_host(void *domain_token,
>                                           enum irq_domain_bus_token bus_token)
>  {
>         struct irq_domain *h, *found = NULL;
> @@ -208,12 +230,16 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
>          */
>         mutex_lock(&irq_domain_mutex);
>         list_for_each_entry(h, &irq_domain_list, link) {
> -               if (h->ops->match)
> +               if (h->ops->match) {
> +                       struct device_node *node;
> +                       node = irq_domain_get_of_node(h);
>                         rc = h->ops->match(h, node, bus_token);
> -               else
> -                       rc = ((h->of_node != NULL) && (h->of_node == node) &&
> +               } else {
> +                       rc = ((h->domain_token != NULL) &&
> +                             (h->domain_token == domain_token) &&
>                               ((bus_token == DOMAIN_BUS_ANY) ||
>                                (h->bus_token == bus_token)));
> +               }
> 
>                 if (rc) {
>                         found = h;
> @@ -336,10 +362,12 @@ EXPORT_SYMBOL_GPL(irq_domain_associate);
>  void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
>                                irq_hw_number_t hwirq_base, int count)
>  {
> +       struct device_node *of_node;
>         int i;
> 
> +       of_node = irq_domain_get_of_node(domain);
>         pr_debug("%s(%s, irqbase=%i, hwbase=%i, count=%i)\n", __func__,
> -               of_node_full_name(domain->of_node), irq_base, (int)hwirq_base, count);
> +               of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
> 
>         for (i = 0; i < count; i++) {
>                 irq_domain_associate(domain, irq_base + i, hwirq_base + i);
> @@ -359,12 +387,14 @@ EXPORT_SYMBOL_GPL(irq_domain_associate_many);
>   */
>  unsigned int irq_create_direct_mapping(struct irq_domain *domain)
>  {
> +       struct device_node *of_node;
>         unsigned int virq;
> 
>         if (domain == NULL)
>                 domain = irq_default_domain;
> 
> -       virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +       of_node = irq_domain_get_of_node(domain);
> +       virq = irq_alloc_desc_from(1, of_node_to_nid(of_node));
>         if (!virq) {
>                 pr_debug("create_direct virq allocation failed\n");
>                 return 0;
> @@ -399,6 +429,7 @@ EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
>  unsigned int irq_create_mapping(struct irq_domain *domain,
>                                 irq_hw_number_t hwirq)
>  {
> +       struct device_node *of_node;
>         int virq;
> 
>         pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
> @@ -419,9 +450,11 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>                 return virq;
>         }
> 
> +       of_node = irq_domain_get_of_node(domain);
> +
>         /* Allocate a virtual interrupt number */
>         virq = irq_domain_alloc_descs(-1, 1, hwirq,
> -                                     of_node_to_nid(domain->of_node));
> +                                     of_node_to_nid(of_node));
>         if (virq <= 0) {
>                 pr_debug("-> virq allocation failed\n");
>                 return 0;
> @@ -433,7 +466,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>         }
> 
>         pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
> -               hwirq, of_node_full_name(domain->of_node), virq);
> +               hwirq, of_node_full_name(of_node), virq);
> 
>         return virq;
>  }
> @@ -460,10 +493,12 @@ EXPORT_SYMBOL_GPL(irq_create_mapping);
>  int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
>                                irq_hw_number_t hwirq_base, int count)
>  {
> +       struct device_node *of_node;
>         int ret;
> 
> +       of_node = irq_domain_get_of_node(domain);
>         ret = irq_alloc_descs(irq_base, irq_base, count,
> -                             of_node_to_nid(domain->of_node));
> +                             of_node_to_nid(of_node));
>         if (unlikely(ret < 0))
>                 return ret;
> 
> @@ -590,14 +625,16 @@ static int virq_debug_show(struct seq_file *m, void *private)
>                    "name", "mapped", "linear-max", "direct-max", "devtree-node");
>         mutex_lock(&irq_domain_mutex);
>         list_for_each_entry(domain, &irq_domain_list, link) {
> +               struct device_node *of_node;
>                 int count = 0;
> +               of_node = irq_domain_token_get_node(domain);
>                 radix_tree_for_each_slot(slot, &domain->revmap_tree, &iter, 0)
>                         count++;
>                 seq_printf(m, "%c%-16s  %6u  %10u  %10u  %s\n",
>                            domain == irq_default_domain ? '*' : ' ', domain->name,
>                            domain->revmap_size + count, domain->revmap_size,
>                            domain->revmap_direct_max_irq,
> -                          domain->of_node ? of_node_full_name(domain->of_node) : "");
> +                          of_node ? of_node_full_name(of_node) : "");
>         }
>         mutex_unlock(&irq_domain_mutex);
> 
> --
> 2.1.4
> 
