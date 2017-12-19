From: linu.cherian@cavium.com (Linu Cherian)
Date: Tue, 19 Dec 2017 12:25:24 +0530
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <7312293d-8897-95d8-9045-9e97a6c150eb@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <20171210023549.GA22492@virtx40>
 <999b7132-2de8-2872-1067-fc7e02cbc57a@arm.com>
 <7312293d-8897-95d8-9045-9e97a6c150eb@arm.com>
Message-ID: <20171219065524.GB13415@virtx40>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon Dec 18, 2017 at 03:39:22PM +0000, Marc Zyngier wrote:
> Thanks for putting me in the loop Robin.
> 
> On 18/12/17 14:48, Robin Murphy wrote:
> > On 10/12/17 02:35, Linu Cherian wrote:
> >> Hi,
> >>
> >>
> >> On Fri Aug 04, 2017 at 03:59:12PM -0400, Neil Leeder wrote:
> >>> This adds a driver for the SMMUv3 PMU into the perf framework.
> >>> It includes an IORT update to support PM Counter Groups.
> >>>
> >>
> >> In one of Cavium's upcoming SOC, SMMU PMCG implementation is such a way
> >> that platform bus id (Device ID in ITS terminmology)is shared with that of SMMU.
> >> This would be a matter of concern for software if the SMMU and SMMU PMCG blocks
> >> are managed by two independent drivers.
> >>
> >> The problem arises when we want to alloc/free MSIs for these devices
> >> using the APIs, platform_msi_domain_alloc/free_irqs.
> >> Platform bus id being same for these two hardware blocks, they end up sharing the same
> >> ITT(Interrupt Translation Table) in GIC ITS and hence alloc, free and management
> >> of this shared ITT becomes a problem when they are managed by two independent
> >> drivers.
> > 
> > What is the problem exactly? IIRC resizing a possibly-live ITT is a 
> > right pain in the bum to do - is it just that?
> 
> Understatement of the day! ;-) Yes, it is a massive headache, and will
> either result in a temporary loss of interrupts (at some point you have
> to unmap the ITT), or with spurious interrupts (you generate interrupts
> for all the MSIs you've blackholed when unmapping the ITT).

Just sharing a thought.

If the firmware, through device tree/ACPI 
can provide the following input to the ITS driver,
(For example, as part of msi-parent property in device tree)

1. flag indicating the ITT (Device ID) is being shared 
2. the maximum number of vectors that are required to be allocated for this ITT

resizing of ITT and the associated complexities could be avoided.   

 
> 
> > 
> >> We were looking into the option of keeping the SMMU PMCG nodes as sub nodes under
> >> SMMUv3 node, so that SMMUv3 driver could probe and figure out the total vectors
> >> required for SMMU PMCG devices and make a common platform_msi_domain_alloc/free_irqs
> >> function call for all devices that share the platform bus id.
> > 
> > I'm not sure how scalable that approach would be, since it's not 
> > entirely obvious how to handle PMCGs associated with named components or 
> > root complexes (rather than directly with SMMU instances). We certainly 
> > don't want to end up spraying similar PMCG DevID logic around all manner 
> > of GPU/accelerator/etc. drivers in future (whilst PMCGs for device TLBs 
> > will be expected to have distinct IDs from their host devices, they 
> > could reasonably still overlap with other PMCGs/SMMUs).
> > 
> >> Would like to know your expert opinion on what would be the right approach
> >> to handle this case ?
> > 
> > My gut feeling says the way to deal with this properly is in the ITS 
> > code, but I appreciate that that's a lot easier said than done :/
> 
> I can revive the hack I once wrote for that (and that was hoping to
> forever forget), but that's pretty disgusting, and subject to the above
> caveat.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...

-- 
Linu cherian
