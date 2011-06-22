From: pullip.cho@samsung.com (KyongHo Cho)
Date: Wed, 22 Jun 2011 15:53:55 +0900
Subject: [Linaro-mm-sig] [PATCH 8/8] ARM: dma-mapping: use alloc, mmap,
	free from dma_ops
In-Reply-To: <1308556213-24970-9-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-9-git-send-email-m.szyprowski@samsung.com>
Message-ID: <BANLkTikE6qziSZhcyx4HxWqpmg0eZhR+wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> -extern void *dma_alloc_coherent(struct device *, size_t, dma_addr_t *, gfp_t);
> +extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> + ? ? ? ? ? ? ? ? ? ? ? ? ?gfp_t gfp, struct dma_attrs *attrs);
> +
> +#define dma_alloc_coherent(d,s,h,f) dma_alloc_attrs(d,s,h,f,NULL)
> +
> +static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dma_addr_t *dma_handle, gfp_t flag,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct dma_attrs *attrs)
> +{
> + ? ? ? struct dma_map_ops *ops = get_dma_ops(dev);
> + ? ? ? void *cpu_addr;
> + ? ? ? BUG_ON(!ops);
> +
> + ? ? ? cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
> + ? ? ? debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
> + ? ? ? return cpu_addr;
> +}
>

Apart from the necessity of alloc_attr,
I hope the callback implementations to check if a function pointer is NULL.
Suppose that a system want to use default ARM implementation of dma_alloc_*()
while it uses its own implementations of dma_map_*().


With your suggestion,
we have only one option:

void *my_alloc(...) {
return dma_alloc_coherent(NULL, ...);
}

struct dma_map_ops ops = {
.alloc_coherent = &my_alloc,
...
};



I think the following method is simpler:

struct dma_map_ops ops = {
.alloc_coherent = NULL,
...
};
