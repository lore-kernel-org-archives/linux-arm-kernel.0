From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Wed, 25 Sep 2013 16:56:37 +0200
Subject: [PATCH 6/7] iommu/arm-smmu: Add module parameter
 arm-smmu=off|force_isolation
In-Reply-To: <20130924154218.GF20774@mudshark.cambridge.arm.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-7-git-send-email-andreas.herrmann@calxeda.com>
 <20130924154218.GF20774@mudshark.cambridge.arm.com>
Message-ID: <20130925145637.GB4845@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 11:42:18AM -0400, Will Deacon wrote:
> On Tue, Sep 24, 2013 at 04:07:00PM +0100, Andreas Herrmann wrote:
> >   arm-smmu=	arm-smmu driver option
> > 
> > 	off	Disable arm-smmu driver (ie. ignore available SMMUs)
> > 
> > 	force_isolation
> > 		Try to attach each master device on every SMMU to a
> > 		separate iommu_domain.
> > 
> > Default is that driver detects SMMUs but no translation is configured
> > (transactions just bypass translation process).
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 3eb2259..251564e 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -399,6 +399,9 @@ struct arm_smmu_domain {
> >  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
> >  static LIST_HEAD(arm_smmu_devices);
> >  
> > +static bool arm_smmu_disabled;
> > +static bool arm_smmu_force_isolation;
> > +
> >  static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
> >  						struct device_node *dev_node)
> >  {
> > @@ -1837,6 +1840,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> >  	struct of_phandle_args masterspec;
> >  	int num_irqs, i, err;
> >  
> > +	if (arm_smmu_disabled)
> > +		return -ENODEV;
> > +
> >  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> >  	if (!smmu) {
> >  		dev_err(dev, "failed to allocate arm_smmu_device\n");
> > @@ -2022,6 +2028,23 @@ static struct platform_driver arm_smmu_driver = {
> >  	.remove	= arm_smmu_device_remove,
> >  };
> >  
> > +static int __init arm_smmu_parse_options(char *str)
> > +{
> > +	if (*str) {
> > +		str++;
> > +		if (!strncmp(str, "off", 3))
> > +			arm_smmu_disabled = true;
> > +		else if(!strncmp(str, "force_isolation", 15))
> > +			arm_smmu_force_isolation = true;
> > +		else {
> > +			pr_warn("arm_smmu: invalid parameter (\"%s\")\n", str);
> > +			return 0;
> > +		}
> > +	}
> > +	return 1;
> > +}
> > +__setup("arm-smmu", arm_smmu_parse_options);
> 
> If this is going to be a common function for IOMMUs, let's instead move the
> command-line parsing out into the generic IOMMU layer, then have an optional
> callback into the low-level IOMMU driver for enabling/disabling it.

Makes sense and I am currently looking into it.


Andreas
