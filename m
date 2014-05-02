From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 May 2014 14:32:08 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502110557.GA18452@ulmo>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <20140502110557.GA18452@ulmo>
Message-ID: <4369315.NLgjZW6qVF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 13:05:58 Thierry Reding wrote:
> 
> Let me see if I understood the above proposal by trying to translate it
> into a simple example for a specific use-case. On Tegra for example we
> have various units that can either access system memory directly or use
> the IOMMU to translate accesses for them. One such unit would be the
> display controller that scans out a framebuffer from memory.

Can you explain how the decision is made whether the IOMMU gets used
or not? In all cases I've seen so far, I think we can hardwire this
in DT, and only expose one or the other. Are both ways used
concurrently?

>         dc at 0,54200000 {
>                 ...
> 
>                 slave {
>                         /*
>                          * 2 is the memory controller client ID of the
>                          * display controller.
>                          */
>                         iommu = <&iommu 2>;
> 
>                         ...
>                 };
>         };
> 
> Admittedly this is probably a lot more trivial than what you're looking
> for. There's no need for virtualization here, the IOMMU is simply used
> to isolate memory accesses by devices. Still it's a use-case that needs
> to be supported and one that at least Tegra and Exynos have an immediate
> need for.
> 
> So the above isn't much different from the proposed bindings, except
> that the iommu property is now nested within a slave node. I guess this
> gives us a lot more flexibility to extend the description of a slave as
> needed to represent more complex scenarios.

This looks rather complicated to parse automatically in the generic
DT code when we try to decide which dma_map_ops to use. We'd have
to look for 'slave' nodes in each device we instatiate and then see
if they use an iommu or not.
 
> Also, are slaves/slave-names and slave subnodes mutually exclusive? It
> sounds like slaves/slave-names would be a specialization of the slave
> subnode concept for the trivial cases. Would the following be an
> equivalent description of the above example?
> 
>         dc at 0,54200000 {
>                 ...
> 
>                 slaves = <&iommu 2>;
>         };
> 
> I don't see how it could be exactly equivalent since it misses context
> regarding the type of slave that's being interacted with. Perhaps that
> could be solved by making that knowledge driver-specific (i.e. the
> driver for the Tegra display controller will know that it can only be
> the master on an IOMMU and therefore derive the slave type). Or the
> slave's type could be derived from the slave-names property.

I'd rather have a device-specific property that tells the driver
about things the iommu driver doesn't need to know but the master
does. In most cases, we should be fine without a name attached to the
slave.

	Arnd
