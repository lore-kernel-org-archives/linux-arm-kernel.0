From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 2 Aug 2010 11:45:04 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802172941C.fujita.tomonori@lab.ntt.co.jp>
References: <1280546124.1902.30.camel@pasglop> <20100802074812.GM24084@amd.com>
	<1280736182.1902.55.camel@pasglop>
	<20100802172941C.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100802094504.GF29744@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 04:30:26AM -0400, FUJITA Tomonori wrote:
> On Mon, 02 Aug 2010 18:03:02 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2010-08-02 at 09:48 +0200, Roedel, Joerg wrote:
> > > > Hrm, indeed I just noticed that. Pretty gross... it should definitly
> > > be
> > > > renamed, is will caused endless confusion with unrelated iommu.h and
> > > > iommu_* interfaces which represent something different.
> > > 
> > > The first direction to go should be trying to unify all the different
> > > iommu* interfaces into the iommu-api. The generic api will definitly
> > > need to be extended for that, but since it is an in-kernel interface
> > > thats no problem. 
> > 
> > Well, I suppose I'm the de-facto candidate to take care of the powerpc
> > side then :-)
> 
> We already agreed that what the iommu-api looks like?

Well, we currently trying to figure out how to extend the IOMMU-API
concepts to fit the omap-hardware in. Thats what I currently discuss
with Stephan. It looks to me that we need to add the concept
of device contexts to the IOMMU-API. We should also add IO-TLB
management functions. The TLB management is currently handled completly
in the backend driver. This needs to be changed and makes sense for
AMD IOMMUs and Intel IOMMUs with QPI too.

> ARM's iommu code (arch/plat-omap/include/plat/iommu.h) is a library to
> simplify the IOMMU implementations. It could be useful for all the
> iommu implementations.

To me it looks like a very hardware specific library. But it should fit
well in the domain/device concept the IOMMU-API provides (when we also
add device-contexts to it)

> The current iommu-api (include/linux/iommu.h) provides the common
> interface for specific purposes (for KVM).

The IOMMU-API is not limited to the purposes of KVM. There is
currently development effort to use the IOMMU-API for UIO stuff. So the
IOMMU-API is by no means KVM specific.

> Another question is how the above can work with the DMA-API.

This would work if we handle every device-context the platform provides
as 'struct device'. But does that really need to work with the DMA-API?
What is the driver use-case for that?

		Joerg

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
