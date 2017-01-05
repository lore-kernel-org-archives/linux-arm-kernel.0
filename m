From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 5 Jan 2017 15:35:49 +0000
Subject: [PATCH 02/10] iommu/of: Prepare for deferred IOMMU configuration
In-Reply-To: <7cd7bcfb-abae-2948-c3f8-230c0d9c9db6@arm.com>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
 <1480465344-11862-3-git-send-email-sricharan@codeaurora.org>
 <20161130161723.GA9042@red-moon>
 <c89825aa-c75f-8493-fe92-7cc97f525bc7@arm.com>
 <20161201112917.GA9680@red-moon>
 <003601d2672e$91744b40$b45ce1c0$@codeaurora.org>
 <20170105122714.GA30449@red-moon>
 <7cd7bcfb-abae-2948-c3f8-230c0d9c9db6@arm.com>
Message-ID: <20170105153549.GA31090@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 01:52:29PM +0000, Robin Murphy wrote:

[...]

> > Question: I had a look into this and instead of fiddling about with the
> > linker script entries in ACPI (ie IORT_ACPI_DECLARE - which I hope this
> > patchset would help remove entirely), I think that the only check we
> > need in IORT is, depending on what type of SMMU a given device is
> > connected to, to check if the respective SMMU driver is compiled in the
> > kernel and it will be probed, _eventually_.
> > 
> > As Robin said, by the time a device is probed the respective SMMU
> > devices are already created and registered with IORT kernel code or
> > they will never be, so to understand if we should defer probing
> > SMMU device creation is _not_ really a problem in ACPI.
> > 
> > To check if a SMMU driver is enabled, do we really need a linker
> > table ?
> > 
> > Would not a check based on eg:
> > 
> > /**
> >  * @type: IOMMU IORT node type of the IOMMU a device is connected to
> >  */
> > static bool iort_iommu_driver_enabled(u8 type)
> > {
> > 	switch (type) {
> > 	case ACPI_IORT_SMMU_V3:
> > 		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
> 
> IS_BUILTIN(...)

Yep right, it is currently equivalent but that does not mean it
will always be.

> > 	case ACPI_IORT_SMMU:
> > 		return IS_ENABLED(CONFIG_ARM_SMMU);
> > 	default:
> > 		pr_warn("Unknown IORT SMMU type\n");
> 
> Might displaying the actual value be helfpul for debugging a broken IORT
> table?

Yes I will do.

> > 		return false;
> > 	}
> > }
> > 
> > be sufficient (it is a bit gross, agreed, but it is to understand if
> > that's all we need) ? Is there anything I am missing ?
> > 
> > Let me know, I will put together a patch for you I really do not
> > want to block your series for this trivial niggle.
> 
> Other than that, though, I like it :) IORT has a small, strictly
> bounded, set of supported devices, so I really don't see the need to go
> overboard putting it on parity with DT when something this neat and
> simple will suffice.

Ok, patch coming, which will also allow Sricharan to get rid of the
IORT linker script infrastructure altogether (and more than that,
I can write the patches on top of Sricharan series that I managed
to rebase against v4.10-rc2).

Thanks,
Lorenzo
