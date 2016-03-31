From: vigneshr@ti.com (Vignesh R)
Date: Thu, 31 Mar 2016 10:26:59 +0530
Subject: [v2,4/7] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56FCAE1B.90206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/30/2016 09:09 PM, Boris BREZILLON wrote:

[...]

> +int sg_alloc_table_from_buf(struct sg_table *sgt, const void *buf, size_t len,
> +			    const struct sg_constraints *constraints,
> +			    gfp_t gfp_mask)
> +{
> +	struct sg_constraints cons = { };
> +	size_t remaining, chunk_len;
> +	const void *sg_buf;
> +	int i, ret;
> +
> +	if (constraints)
> +		cons = *constraints;
> +
> +	ret = sg_check_constraints(&cons, buf, len);
> +	if (ret)
> +		return ret;
> +
> +	sg_buf = buf;
> +	remaining = len;
> +	i = 0;
> +	sg_for_each_chunk_in_buf(sg_buf, remaining, chunk_len, &cons)
> +		i++;
> +
> +	ret = sg_alloc_table(sgt, i, gfp_mask);
> +	if (ret)
> +		return ret;
> +
> +	sg_buf = buf;
> +	remaining = len;
> +	i = 0;
> +	sg_for_each_chunk_in_buf(sg_buf, remaining, chunk_len, &cons) {
> +		if (is_vmalloc_addr(sg_buf)) {
> +			struct page *vm_page;
> +
> +			vm_page = vmalloc_to_page(sg_buf);
> +			if (!vm_page) {
> +				ret = -ENOMEM;
> +				goto err_free_table;
> +			}
> +
> +			sg_set_page(&sgt->sgl[i], vm_page, chunk_len,
> +				    offset_in_page(sg_buf));
> +		} else {
> +			sg_set_buf(&sgt->sgl[i], sg_buf, chunk_len);
> +		}
> +

If the buf address is in PKMAP_BASE - PAGE_OFFSET-1 region (I have
observed that JFFS2 FS provides buffers in above region to MTD layer),
if CONFIG_DEBUG_SG is set then sg_set_buf() will throw a BUG_ON() as
virt_addr_is_valid() will return false. Is there a sane way to handle
buffers of PKMAP_BASE region with sg_*  APIs?
Or, is the function sg_alloc_table_from_buf() not to be used with such
buffers?


-- 
Regards
Vignesh
