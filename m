From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 25 Apr 2018 09:28:49 -0600
Subject: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <20180425101051.15349-1-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
Message-ID: <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Depending on the kernel configuration, early ARM architecture setup code
> may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> backed buffers (a special bit in the GPU's MMU page tables indicates the
> memory path to take: via the SMMU or directly to the memory controller).
> Transparently backing DMA memory with an IOMMU prevents Nouveau from
> properly handling such memory accesses and causes memory access faults.
> 
> As a side-note: buffers other than those allocated in instance memory
> don't need to be physically contiguous from the GPU's perspective since
> the GPU can map them into contiguous buffers using its own MMU. Mapping
> these buffers through the IOMMU is unnecessary and will even lead to
> performance degradation because of the additional translation.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> I had already sent this out independently to fix a regression that was
> introduced in v4.16, but then Christoph pointed out that it should've
> been sent to a wider audience and should use a core API rather than
> calling into architecture code directly.
> 
> I've added it to this series for easier reference and to show the need
> for the new API.

This is good stuff, I am struggling with something similar on ARM64. One
problem that I wasn't able to fully solve cleanly was that for arm-smmu 
the SMMU HW resources are not released until the domain itself is destroyed
and I never quite figured out a way to swap the default domain cleanly.

This is a problem for the MSM GPU because not only do we run our own IOMMU as
you do we also have a hardware dependency to use context bank 0 to
asynchronously switch the pagetable during rendering.

I'm not sure if this is a problem you have encountered. In any event, this code
gets us a little bit further down the path and at least there is somebody else
out there in the cold dark world that understands my pain. :)

For your interest, here was my half-hearted attempt to avoid creating DMA
domains in the first place based on a blacklist to try to spur a bit of
discussion: https://patchwork.freedesktop.org/series/41573/

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
