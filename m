From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 8 Oct 2013 17:16:19 +0200
Subject: [PATCH 1/5] iommu/arm-smmu: Introduce driver option handling
In-Reply-To: <20131008150613.GC21189@mudshark.cambridge.arm.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
 <1381224444-27303-2-git-send-email-andreas.herrmann@calxeda.com>
 <20131008150613.GC21189@mudshark.cambridge.arm.com>
Message-ID: <20131008151619.GD2935@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:06:13AM -0400, Will Deacon wrote:
> On Tue, Oct 08, 2013 at 10:27:20AM +0100, Andreas Herrmann wrote:
> > Introduce handling of driver options. Options are set based on DT
> > information when probing an SMMU device. The first option introduced
> > is "arm,smmu-isolate-devices". (It will be used in the bus notifier
> > block.)
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index b632bcd..b127f0f 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -348,6 +348,7 @@ struct arm_smmu_device {
> >  #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
> >  #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
> >  	u32				features;
> > +	u32				options;
> 
> This should be enum arm_smmu_option. Also, we should probably be consistent
> between the options and features (i.e. either use an enum for each of them,
> or just stick to #defines for both).

Ok, so I'd prefer to use macros then.

> >  	int				version;
> >  
> >  	u32				num_context_banks;
> > @@ -398,6 +399,52 @@ struct arm_smmu_domain {
> >  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
> >  static LIST_HEAD(arm_smmu_devices);
> >  
> > +/* driver options */
> > +enum arm_smmu_option {
> > +	ISOLATE_DEVICES = 0,
> > +	OPTION_MAX,
> > +};
> > +
> > +struct arm_smmu_option_prop {
> > +	enum arm_smmu_option opt;
> > +	const char *prop;
> > +};
> > +
> > +static struct arm_smmu_option_prop arm_smmu_options [] = {
> > +	{ ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
> > +	{ OPTION_MAX, NULL},
> > +};
> > +
> > +static inline int arm_smmu_has_option(struct arm_smmu_device *smmu,
> > +				enum arm_smmu_option opt)
> > +{
> > +	return (smmu->options & (1 << opt));
> > +}
> > +
> > +static inline void arm_smmu_set_option(struct arm_smmu_device *smmu,
> > +				enum arm_smmu_option opt)
> > +{
> > +	smmu->options |= (1 << opt);
> > +}
> > +
> > +static inline void arm_smmu_clear_option(struct arm_smmu_device *smmu,
> > +				enum arm_smmu_option opt)
> > +{
> > +	smmu->options &= ~(1 << opt);
> > +}
> 
> These three functions are a bit over-engineered! We have things like
> __set_bit if you really want to use helpers.

Right, will adapt it.


Andreas
