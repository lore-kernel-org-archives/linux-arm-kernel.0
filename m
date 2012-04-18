From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 12:54:23 +0200
Subject: [PATCH 1/1] dt: Add general DMA window parser
In-Reply-To: <20120418.133629.1664781135413277375.hdoyu@nvidia.com>
References: <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
 <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
 <20120418102629.GA14533@avionic-0098.mockup.avionic-design.de>
 <20120418.133629.1664781135413277375.hdoyu@nvidia.com>
Message-ID: <20120418105423.GA5667@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiroshi Doyu wrote:
> diff --git a/drivers/of/of_dma.c b/drivers/of/of_dma.c
> new file mode 100644
> index 0000000..45c9e88
> --- /dev/null
> +++ b/drivers/of/of_dma.c
> @@ -0,0 +1,35 @@
> +/*
> + * Stolen from:
> + *	"arch/microblaze/kernel/prom_parse.c"
> + *	"arch/powerpc/kernel/prom_parse.c"
> + */
> +
> +#include <linux/of_address.h>
> +
> +void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
> +		unsigned long *busno, unsigned long *phys, unsigned long *size)
> +{
> +	const __be32 *dma_window;
> +	u32 cells;
> +	const unsigned char *prop;

There's no need for this to be const unsigned char *, const void * will do
just as well.

> +
> +	dma_window = dma_window_prop;
> +
> +	/* busno is always one cell */
> +	if (busno)
> +		*busno = be32_to_cpup(dma_window++);
> +
> +	prop = of_get_property(dn, "#dma-address-cells", NULL);
> +	if (!prop)
> +		prop = of_get_property(dn, "#address-cells", NULL);
> +
> +	cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
> +	*phys = of_read_number(dma_window, cells);

This should probably fail gracefully if phys == NULL, similar to what you do
for busno.

> +
> +	dma_window += cells;
> +
> +	prop = of_get_property(dn, "#dma-size-cells", NULL);
> +	cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
> +	*size = of_read_number(dma_window, cells);

Same here.

> +}
> +

And you might want to add a EXPORT_SYMBOL(of_parse_dma_window) here so the
function can be used from modules.

Sorry for having you go through another round. I should have looked more
closely before.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/44c7e319/attachment-0001.sig>
