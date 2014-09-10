From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 14:06:07 +0100
Subject: [RFC PATCH v2 4/7] iommu: provide helper function to configure
 an IOMMU for an of master
In-Reply-To: <1486715.2XVviDPC9Z@avalon>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-5-git-send-email-will.deacon@arm.com>
 <1486715.2XVviDPC9Z@avalon>
Message-ID: <20140910130607.GK28488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Cheers for the review.

On Wed, Sep 10, 2014 at 02:01:34PM +0100, Laurent Pinchart wrote:
> On Tuesday 02 September 2014 18:56:24 Will Deacon wrote:
> > +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> > +{
> > +	struct of_phandle_args iommu_spec;
> > +	struct iommu_dma_mapping *mapping;
> > +	struct bus_type *bus = dev->bus;
> > +	const struct iommu_ops *ops = bus->iommu_ops;
> > +	struct iommu_data *iommu = NULL;
> > +	int idx = 0;
> > +
> > +	if (!iommu_present(bus) || !ops->of_xlate)
> > +		return NULL;
> > +
> > +	/*
> > +	 * We don't currently walk up the tree looking for a parent IOMMU.
> > +	 * See the `Notes:' section of
> > +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> > +	 */
> > +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +					   "#iommu-cells", idx,
> > +					   &iommu_spec)) {
> > +		struct device_node *np = iommu_spec.np;
> > +		struct iommu_data *data = of_iommu_get_data(np);
> > +
> > +		if (!iommu) {
> > +			if (!ops->of_xlate(dev, &iommu_spec))
> > +				iommu = data;
> 
> If I understand the code correctly, this will call of_xlate for the first 
> IOMMU reference only and silently ignore all subsequent references if they 
> point to the same IOMMU device but with different stream/requester IDs. Is 
> that the desired behaviour ?

No; I just fixed that actually. I'll send a v3 soon which has a bunch of
fixes like this.

Will
