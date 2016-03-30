From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Mar 2016 18:24:12 +0100
Subject: [PATCH 11/13] dtb: amd: Add PCIe SMMU device tree node
In-Reply-To: <56FBF754.7020804@linaro.org>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160128111453.GG17123@leverpostej> <56AA07AA.7050701@arm.com>
 <6645680.g0j8d12m6d@wuerfel> <20160128142751.GA775@arm.com>
 <56FBF2B7.8090601@linaro.org> <20160330154538.GA10224@arm.com>
 <56FBF754.7020804@linaro.org>
Message-ID: <20160330172412.GB10224@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 05:57:08PM +0200, Eric Auger wrote:
> On 03/30/2016 05:45 PM, Will Deacon wrote:
> > On Wed, Mar 30, 2016 at 05:37:27PM +0200, Eric Auger wrote:
> >> On 01/28/2016 03:27 PM, Will Deacon wrote:
> >>> On Thu, Jan 28, 2016 at 03:17:33PM +0100, Arnd Bergmann wrote:
> >>>> On Thursday 28 January 2016 12:20:58 Robin Murphy wrote:
> >>>>>>
> >>>>> Any IDs specified here would only apply to DMA by the "platform device" 
> >>>>> side of the host controller itself (as would an equivalent "iommus" 
> >>>>> property on pcie0 once I finish the SMMUv2 generic binding support I'm 
> >>>>> working on). In terms of PCI devices, the "mmu-masters" property is 
> >>>>> overloaded such that only its existence matters, to identify that there 
> >>>>> _is_ a relationship between the SMMU and the PCI bus(es) behind that 
> >>>>> host controller.
> >>>>
> >>>> I wasn't aware that this was actually still specified. I had hoped
> >>>> we were getting rid of mmu-masters before anyone actually started
> >>>> using it, but now I see it in ns2.dtsi and fsl-ls2080a.dtsi.
> >>>>
> >>>> Does anyone know what happened to the plan to use the iommu DT binding
> >>>> for the ARM SMMU instead? Do we now have to support both ways indefinitely?
> >>>
> >>> We always did -- Seattle used the mmu-masters binding before the generic
> >>> binding even existed. Robin has been working on patches to get of_xlate
> >>> up and running, but it got held up by Laurent's series which didn't end
> >>> up going anywhere.
> >>>
> >> Up to now I have used the PCI smmu description as described in Suravee's
> >> patch and this does not work anymore with 4.6-rc1 since the default
> >> domain was introduced. So now I see 2 SMRs matching a single streamid
> >> (in my case 256, one steming from the "platform device" side of the host
> >> controller and one steming from the PCI device) and this causes SMCF
> >> (stream match conflict fault). So PCIe PF does not work.
> > 
> > Sorry about that, it wasn't intentional. In fact, I wrote commit
> > cbf8277ef456 ("iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now")
> > specifically to avoid this breakage, after seeing it myself with VFIO
> > and an S2CR-based configuration. It looks like the check just needs moving
> > higher up (i.e. before we initialise the SMRs).
> > 
> > Does that fix it for you?
> Yes this fixes the issue for me, thanks! I guess you will send that patch?

I need to check that it doesn't break rebinding to the host after VFIO
has been used for passthrough, first.

Does your devicetree explicitly assign a StreamID to the platform device
for the host controller? We should probably be handling this, since it
will crop us as an issue again once we decide to enable the default
domain properly.

> So eventually what is the right way to describe the smmu-masters (~
> future of that patch)?

Using the generic iommu binding
(Documentation/devicetree/bindings/iommu/iommu.txt), which will be required
for of_xlate-based probing. The old binding should still continue to
function as it always has, though.

Will
