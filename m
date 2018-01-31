From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 31 Jan 2018 12:34:34 +0000
Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838641882@FRAEML521-MBX.china.huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA8386400F7@FRAEML521-MBX.china.huawei.com>
 <20180130180013.GA16154@e107981-ln.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838641882@FRAEML521-MBX.china.huawei.com>
Message-ID: <20180131123434.GA933@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 12:10:47PM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > I went back and re-read the patches, I think the point here is that the
> > perf driver (ie PATCH 2 that, by the way, is not maiinline) uses
> > devm_ioremap_resource() to map the counters and that's what is causing
> > failures when PMCG is part of SMMUv3 registers.
> 
> Thanks for going through this.  No, this is not where we are seeing the failure.
> May be I was not clear in my earlier mail. The failure happens in SMMUv3
> driver probe function when it calls devm_ioremap_resource().

Understood - because the PMU PMCG driver calls it first, that's what
I was referring to.

My point is that:

- the PMCG platform device resources should be built with the correct
  resource hierarchy
- and even then, I do not think that using devm_ioremap_resource() in
  the PMCG PMU driver is the correct way of handling its resource
  reservation (ie the kernel must be able to detect that a resource is
  contained in a parent one but I am not sure devm_ioremap_resource()
  is the way to handle this correctly)

> > It is the resources hierarchy that is wrong and in turn, I do not think
> > devm_request_mem_region() is the right way of requesting it for the
> > PMCG driver.
> > 
> > I need to look into this but I suspect that's something that should
> > be handled in the PMCG driver, that has to request the memory region
> > _differently_ (ie ioremap copes with this overlap - it is the
> > devm_request_mem_region() in devm_ioremap_resource() that fails, correct
> > ?).
> 
> It looks like, in IORT code,
> 
> iort_add_platform_device()--> platform_device_add()-->insert_resource(), inserts
> both SMMUv3 and PMCG resources into the resource tree and then when the probe
> of SMMUv3 is called, it detects the conflict.
> 
> [   85.548749] arm-smmu-v3 arm-smmu-v3.0.auto: can't request region for resource [mem 0x148000000-0x14801ffff]                      
> 
> Of course, changing devm_ioremap_resource() to devm_ioremap() in SMMv3
> driver probe solves the issue for us, but not sure that's the right approach or not.

See above.

Lorenzo
