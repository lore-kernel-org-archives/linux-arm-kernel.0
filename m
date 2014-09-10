From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 12:33:07 +0100
Subject: [RFC PATCH v2 3/7] iommu: add new iommu_ops callback for adding
 an OF device
In-Reply-To: <20140910112213.GH28488@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-4-git-send-email-will.deacon@arm.com>
 <541032F6.1090809@samsung.com> <20140910112213.GH28488@arm.com>
Message-ID: <20140910113306.GI28488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 12:22:13PM +0100, Will Deacon wrote:
> On Wed, Sep 10, 2014 at 12:16:06PM +0100, Marek Szyprowski wrote:
> > On 2014-09-02 19:56, Will Deacon wrote:
> > > +#ifdef CONFIG_OF_IOMMU
> > > +	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> > 
> > If I understand correctly how it is designed to work, then it should be:
> > 
> > struct iommu_data *(*of_xlate)(struct device *dev, struct 
> > of_phandle_args *args);
> 
> Yeah, that might be cleaner than the of_iommu_get_data call in
> of_dma_configure. I'm currently cooking a v3, so I'll include this change.

Actually, I spoke too soon. If we make of_xlate return the iommu_data, then
we have to continue getting the iommu_ops from the bus_type, otherwise we
have no way to call the right of_xlate.

So I'd rather leave of_dma_configure using of_iommu_get_data (I'm currently
ripping out the bus code in there) so that we can embed the iommu_ops in
iommu_data instead.

Will
