From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 15:14:18 +0200
Subject: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <fd6e0d90-7614-296b-2927-7b2745e8fbde@nvidia.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
 <20180426124103.GF11985@ulmo>
 <fd6e0d90-7614-296b-2927-7b2745e8fbde@nvidia.com>
Message-ID: <20180426131418.GH11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 03:59:04PM +0300, Mikko Perttunen wrote:
> On 26.04.2018 15:41, Thierry Reding wrote:
> > On Wed, Apr 25, 2018 at 09:28:49AM -0600, Jordan Crouse wrote:
> > > On Wed, Apr 25, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > Depending on the kernel configuration, early ARM architecture setup code
> > > > may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> > > > the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> > > > backed buffers (a special bit in the GPU's MMU page tables indicates the
> > > > memory path to take: via the SMMU or directly to the memory controller).
> > > > Transparently backing DMA memory with an IOMMU prevents Nouveau from
> > > > properly handling such memory accesses and causes memory access faults.
> > > > 
> > > > As a side-note: buffers other than those allocated in instance memory
> > > > don't need to be physically contiguous from the GPU's perspective since
> > > > the GPU can map them into contiguous buffers using its own MMU. Mapping
> > > > these buffers through the IOMMU is unnecessary and will even lead to
> > > > performance degradation because of the additional translation.
> > > > 
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > > I had already sent this out independently to fix a regression that was
> > > > introduced in v4.16, but then Christoph pointed out that it should've
> > > > been sent to a wider audience and should use a core API rather than
> > > > calling into architecture code directly.
> > > > 
> > > > I've added it to this series for easier reference and to show the need
> > > > for the new API.
> > > 
> > > This is good stuff, I am struggling with something similar on ARM64. One
> > > problem that I wasn't able to fully solve cleanly was that for arm-smmu
> > > the SMMU HW resources are not released until the domain itself is destroyed
> > > and I never quite figured out a way to swap the default domain cleanly.
> > > 
> > > This is a problem for the MSM GPU because not only do we run our own IOMMU as
> > > you do we also have a hardware dependency to use context bank 0 to
> > > asynchronously switch the pagetable during rendering.
> > > 
> > > I'm not sure if this is a problem you have encountered.
> > 
> > I don't think I have. Recent chips have similar capabilities, but they
> > don't have the restriction to a context bank, as far as I understand.
> > Adding Mikko who's had more exposure to this.
> 
> IIRC the only way I've gotten Host1x to work on Tegra186 with IOMMU enabled
> is doing the equivalent of this patch (or actually using the DMA API, which
> may be possible but has some potential issues).
> 
> As you said, we don't have a limitation regarding the context bank or
> similar - Host1x handles context switching by changing the sent stream ID on
> the fly (which is quite difficult to deal with from kernel point of view as
> well), and the actual GPU has its own MMU.

One instance where we still need the system MMU for GPU is to implement
support for big pages, which is required in order to do compression and
better performance in some other use-cases. I don't think we'll need
anything fancy like context switching in that case, though, because we
would use the SMMU exclusively to make sparse allocations look
contiguous to the GPU, so all of the per-process protection would still
be achieved via the GPU MMU.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/9f1b53c7/attachment.sig>
