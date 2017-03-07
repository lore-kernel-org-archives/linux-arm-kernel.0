From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 7 Mar 2017 15:06:07 +0100
Subject: [PATCH] iommu/arm-smmu: Report smmu type in dmesg
In-Reply-To: <d055d4c2-4d06-caba-4d84-21c22718fe76@arm.com>
References: <20170306135833.21455-1-rrichter@cavium.com>
 <d055d4c2-4d06-caba-4d84-21c22718fe76@arm.com>
Message-ID: <20170307140607.GY16822@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.03.17 18:22:08, Robin Murphy wrote:
> On 06/03/17 13:58, Robert Richter wrote:
> > The ARM SMMU detection especially depends from system firmware. For
> > better diagnostic, log the detected type in dmesg.
> 
> This paragraph especially depends from grammar. I think.

Thanks for the mail on you. :)

> 
> > The smmu type's name is now stored in struct arm_smmu_type and ACPI
> > code is modified to use that struct too. Rename ARM_SMMU_MATCH_DATA()
> > macro to ARM_SMMU_TYPE() for better readability.
> > 
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 61 ++++++++++++++++++++++++------------------------
> >  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> That seems a relatively invasive diffstat for the sake of printing a
> string once at boot time to what I can only assume is a small audience
> of firmware developers who find "cat
> /sys/firmware/devicetree/base/iommu*/compatible" (or the ACPI
> equivalent) too hard ;)

Reading firmware data is not really a solution as you don't know what
the driver is doing with it. The actual background of this patch is to
be sure a certain workaround was enabled in the kernel. ARM's cpu
errata framework does this nicely. In case of smmus we just have the
internal model implementation type which is not visible in the logs.
Right now, there is no way to figure that out without knowing fw
specifics and kernel sources.

The change is big but most of it is a reasonable rework anyway. I
didn't want to split that into a series of patches. But I could do
that.

> Assuming there is a really good reason somewhere to justify this, I
> still wonder if a simple self-contained "smmu->model to string" function
> wouldn't do, if we really want to do this? Maybe it's not quite that
> simple if the generic case needs to key off smmu->version as well, but
> still. Arguably, just searching the of_match_table by model/version and
> printing the corresponding DT compatible would do the job (given an
> MMU-400 model to disambiguate those).

Whatever you prefer. To me a dynamic search makes things more complex
for no benefit. And providing DT names in an ACPI context is confusing
either.

> Either way it ought to be replacing the "SMMUv%d with:" message in
> arm_smmu_device_cfg_probe() - this driver is noisy enough already
> without starting to repeat itself.
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index abf6496843a6..5c793b3d3173 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -366,6 +366,7 @@ struct arm_smmu_device {
> >  	u32				options;
> >  	enum arm_smmu_arch_version	version;
> >  	enum arm_smmu_implementation	model;
> > +	const char			*name;
> 
> If we are going to add a pointer to static implementation data, it may
> as well be a "const arm_smmu_type *type" pointer to subsume version and
> model as well.

The name still may change but not the particular string. Both work for
me.

> 
> >  
> >  	u32				num_context_banks;
> >  	u32				num_s2_context_banks;
> > @@ -1955,19 +1956,20 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >  	return 0;
> >  }
> >  
> > -struct arm_smmu_match_data {
> > +struct arm_smmu_type {
> >  	enum arm_smmu_arch_version version;
> >  	enum arm_smmu_implementation model;
> > +	const char *name;
> >  };
> >  
> > -#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> > -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> > +#define ARM_SMMU_TYPE(var, ver, imp, _name)	\
> > +static struct arm_smmu_type var = { .version = ver, .model = imp, .name = _name }
> >  
> > -ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> > -ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> > -ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > -ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > -ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > +ARM_SMMU_TYPE(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU, "smmu-generic-v1");
> > +ARM_SMMU_TYPE(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU, "smmu-generic-v2");
> > +ARM_SMMU_TYPE(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU, "arm-mmu401");
> 
> Strictly, I think you mean "ARM? CoreLink? MMU-401". Printing the name
> of a driver-internal structure looks like someone left a debugging hack in.
> 
> > +ARM_SMMU_TYPE(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, "arm-mmu500");
> 
> And similarly. Of course, I'm not actually suggesting that using the
> full marketing names of things is a great idea, but then again if we do
> go naming specific IPs, and anyone gets sniffy about using the names
> "properly", then guess what's going to get removed again? You'll always
> find me firmly in the "easier not to go there" camp.

A change of naming is unrelated to this patch. I leave this up to you.

Thank you for review.

-Robert
