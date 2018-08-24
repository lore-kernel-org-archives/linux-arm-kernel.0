From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 17:08:48 +0200
Subject: [PATCH v2 01/29] nvmem: add support for cell lookups
In-Reply-To: <20180810080526.27207-2-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl>
Message-ID: <20180824170848.29594318@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Fri, 10 Aug 2018 10:04:58 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> +struct nvmem_cell_lookup {
> +	struct nvmem_cell_info	info;
> +	struct list_head	list;
> +	const char		*nvmem_name;
> +};

Hm, maybe I don't get it right, but this looks suspicious. Usually the
consumer lookup table is here to attach device specific names to
external resources.

So what I'd expect here is:

struct nvmem_cell_lookup {
	/* The nvmem device name. */
	const char *nvmem_name;

	/* The nvmem cell name */
	const char *nvmem_cell_name;

	/*
	 * The local resource name. Basically what you have in the
	 * nvmem-cell-names prop.
	 */
	const char *conid;
};

struct nvmem_cell_lookup_table {
	struct list_head list;

	/* ID of the consumer device. */
	const char *devid;

	/* Array of cell lookup entries. */
	unsigned int ncells;
	const struct nvmem_cell_lookup *cells;
};

Looks like your nvmem_cell_lookup is more something used to attach cells
to an nvmem device, which is NVMEM provider's responsibility not the
consumer one.

Regards,

Boris
