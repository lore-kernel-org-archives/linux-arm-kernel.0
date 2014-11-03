From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 3 Nov 2014 11:10:18 +0000
Subject: [PATCH v7 3/8] arm64: introduce is_device_dma_coherent
In-Reply-To: <20141103105716.GC23162@arm.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
 <1414422568-19103-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1411031045340.22875@kaball.uk.xensource.com>
 <20141103105716.GC23162@arm.com>
Message-ID: <alpine.DEB.2.02.1411031101400.22875@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Nov 2014, Will Deacon wrote:
> On Mon, Nov 03, 2014 at 10:46:03AM +0000, Stefano Stabellini wrote:
> > On Mon, 27 Oct 2014, Stefano Stabellini wrote:
> > > Introduce a boolean flag and an accessor function to check whether a
> > > device is dma_coherent. Set the flag from set_arch_dma_coherent_ops.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > CC: will.deacon at arm.com
> > 
> > Will, Catalin,
> > are you OK with this patch?
> 
> It would be nicer if the dma_coherent flag didn't have to be duplicated by
> each architecture in dev_archdata. Is there any reason not to put it in the
> core code?

Yes, there is a reason for it: if I added a boolean dma_coherent flag in
struct device as Catalin initially suggested, what would be the default
for each architecture? Where would I set it for arch that don't use
device tree? It is not easy.

I thought it would be better to introduce is_device_dma_coherent only on
the architectures where it certainly makes sense to have it. In fact I
checked and arm and arm64 are the only architectures to define
set_arch_dma_coherent_ops at the moment. At that point if
is_device_dma_coherent becomes arch-specific, it makes sense to store
the flag in dev_archdata instead of struct device.
