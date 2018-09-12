From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Wed, 12 Sep 2018 08:32:58 +0000
Subject: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <5b98cd2c-02f7-0934-41c5-1da3e3557896@arm.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
 <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838785947@FRAEML521-MBX.china.huawei.com>
 <5b98cd2c-02f7-0934-41c5-1da3e3557896@arm.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838786A46@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: 11 September 2018 11:25
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi at arm.com
> Cc: will.deacon at arm.com; mark.rutland at arm.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
> pabba at codeaurora.org; vkilari at codeaurora.org; rruigrok at codeaurora.org;
> linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder at gmail.com
> Subject: Re: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
> 
> On 10/09/18 17:37, Shameerali Kolothum Thodi wrote:
> [...]
> >>> @@ -0,0 +1,838 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/* Copyright (c) 2017 The Linux Foundation. All rights reserved.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> +modify
> >>> + * it under the terms of the GNU General Public License version 2 and
> >>> + * only version 2 as published by the Free Software Foundation.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>
> >> You don't really need to add the license text as well as SPDX. Except for the
> fact
> >> that in this case they don't match - which is it?
> >
> > Right. I will stick to SPDX-License-Identifier: GPL-2.0+
> 
> My question there is about the "+" - the license of the original patch
> was GPL-2.0, and I'm not sure about the legitimacy of quietly changing
> it to 2.0-or-later, especially without any visible agreement from
> previous contributors.

Ah..To avoid complication, I will change it to SPDX-License-Identifier: GPL-2.0.

> [...]
> >> Also, how relevant is it going to be for future DT support? We don't really
> want
> >> too many artificial dependencies on the way ACPI support happens to
> currently
> >> be implemented.
> >
> > Sorry, it's not clear to me what is proposed here as far as naming the PMU is
> > concerned. Please see below as well.
> 
> Here I mean whether pdev->id is meaningful for OF platform devices in
> the same way as for IORT devices in terms of uniqueness - it may well
> be, but if it isn't then we should find a better alternative.

Ok. Thanks for clarifying this.
 
> >>> +out:
> >>> +	kfree(temp);
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +
> >>> +static char *smmu_pmu_assign_name(struct smmu_pmu *pmu) {
> >>> +	unsigned long id;
> >>> +	struct device *smmu, *dev = pmu->dev;
> >>> +	char *s_name = NULL, *p_name = NULL;
> >>> +
> >>> +	smmu = iort_find_pmcg_ref_smmu(dev);
> >>> +	if (smmu) {
> >>> +		if (!smmu_pmu_get_dev_id(dev_name(smmu), &id))
> >>> +			s_name = kasprintf(GFP_KERNEL,
> >> "arm_smmu_v3_%lu", id);
> >>> +	}
> >>> +
> >>> +	if (!s_name)
> >>> +		s_name = kasprintf(GFP_KERNEL, "arm_smmu_v3");
> >>
> >> As I touched on before, I think it's worth generalising this from the start, and
> >> trying to resolve the component reference to a struct device rather than
> >> IORT/SMMU specific internals. However it also occurs to me that maybe this
> >> isn't as important as it first seemed - since the auto-numbered ID doesn't
> >> actually say which PMCG is which, the only way for the user to actually
> identify
> >> which PMU is the correct one to count events for a particular endpoint is
> still to
> >> grovel up the base address, so as long as the PMU name uniquely correlates
> to
> >> the PMCG device, I'm not sure anything really matters beyond that.
> >
> > So If I understand this correctly,
> >
> > iort_find_pmcg_ref_smmu() should be something like  iort_find_pmcg_ref()
> > which returns the associated struct device for the ref node and then, pmu is
> > named as,
> >
> > arm_smmu_v3_x_pmcg_y
> > nc_dev_name_x_pmcg_y
> > pciXXXX_pmcg_y  (It?s a bit tricky for RC as we will end up with struct pci_bus)
> >
> > (where x and y are auto ids)
> >
> > Please let me know if this is what is proposed here.
> 
> That's more or less what I was angling at, but as mentioned I realise
> it's fundamentally flawed (looking back at the original thread, I see it
> was me that proposed the idea, quelle suprise!)
> 
> Say you want to count events on one particular stream ID - how do you
> determine which of "arm_smmu_v3_0_pmcg_0" to
> "arm_smmu_v3_0_pmcg_6"
> represents the actual TBU that can see that SID? Sure, you have a *bit*
> more information than if they were just named, say, "arm_pmcg_0" to
> "arm_pmcg_6", but it's not actually *useful* information because those
> IDs only really represent the probe order, and that depends entirely on
> the IORT/DT order and whatever Linux felt like doing.
> 
> Thus if going to all this effort to compose a complex name still doesn't
> actually help the user in most cases, is it worth it? I'm starting to
> think not.
> 
> > It is possible to include the pmcg base address instead of the auto-numbered
> id
> > as proposed in v1 series.
> 
> That's probably the most robust option for now unless anyone can come up
> with a better idea (I do wonder about doing something horrible with
> pmu->dev.parent...) My bad for missing that rather subtle point the
> first time around, sorry everyone! 

Agree to the fact that the benefit out of all the complexity involved in
sorting out the reference device is not that great. So I am planning to
go back to the v1 way of naming pmcg along with the base address
for the next revision of this series, unless there is a better idea.

Thanks,
Shameer
