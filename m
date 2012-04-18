From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 11:26:13 +0200
Subject: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
In-Reply-To: <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
References: <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
 <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
 <201204180731.54064.arnd@arndb.de>
 <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
Message-ID: <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiroshi Doyu wrote:
> diff --git a/drivers/of/of_dma.c b/drivers/of/of_dma.c
> new file mode 100644
> index 0000000..1db1ccd
> --- /dev/null
> +++ b/drivers/of/of_dma.c
> @@ -0,0 +1,35 @@
> +/*
> + * Stealed from:

"Stolen from"

> + *	"arch/microblaze/kernel/prom_parse.c"
> + *	"arch/powerpc/kernel/prom_parse.c"
> + */
> +
> +#include <linux/of_address.h>
> +
> +void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
> +		unsigned long *busno, unsigned long *phys, unsigned long *size)
> +{
> +	const u32 *dma_window;

Should be __be32.

> +	u32 cells;
> +	const unsigned char *prop;
> +
> +	dma_window = dma_window_prop;
> +
> +	/* busno is always one cell */
> +	if (busno)
> +		*busno = *(dma_window++);

This needs endianness conversion:

	*busno = be32_to_cpup(dma_window++);

> +
> +	prop = of_get_property(dn, "#dma-address-cells", NULL);
> +	if (!prop)
> +		prop = of_get_property(dn, "#address-cells", NULL);
> +
> +	cells = prop ? *(u32 *)prop : of_n_addr_cells(dn);

Same here.

> +	*phys = of_read_number(dma_window, cells);
> +
> +	dma_window += cells;
> +
> +	prop = of_get_property(dn, "#dma-size-cells", NULL);
> +	cells = prop ? *(u32 *)prop : of_n_size_cells(dn);

And here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/e02078d4/attachment.sig>
