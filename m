From: joe@perches.com (Joe Perches)
Date: Tue, 26 Nov 2013 18:26:36 -0800
Subject: PCI: mvebu: return NULL instead of ERR_PTR(ret)
In-Reply-To: <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
 <20131126180930.GC19852@obsidianresearch.com>
 <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
Message-ID: <1385519196.18487.25.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-27 at 10:59 +0900, Jingoo Han wrote:
[]
> ./drivers/pci/host/pci-mvebu.c
> static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> 		struct device_node *np, struct mvebu_pcie_port *port)
> {
> 	.....
> 
> 	ret = of_address_to_resource(np, 0, &regs);
> 	if (ret)
> -		return ERR_PTR(ret);
> +		return (void __iomem *)ERR_PTR(ret);
> 
> However, other engineers said that "(void __iomem *)ERR_PTR(ret)"
> is not a general pattern. I cannot find the proper method to resolve
> this sparse warning.
> 
> In this case, how can I resolve this sparse warning?

I think there's no problem using the cast.  It's not a
pattern because it's not been required before as function
returns have not previously been declared __iomem.

Or, perhaps the arm|hexagon specific #define below could
be made generic so it could be used.

arch/arm/include/asm/io.h:#define IOMEM(x)	((void __force __iomem *)(x))

	return IOMEM(ERR_PTR(ret));

There aren't any current uses of return IOMEM(foo) either
though so the direct cast is probably more appropriate.
