From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Wed, 24 Apr 2013 12:30:49 +0200
Subject: [Linaro-mm-sig] [RFC/PATCH v2 2/2] drivers: dma-contiguous: add
 initialization from device tree
In-Reply-To: <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
References: <1365679330-2514-1-git-send-email-m.szyprowski@samsung.com>
 <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5177B459.1080009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 01:22 PM, Marek Szyprowski wrote:
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 01fe743..6a8abab 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
[...]
> +void scan_cma_nodes(void)

Should be declared static.

> +{
> +	struct device_node *parent = of_find_node_by_path("/chosen/contiguous-memory");
> +	struct device_node *child;
> +
> +	if (!parent)
> +		return;
> +
> +	for_each_child_of_node(parent, child) {
> +		struct cma *cma = NULL;
> +		int i;
> +
> +		for (i=0; i<cma_area_count; i++)
> +			if (strstr(child->full_name, cma_areas[i].full_name))
> +				cma = &cma_areas[i];
> +		if (!cma)
> +			continue;
> +
> +		for (i=0;; i++) {
> +			struct device_node *node;
> +			node = of_parse_phandle(child, "device", i);
> +			if (!node)
> +				break;
> +
> +			cma_maps[cma_map_count].cma = cma;
> +			cma_maps[cma_map_count].node = node;
> +			cma_map_count++;
> +		}

of_parse_phandle() requires of_node_put() to be called when done with
the device node.
Also, of_node_put() should be called on the parent node as well.

> +	}
> +}

--
Francesco
