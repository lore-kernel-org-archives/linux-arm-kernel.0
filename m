From: Robert.Richter@cavium.com (Richter, Robert)
Date: Thu, 8 Nov 2018 15:05:16 +0000
Subject: [PATCH 01/10] irqdomain: Add interface to request an irq domain
In-Reply-To: <e640a85d-6e2c-835b-d104-ef42eada8fde@arm.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-2-rrichter@cavium.com>
 <e640a85d-6e2c-835b-d104-ef42eada8fde@arm.com>
Message-ID: <20181108150355.GA4064@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julien,

thanks for your review. See my comments below.

On 08.11.18 10:19:52, Julien Thierry wrote:
> On 07/11/18 22:03, Robert Richter wrote:
> >This patch introduces a new interface to allow irq domain
> >initialization regardless of order dependencies. This is done by
> >requesting a domain and registering a callback function that is called
> >as soon as a domain becomes available.
> >
> >A typical irq domain initialization code is the following:
> >
> >Parent initialization:
> >
> >      ...
> >      domain = msi_create_irq_domain(fwnode, info, parent);
> >      if (domain)
> >              irq_domain_update_bus_token(domain, bus_token);
> >      ...
> >
> >Child initialization:
> >
> >      ...
> >      parent = irq_find_matching_fwnode(fwnode, bus_token);
> >      if (!parent)
> >              ...
> >      create_irq_domain(parent, ...);
> 
> What is that function?

This functions is just an example, all others are part of the api.  I
will rename it for more clarity, e.g. do_some_irq_domain_setup().

> 
> >      ...
> >
> >In case the parent is not yet available, the child initialization
> >fails. Thus, the current implementation requires the parent domain
> >being initialized before the child domain. With a complex irq domain
> >hierarchy it becomes more and more difficult to grant that order as
> >irq domains are enabled in separate subsystems. Care must be taken
> >when initializing parent and child domains in the same initcall
> >level. E.g. Arm's gic-v3-its implementation might have the following
> >tree and dependencies:
> >
> >      gic-v3
> >      ??? its-node-0
> >      ?   ??? pci-host-0
> >      ?   ??? platform-bus
> >      ?   ...
> >      ??? its-node-1
> >      ?   ??? pci-host-1
> >      ...
> >
> >All domains must be initialized in top-down order of the tree.
> >
> >This patch introduces an interface that allows domain initialization
> >without any order requirements, e.g. to be able to initialize the irq
> >domains in the same initcall level. The following functions have been
> >introduced to allow the registration of a callback handler:
> >
> >      irq_domain_request_fwnode()
> >      irq_domain_request_host()
> >
> >Instead of using the irq_find_matching_fwnode() function and it's
> >variants the child code replaces them with the new functions and
> >looks e.g. like the following:
> >
> >      ...
> >      irq_domain_request_fwnode(fwnode, bus_token,
> >                              create_irq_domain, name, priv);
> >      ...
> >
> >Here, the callback function create_irq_domain() is called as soon as
> >the parent becomes available. All registered handlers are stored in a
> >list. With each update of the bus token using irq_domain_update_bus_
> >token(), the list is checked if that domain is requested by a handler
> >and if that is the case it's callback function is called and the
> >request removed from the list.
> >
> >With a late_initcall all requests from the list should already have
> >been handled, otherwise all remaining requests are removed with an
> >error reported.
> >
> >Signed-off-by: Robert Richter <rrichter@cavium.com>
> >---
> >  include/linux/irqdomain.h |  15 +++++
> >  kernel/irq/irqdomain.c    | 158 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 173 insertions(+)
> >
> >diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> >index 068aa46f0d55..27e83803627d 100644
> >--- a/include/linux/irqdomain.h
> >+++ b/include/linux/irqdomain.h
> >@@ -311,6 +311,21 @@ static inline struct irq_domain *irq_find_host(struct device_node *node)
> >      return d;
> >  }
> >
> >+typedef int (*irq_domain_callback_t)(struct irq_domain *, void *);
> >+int irq_domain_request_fwnode(struct fwnode_handle *fwnode,
> >+                     enum irq_domain_bus_token bus_token,
> >+                     irq_domain_callback_t callback,
> >+                     const char *name, void *priv);
> >+
> >+static inline int irq_domain_request_host(struct device_node *node,
> >+                                     enum irq_domain_bus_token bus_token,
> >+                                     irq_domain_callback_t callback,
> >+                                     void *priv)
> >+{
> >+     return irq_domain_request_fwnode(of_node_to_fwnode(node), bus_token,
> >+                                     callback, node->full_name, priv);
> >+}
> >+
> 
> A little documentation here? Why do we need both irq_domain_request_host
> and irq_domain_request_fwnode?

irq_domain_request_fwnode() is documented in kernel/irq/irqdomain.c.
Functions are equivalent to it's irq_find_matching_*() counterparts.
*_host() is for devicetree only nodes.

> 
> Also, you introduced this for domain creation, but the callback here is
> very generic. Is it intended to allow any kind of action once a fwnode
> is available?

