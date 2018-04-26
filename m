From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 14:41:03 +0200
Subject: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
Message-ID: <20180426124103.GF11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 09:28:49AM -0600, Jordan Crouse wrote:
> On Wed, Apr 25, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Depending on the kernel configuration, early ARM architecture setup code
> > may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> > the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> > backed buffers (a special bit in the GPU's MMU page tables indicates the
> > memory path to take: via the SMMU or directly to the memory controller).
> > Transparently backing DMA memory with an IOMMU prevents Nouveau from
> > properly handling such memory accesses and causes memory access faults.
> > 
> > As a side-note: buffers other than those allocated in instance memory
> > don't need to be physically contiguous from the GPU's perspective since
> > the GPU can map them into contiguous buffers using its own MMU. Mapping
> > these buffers through the IOMMU is unnecessary and will even lead to
> > performance degradation because of the additional translation.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > I had already sent this out independently to fix a regression that was
> > introduced in v4.16, but then Christoph pointed out that it should've
> > been sent to a wider audience and should use a core API rather than
> > calling into architecture code directly.
> > 
> > I've added it to this series for easier reference and to show the need
> > for the new API.
> 
> This is good stuff, I am struggling with something similar on ARM64. One
> problem that I wasn't able to fully solve cleanly was that for arm-smmu 
> the SMMU HW resources are not released until the domain itself is destroyed
> and I never quite figured out a way to swap the default domain cleanly.
> 
> This is a problem for the MSM GPU because not only do we run our own IOMMU as
> you do we also have a hardware dependency to use context bank 0 to
> asynchronously switch the pagetable during rendering.
> 
> I'm not sure if this is a problem you have encountered.

I don't think I have. Recent chips have similar capabilities, but they
don't have the restriction to a context bank, as far as I understand.
Adding Mikko who's had more exposure to this.

> In any event, this code
> gets us a little bit further down the path and at least there is somebody else
> out there in the cold dark world that understands my pain. :)

This doesn't actually fix anything on 64-bit ARM, and oddly enough I
haven't run into this issue myself on 64-bit ARM either. I think the
reason is that I haven't tested Nouveau on Tegra186 yet, which is the
first SoC which has an ARM SMMU. On prior 64-bit ARM chips we've used
the custom Tegra SMMU and that driver simply forbids creating any DMA
domains, so it will allow only explicit usage of the IOMMU API. There
is code in the generic DMA/IOMMU integration layer to not use the DMA
API with non-DMA IOMMU domains, but that's not true on 32-bit ARM,
unfortunately. It's entirely possible that Tegra186 will show exactly
the same problem that you are describing.

We do use the IOMMU API explicitly in the Tegra DRM driver as well,
and that is something that I've tested on Tegra186 and that I know to
be working. However, the reason why it works there is that the IOMMU
group will contain multiple display controllers, which will again
trigger a special case that will prevent the DMA/IOMMU integration
from setting up a DMA domain for use with those devices.

> For your interest, here was my half-hearted attempt to avoid creating DMA
> domains in the first place based on a blacklist to try to spur a bit of
> discussion: https://patchwork.freedesktop.org/series/41573/

This looks very interesting and simple, but I can imagine that it will
see significant pushback from the ARM SMMU maintainers (if not complete
silence), because it adds SoC-specific knowledge to an otherwise fully
generic driver. Having the GPU driver explicitly detach from the IOMMU
domain sounds like a better option, but I don't see how that would help
with the context bank issue that you're seeing.

One other possibility that I can imagine is to add something to struct
device that could be used by arch_setup_dma_ops() to not attach any of
the IOMMU-backed DMA operations to the device. Unfortunately that code
is called before the driver's ->probe() implementation is called, so a
driver doesn't have an opportunity to set it. Something like
of_dma_configure() could still set that up, perhaps based on some DT
property, though I can already hear the NAK from DT maintainers because
this is, after all, policy, not hardware description.

The last solution that I can think of that might allow us to do this is
to add a flag to struct device_driver (bool explicit_iommu?) that will
be used by the DMA/IOMMU setup code to decide whether or not to attach
to the IOMMU automatically.

Though, again, I'm not sure that would actually solve your bank problem.
That's really something I don't see any other solution than to fix it in
the ARM SMMU driver. Perhaps context bank 0 can always be reserved for
non-DMA domains?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/86bf02b0/attachment-0001.sig>
