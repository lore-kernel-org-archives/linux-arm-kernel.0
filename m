From: josh@joshtriplett.org (Josh Triplett)
Date: Tue, 26 Nov 2013 18:35:27 -0800
Subject: PCI: mvebu: return NULL instead of ERR_PTR(ret)
In-Reply-To: <1385519196.18487.25.camel@joe-AO722>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
 <20131126180930.GC19852@obsidianresearch.com>
 <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
 <1385519196.18487.25.camel@joe-AO722>
Message-ID: <20131127023526.GA14732@leaf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 06:26:36PM -0800, Joe Perches wrote:
> On Wed, 2013-11-27 at 10:59 +0900, Jingoo Han wrote:
> []
> > ./drivers/pci/host/pci-mvebu.c
> > static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > 		struct device_node *np, struct mvebu_pcie_port *port)
> > {
> > 	.....
> > 
> > 	ret = of_address_to_resource(np, 0, &regs);
> > 	if (ret)
> > -		return ERR_PTR(ret);
> > +		return (void __iomem *)ERR_PTR(ret);
> > 
> > However, other engineers said that "(void __iomem *)ERR_PTR(ret)"
> > is not a general pattern. I cannot find the proper method to resolve
> > this sparse warning.
> > 
> > In this case, how can I resolve this sparse warning?
> 
> I think there's no problem using the cast.  It's not a
> pattern because it's not been required before as function
> returns have not previously been declared __iomem.
> 
> Or, perhaps the arm|hexagon specific #define below could
> be made generic so it could be used.
> 
> arch/arm/include/asm/io.h:#define IOMEM(x)	((void __force __iomem *)(x))
> 
> 	return IOMEM(ERR_PTR(ret));
> 
> There aren't any current uses of return IOMEM(foo) either
> though so the direct cast is probably more appropriate.

I don't think that #define is appropriate for any non-constant value;
almost any instance of that __force cast applied to a variable would be
better written by fixing types more appropriately.  I'd suggest
updating that #define for both architectures to use BUILD_BUG_ON to
assert __builtin_constant_p on its argument.

- Josh Triplett