Yes, it is generic, see patch #5 where it is used for late device
probing. Domain creation is the main use case to setup the irq domain
hierarchy. It can be used as a replacement for irq_find_matching_*().
Any users of that functions are suitable for being used with the new
interface.

> 
> >  /**
> >   * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
> >   * @of_node: pointer to interrupt controller's device tree node.
> >diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> >index 3366d11c3e02..9e33d873d8f6 100644
> >--- a/kernel/irq/irqdomain.c
> >+++ b/kernel/irq/irqdomain.c
> >@@ -21,6 +21,7 @@
> >  #include <linux/fs.h>
> >
> >  static LIST_HEAD(irq_domain_list);
> >+static LIST_HEAD(irq_domain_requests);
> >  static DEFINE_MUTEX(irq_domain_mutex);
> >
> >  static struct irq_domain *irq_default_domain;
> >@@ -45,6 +46,106 @@ static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
> >  const struct fwnode_operations irqchip_fwnode_ops;
> >  EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
> >
> >+struct irq_domain_request {
> >+     struct list_head                list;
> >+     struct fwnode_handle            *fwnode;
> >+     enum irq_domain_bus_token       bus_token;
> >+     irq_domain_callback_t           callback;
> >+     char                            *name;
> >+     void                            *priv;
> >+};
> >+
> >+static void irq_domain_call_handler(struct irq_domain *domain,
> >+             irq_domain_callback_t callback, const char *name, void *priv)
> >+{
> >+     int ret;
> >+
> >+     ret = callback(domain, priv);
> >+     if (ret)
> >+             pr_err("%s: Domain request handler failed: %d\n",
> >+                     name, ret);
> >+
> >+     of_node_put(irq_domain_get_of_node(domain));
> >+}
> >+
> >+static void irq_domain_free_request(struct irq_domain_request *request)
> >+{
> >+     kfree(request->name);
> >+     kfree(request);
> >+}
> >+
> >+static void irq_domain_handle_requests(struct fwnode_handle *fwnode,
> >+                        enum irq_domain_bus_token bus_token)
> >+{
> >+     struct irq_domain *domain;
> >+     struct irq_domain_request *request;
> >+
> >+     if (!fwnode)
> >+             return;
> >+redo:
> >+     domain = irq_find_matching_fwnode(fwnode, bus_token);
> >+     if (!domain)
> >+             return;
> >+
> >+     mutex_lock(&irq_domain_mutex);
> >+
> 
> Why do we need to take the mutex before checking the domain fields?
> Can't we delay it?

The list is protected by the mutex. irq_find_matching_fwnode() also
accesses the list and must use the same mutex.

> 
> >+     if ((domain->fwnode != fwnode) && (domain->bus_token != bus_token)) {
> 
> Why do we even need that check?

The domain token might have changed after irq_find_matching_fwnode()
and before mutex_lock(), we do a recheck here. Some sort of try-lock.

Note: I found the check being wrong here, it needs to be corrected to:

	if ((domain->fwnode != fwnode) || (domain->bus_token != bus_token)) {

> 
> Isn't the point of passing fwnode and bus_token to
> irq_find_matching_fwnode to find a domain with those properties?

Yes, but properties may change and also the list itself.

> 
> >+             mutex_unlock(&irq_domain_mutex);
> >+             goto redo;
> >+     }
> >+
> >+     list_for_each_entry(request, &irq_domain_requests, list) {
> 
> Shouldn't you use list_for_each_safe if you want to remove elements of
> the list inside the loop?

No, we do a complete redo again without further iterating the list. We
need to do this since the handler must be called with the mutex
unlocked (to be able to manipulate the irq domain list in the callback
and to be in non-atomic context). After we unlocked the mutex, we must
restart again as the list may have changed.

> 
> >+             if (request->fwnode != fwnode ||
> >+                 request->bus_token != bus_token)
> >+                     continue;
> >+
> >+             list_del(&request->list);
> >+             mutex_unlock(&irq_domain_mutex);
> >+
> >+             irq_domain_call_handler(domain, request->callback,
> >+                                     request->name, request->priv);
> >+             irq_domain_free_request(request);
> >+
> >+             goto redo;
> >+     }
> >+
> >+     mutex_unlock(&irq_domain_mutex);
> >+}
> >+
> >+static int __init irq_domain_drain_requests(void)
> >+{
> >+     struct irq_domain_request *request;
> >+     struct irq_domain *domain;
> >+     int ret = 0;
> >+redo:
> >+     mutex_lock(&irq_domain_mutex);
> >+
> >+     list_for_each_entry(request, &irq_domain_requests, list) {
> 
> Same remark.

Same here, the difference is that we can directly operate with the
request, no need to check the domain.

> 
> >+             list_del(&request->list);
> >+             mutex_unlock(&irq_domain_mutex);
> >+
> >+             domain = irq_find_matching_fwnode(request->fwnode,
> >+                                             request->bus_token);
> >+             if (domain) {
> >+                     irq_domain_call_handler(domain, request->callback,
> >+                                             request->name, request->priv);
> >+             } else {
> >+                     ret = -ENODEV;
> >+                     pr_err("%s-%d: Unhandled domain request\n",
> >+                             request->name, request->bus_token);
> >+             }
> >+
> >+             irq_domain_free_request(request);
> >+
> >+             goto redo;
> 
> Hmmm, are you starting a loop to break out of it at each iteration?

We have to as the list lock was released which is needed for
irq_find_matching_fwnode() and the callback handler.

> 
> Wouldn't it be much simpler to have something like the following?
> 
>        while (!list_empty(&irq_domain_requests) {
>                mutex_lock(&irq_domain_mutex);
>                request = list_first_entry_or_null(&irq_domain_requests,
>                                        struct irq_domain_request,
>                                        list);
>                if (request)
>                        list_del(&request->list);
>                mutex_unlock(&irq_domain_mutex);

At this point my implmentation has only 5 lines of code and uses one
list command less than your's. I am also not happy using list_empty()
without the lock hold (though it seems to be used that way elsewhere).

> 
>                <...>
>        }
> 
> If you really need to consider possible additions to the list while
> draining it.
> 
> Otherwise, just consider doing:

I let the callback handler run again which might change the list again
(e.g. by adding new handlers). Just using list_for_each_entry() looks
straight forward to me.

> 
>        mutex_lock(&irq_domain_mutex);
>        while (!list_empty(&irq_domain_requests)) {
>                request = list_first_entry(&irq_domain_requests,
>                                        struct irq_domain_request,
>                                        list);
>                list_del(&request->list);
>        }
>        mutex_unlock(&irq_domain_mutex);
> 
> >+     }
> >+
> >+     mutex_unlock(&irq_domain_mutex);
> >+
> >+     return ret;
> >+}
> >+late_initcall(irq_domain_drain_requests);
> 
> Overall the code for irq_domain_drain_requests and
> irq_domain_handle_requests feels very similar.
> 
> The only difference is that one filters the elements it processes based
> on an irq_domain while the other just goes through all of them.
> 
> You can probably factor that code.

Both functions serve different purposes and factoring the small set of
similarity out just adds more complexity.

Thanks,

-Robert

> 
> Cheers,
> 
> >+
> >  /**
> >   * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
> >   *                           identifying an irq domain
> >@@ -293,6 +394,8 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
> >      debugfs_add_domain_dir(domain);
> >
> >      mutex_unlock(&irq_domain_mutex);
> >+
> >+     irq_domain_handle_requests(domain->fwnode, bus_token);
> >  }
> >
> >  /**
> >@@ -417,6 +520,61 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
> >  EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
> >
> >  /**
> >+ * irq_domain_request_fwnode() - Requests a domain for a given fwspec
> >+ * @fwspec: FW specifier for an interrupt
> >+ * @bus_token: domain-specific data
> >+ * @callback: function to be called once domain becomes available
> >+ * @name: name to be used for fwnode
> >+ * @priv: private data to be passed to callback
> >+ *
> >+ * The callback function is called as soon as the domain is available.
> >+ */
> >+int irq_domain_request_fwnode(struct fwnode_handle *fwnode,
> >+                     enum irq_domain_bus_token bus_token,
> >+                     irq_domain_callback_t callback,
> >+                     const char *name, void *priv)
> >+{
> >+     struct irq_domain *parent;
> >+     struct irq_domain_request *request;
> >+
> >+     if (!fwnode || bus_token == DOMAIN_BUS_ANY || !callback || !name)
> >+             return -EINVAL;
> >+
> >+     parent = irq_find_matching_fwnode(fwnode, bus_token);
> >+     if (parent) {
> >+             irq_domain_call_handler(parent, callback, name, priv);
> >+             return 0;
> >+     }
> >+
> >+     request = kzalloc(sizeof(*request), GFP_KERNEL);
> >+     if (!request)
> >+             return -ENOMEM;
> >+
> >+     request->fwnode = fwnode;
> >+     request->bus_token = bus_token;
> >+     request->callback = callback;
> >+     request->name = kstrdup(name, GFP_KERNEL);
> >+     request->priv = priv;
> >+     INIT_LIST_HEAD(&request->list);
> >+
> >+     if (!request->name) {
> >+             kfree(request);
> >+             return -ENOMEM;
> >+     }
> >+
> >+     of_node_get(to_of_node(fwnode));
> >+
> >+     mutex_lock(&irq_domain_mutex);
> >+     list_add_tail(&request->list, &irq_domain_requests);
> >+     mutex_unlock(&irq_domain_mutex);
> >+
> >+     /* recheck in case list changed */
> >+     irq_domain_handle_requests(fwnode, bus_token);
> >+
> >+     return 0;
> >+}
> >+
> >+/**
> >   * irq_domain_check_msi_remap - Check whether all MSI irq domains implement
> >   * IRQ remapping
> >   *
> >
> 
> --
> Julien Thierry
