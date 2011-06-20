From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Jun 2011 12:46:50 +0200
Subject: [PATCH 1/8] ARM: dma-mapping: remove offset parameter to prepare
	for generic dma_ops
In-Reply-To: <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-2-git-send-email-m.szyprowski@samsung.com>
	<op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
Message-ID: <000001cc2f37$5c5605f0$150211d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 10:36 AM Michal Nazarewicz wrote:

> On Mon, 20 Jun 2011 09:50:06 +0200, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > +static inline void dma_sync_single_for_cpu(struct device *dev,
> 
> I wouldn't really put inline here or in the function below.
> 
> > +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> > +{
> > +	BUG_ON(!valid_dma_direction(dir));
> > +
> > +	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
> > +
> > +	if (!dmabounce_sync_for_cpu(dev, handle, size, dir))
> > +		return;
> > +
> > +	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
> 
> I know it is just copy'n'paste but how about:

This patch is just about moving the code between the files and I wanted just
to show what's being changed and how. There is a final cleanup anyway in the
separate patch. All these patches are meant to start the discussion about
the way the dma mapping can be redesigned for further extensions with generic
iommu support. 

> 
> 	if (dmabounce_sync_for_cpu(dev, handle, size, dir))
> 		__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);

The above lines will be removed by the next patches in this series, so I
really see no point in changing this.

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
