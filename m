From: sricharan@codeaurora.org (Sricharan)
Date: Thu, 13 Aug 2015 13:39:15 +0530
Subject: [PATCH 3/5] iommu/msm: Add support for generic master bindings
In-Reply-To: <55CB9A7D.7080206@codeaurora.org>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
 <1439390869-6347-4-git-send-email-sricharan@codeaurora.org>
 <55CB9A7D.7080206@codeaurora.org>
Message-ID: <000801d0d59f$5d017f80$17047e80$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Thursday, August 13, 2015 12:42 AM
> To: Sricharan R
> Cc: linux-arm-kernel at lists.infradead.org;
iommu at lists.linux-foundation.org;
> devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> robin.murphy at arm.com; robdclark at gmail.com; joro at 8bytes.org;
> srinivas.kandagatla at linaro.org; laurent.pinchart at ideasonboard.com;
> Will.Deacon at arm.com; stepanm at codeaurora.org; treding at nvidia.com
> Subject: Re: [PATCH 3/5] iommu/msm: Add support for generic master
> bindings
> 
> On 08/12/2015 07:47 AM, Sricharan R wrote:
> > @@ -702,6 +703,44 @@ static void print_ctx_regs(void __iomem *base,
> int ctx)
> >   	       GET_PRRR(base, ctx), GET_NMRR(base, ctx));
> >   }
> >
> > +static void insert_iommu_master(struct device *dev,
> > +				struct msm_iommu_dev *iommu,
> > +				struct of_phandle_args *spec)
> > +{
> > +	struct msm_iommu_ctx_dev *master;
> > +	int sid;
> > +
> > +	master = kzalloc(sizeof(*master), GFP_KERNEL);
> 
> This is called with irqs disabled, but it's not GFP_ATOMIC. Please test
with
> DEBUG_ATOMIC_SLEEP=y.

    Ok. I will have to adjust the locking here. It should be granular only
for the list manipulation.
> 
> > +	master->of_node = dev->of_node;
> > +	list_add(&master->list, &iommu->ctx_list);
> > +
> > +	for (sid = 0; sid < spec->args_count; sid++)
> > +		master->mids[sid] = spec->args[sid];
> > +
> > +	master->num_mids = spec->args_count; }
> > +
> > +static int qcom_iommu_of_xlate(struct device *dev,
> > +			       struct of_phandle_args *spec) {
> > +	struct msm_iommu_dev *iommu;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&msm_iommu_lock, flags);
> > +	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> > +		if (iommu->dev->of_node == spec->np)
> > +			break;
> > +	}
> 
> The braces are unnecessary here.
 Ok, will remove this.
> 
> > +
> > +	if (!iommu || (iommu->dev->of_node != spec->np))
> 
> Please remove extraneous parentheses.
> 
 Ok.

> > +		return -ENODEV;
> > +
> > +	insert_iommu_master(dev, iommu, spec);
> > +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> >   irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
> >   {
> >   	struct msm_iommu_dev *iommu = dev_id; @@ -737,7 +776,7 @@
> fail:
> >   	return 0;
> >   }
> >
> > -static const struct iommu_ops msm_iommu_ops = {
> > +static struct iommu_ops msm_iommu_ops = {
> 
> Is there a reason why we can't make of_iommu_set_ops() take a const ops
> pointer?
> 
  Hmm right. of_iommu_set_ops is the one that needs change. I will add a
separate
  patch to correct that.

Regards,
 Sricharan
