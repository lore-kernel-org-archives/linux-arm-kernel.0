From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Mar 2014 01:49:01 +0000
Subject: [PATCH v2 4/7] dma: of: introduce of_dma_is_coherent() helper
In-Reply-To: <53109A64.9030701@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-5-git-send-email-santosh.shilimkar@ti.com>
 <10040083.PbPEQQPCjl@wuerfel> <53109A64.9030701@ti.com>
Message-ID: <20140303014901.GA18773@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 09:17:08AM -0500, Santosh Shilimkar wrote:
> On Friday 28 February 2014 04:39 AM, Arnd Bergmann wrote:
> > On Thursday 27 February 2014 16:17:49 Santosh Shilimkar wrote:
> >> +
> >> +/**
> >> + * of_dma_is_coherent - Check if device is coherent
> >> + * @np:        device node
> >> + *
> >> + * It returns true if "dma-coherent" property was found
> >> + * for this device in DT.
> >> + */
> >> +bool of_dma_is_coherent(struct device_node *np)
> >> +{
> >> +       struct device_node *node = np;
> >> +
> >> +       while (node) {
> >> +               if (of_property_read_bool(node, "dma-coherent")) {
> >> +                       of_node_put(node);
> >> +                       return true;
> >> +               }
> >> +               node = of_get_next_parent(node);
> >> +       }
> >> +       return false;
> >> +}
> >> +EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> >>
> > 
> > This won't work on architectures that are always coherent and
> > did not need 'dma-coherent' properties before, such as IBM
> > Power servers.
> > 
> > That said, I think the property makes sense, and we already have
> > platforms using it (highbank is the one I'm aware of).
> > 
> > We probably need ways to override this function in both ways:
> > "always coherent" (powerpc, x86), and "never coherent" (keystone
> > without LPAE) from platform code, and it would be nice to put
> > either option into DT in a global location as well. We may have
> > to go through a few iterations of this patch to get the best
> > algorithm, but I think the interface is good at least.
> 
> Probably we should discuss bit more next week at connect. The
> current 'dma-coherent' is a per device property. For arch's
> which are always coherent, the per device property doesn't make
> sense.
> 
> BTW, the current users of this API is only ARM32 bit port
> and if this satisfies the ARM platforms, we should get
> this in kernel and then address other cases on need
> basis.

I have a suspicion that we'll need this API on arm64 at some point as
well. I get regular questions about DMA cache maintenance for arm64 and
I carried a patch in my tree for a long time (now in -next). While full
coherency is nice, there are some devices on certain SoCs that are more
efficient (power, speed) when they don't have to snoop the CPU caches.

-- 
Catalin
