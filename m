From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 4 Jan 2017 17:58:22 +0000
Subject: [PATCH v6 08/14] ACPI: ARM64: IORT: rework iort_node_get_id()
In-Reply-To: <1483363905-2806-9-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170104175822.GD8604@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 09:31:39PM +0800, Hanjun Guo wrote:
> iort_node_get_id() has two output, one is the mapped ids,
> the other is the referenced parent node which is returned
> from the function.
> 
> For now we need a API just return its parent node for
> single mapping, so just update this function slightly then
> reuse it later.

I think we need to fix iort_node_get_id() first though, I am referring
to the index usage in relation to acpi_iort_id_mapping.output_reference
and related parent pointer retrieval as you reported to me, I am happy
to send it upstream independently.

As for this patch it is ok even though we can create an API that
just retrieve a node parent without fiddling about with passing
a NULL pointer for the id_out to achieve the same.

Thanks,
Lorenzo

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ab7bae7..bc68d93 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -347,7 +347,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>  		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			*id_out = map[index].output_base;
> +			if (id_out)
> +				*id_out = map[index].output_base;
>  			return parent;
>  		}
>  	}
> -- 
> 1.9.1
> 
