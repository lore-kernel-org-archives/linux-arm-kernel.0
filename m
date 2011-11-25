From: airlied@gmail.com (Dave Airlie)
Date: Fri, 25 Nov 2011 16:15:11 +0000
Subject: [Linaro-mm-sig] [RFC 1/2] dma-buf: Introduce dma buffer sharing
 mechanism
In-Reply-To: <1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
References: <1318325033-32688-1-git-send-email-sumit.semwal@ti.com>
 <1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
Message-ID: <CAPM=9tzjO7poyz_uYFFgONxzuTB86kKej8f2XBDHLGdUPZHvjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device *dev)
> +{
> + ? ? ? struct dma_buf_attachment *attach;
> + ? ? ? int ret;
> +
> + ? ? ? BUG_ON(!dmabuf || !dev);
> +
> + ? ? ? mutex_lock(&dmabuf->lock);
> +
> + ? ? ? attach = kzalloc(sizeof(struct dma_buf_attachment), GFP_KERNEL);
> + ? ? ? if (attach == NULL)
> + ? ? ? ? ? ? ? goto err_alloc;
> +
> + ? ? ? attach->dev = dev;
> + ? ? ? if (dmabuf->ops->attach) {
> + ? ? ? ? ? ? ? ret = dmabuf->ops->attach(dmabuf, dev, attach);
> + ? ? ? ? ? ? ? if (!ret)
> + ? ? ? ? ? ? ? ? ? ? ? goto err_attach;
> + ? ? ? }
> + ? ? ? list_add(&attach->node, &dmabuf->attachments);
> +

I would assume at some point this needed at
attach->dmabuf = dmabuf;
added.

Dave.
