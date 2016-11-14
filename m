From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 14 Nov 2016 16:19:24 +0100
Subject: Summary of LPC guest MSI discussion in Santa Fe
In-Reply-To: <20161111090543.57623f2d@t450s.home>
References: <20161109233847.GT17771@arm.com>
 <20161109165957.62c1eb61@t450s.home>
 <83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
 <20161109175517.174e7803@t450s.home>
 <20161110020130.GA19108@arm.com>
 <ddd8af9d-ad8f-78d8-3048-3d640b74470e@redhat.com>
 <20161110104601.0939ba9a@t450s.home>
 <20161111111944.GO2078@8bytes.org>
 <20161111085056.4cf8989d@t450s.home>
 <20161111090543.57623f2d@t450s.home>
Message-ID: <20161114151923.GX2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 09:05:43AM -0700, Alex Williamson wrote:
> On Fri, 11 Nov 2016 08:50:56 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > It's really just a happenstance that we don't map RAM over the x86 MSI
> > range though.  That property really can't be guaranteed once we mix
> > architectures, such as running an aarch64 VM on x86 host via TCG.
> > AIUI, the MSI range is actually handled differently than other DMA
> > ranges, so a iommu_map() overlapping a range that the iommu cannot map
> > should fail just like an attempt to map beyond the address width of the
> > iommu.
> 
> (clarification, this is x86 specific, the MSI controller - interrupt
> remapper - is embedded in the iommu AIUI, so the iommu is actually not
> able to provide DMA translation for this range.

Right, on x86 the MSI range can be covered by page-tables, but those are
ignored by the IOMMU hardware. But what I am trying to say is, that
checking for these ranges happens already on a higher level (in the
dma-api implementations by marking these regions as allocted) so that
there is no need to check for them again in the iommu_map/unmap path.



	Joerg
