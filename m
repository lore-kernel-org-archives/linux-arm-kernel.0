From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 12 Aug 2015 20:28:08 +0800
Subject: [PATCH v4 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <20150811153947.GF14980@8bytes.org>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
 <1438597279-2937-6-git-send-email-yong.wu@mediatek.com>
 <20150811153947.GF14980@8bytes.org>
Message-ID: <1439382488.7382.23.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-11 at 17:39 +0200, Joerg Roedel wrote:
> On Mon, Aug 03, 2015 at 06:21:18PM +0800, Yong Wu wrote:
> > +/*
> > + * There is only one iommu domain called the m4u domain that
> > + * all Multimedia modules share.
> > + */
> > +static struct mtk_iommu_domain	*m4udom;
> 
> What is the reason you only implement one domain? Can't the IOMMU
> isolate different devices from each other?
Hi Joerg,

  Thanks for your review.
  From your comment, you may care that we use only one domain.

  Our HW is called m4u(MultiMedia Memory Management Unit) which
help all the multimedia hardware access the dram, include display,video
decode,video encode,camera,mdp,etc. And the m4u has only one pagetable.
(Actually there is two pagetables in m4u, one is the normal pagetable,
the other is security pagetable. Currently We don't implement the
security one, so there is only one pagetable here.)
That is to say all the multimedia devices are in the m4u domain and
share the m4u?s pagetable.

So We have only one domain here..

> > +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> > +{
> > +	struct mtk_iommu_domain *priv;
> > +
> > +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> > +		return NULL;
> > +
> > +	if (m4udom)/* The m4u domain exist. */
> > +		return &m4udom->domain;
> 
> This is not going to work. If you always return the same domain the
> iommu core might re-initialize domain state (and overwrite changed
> state). At the moment this is only the domain-type which will change
> every time this function is called, but there might be more.

In our v3[1],  I didn't return the same domain, Then I have to trick in
attach_device like below:
//============
static int mtk_iommu_attach_device(struct iommu_domain *domain,
                                  struct device *dev)
{
        struct device *imudev = xxxx;
        /*
         * Reserve one iommu domain as the m4u domain which
         * all Multimedia modules share and free the others.
         */
        if (!imudev->archdata.iommu)
               imudev->archdata.iommu = priv;
        else if (imudev->archdata.iommu != priv)
               iommu_domain_free(domain);
        xxxx
}
//==============
In this version, I used a global variable to record the m4u domain then
I can delete these code and make it simple.

Then how should I do in our case? .
If we can't return the same domain here, We have to add some code like
above in the attach_device.

[1]:http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013631.html
 
> 
> > +static int mtk_iommu_add_device(struct device *dev)
> > +{
> > +	struct iommu_group *group;
> > +	int ret;
> > +
> > +	if (!dev->archdata.iommu) /* Not a iommu client device */
> > +		return -ENODEV;
> > +
> > +	group = iommu_group_get(dev);
> > +	if (!group) {
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group)) {
> > +			dev_err(dev, "Failed to allocate IOMMU group\n");
> > +			return PTR_ERR(group);
> > +		}
> > +	}
> > +
> > +	ret = iommu_group_add_device(group, dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add IOMMU group\n");
> > +		goto err_group_put;
> > +	}
> > +
> > +	ret = iommu_attach_group(&m4udom->domain, group);
> > +	if (ret)
> > +		dev_err(dev, "Failed to attach IOMMU group\n");
> > +
> > +err_group_put:
> > +	iommu_group_put(group);
> > +	return ret;
> > +}
> 
> Putting every device into its own group indicates that the IOMMU can
> isolate between single devices on the bus, which makes it even more
> questionable that you only allow one domain for the whole driver.
> 
> 
> 	Joerg
> 
