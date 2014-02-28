From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 10:39:09 +0100
Subject: [PATCH v2 4/7] dma: of: introduce of_dma_is_coherent() helper
In-Reply-To: <1393535872-20915-5-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <10040083.PbPEQQPCjl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 16:17:49 Santosh Shilimkar wrote:
> +
> +/**
> + * of_dma_is_coherent - Check if device is coherent
> + * @np:        device node
> + *
> + * It returns true if "dma-coherent" property was found
> + * for this device in DT.
> + */
> +bool of_dma_is_coherent(struct device_node *np)
> +{
> +       struct device_node *node = np;
> +
> +       while (node) {
> +               if (of_property_read_bool(node, "dma-coherent")) {
> +                       of_node_put(node);
> +                       return true;
> +               }
> +               node = of_get_next_parent(node);
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> 

This won't work on architectures that are always coherent and
did not need 'dma-coherent' properties before, such as IBM
Power servers.

That said, I think the property makes sense, and we already have
platforms using it (highbank is the one I'm aware of).

We probably need ways to override this function in both ways:
"always coherent" (powerpc, x86), and "never coherent" (keystone
without LPAE) from platform code, and it would be nice to put
either option into DT in a global location as well. We may have
to go through a few iterations of this patch to get the best
algorithm, but I think the interface is good at least.

	Arnd
