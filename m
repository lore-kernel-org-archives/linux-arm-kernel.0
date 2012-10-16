From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 16 Oct 2012 16:13:38 +0200
Subject: [Linaro-mm-sig] [RFC 0/2] DMA-mapping & IOMMU - physically
 contiguous allocations
In-Reply-To: <CAAQKjZNQFfxpr-7dFb4cgNB2Gkrxxrswds_fSrYgssxXaqRF7g@mail.gmail.com>
References: <CAAQKjZMYFNMEnb2ue2aR+6AEbOixnQFyggbXrThBCW5VOznePg@mail.gmail.com><20121016090434.7d5e088152a3e0b0606903c8@nvidia.com><CAAQKjZNQFfxpr-7dFb4cgNB2Gkrxxrswds_fSrYgssxXaqRF7g@mail.gmail.com>
Message-ID: <20121016.171338.1300372057637804407.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

Inki Dae <inki.dae@samsung.com> wrote @ Tue, 16 Oct 2012 12:12:49 +0200:

> Hi Hiroshi,
> 
> 2012/10/16 Hiroshi Doyu <hdoyu@nvidia.com>:
> > Hi Inki/Marek,
> >
> > On Tue, 16 Oct 2012 02:50:16 +0200
> > Inki Dae <inki.dae@samsung.com> wrote:
> >
> >> 2012/10/15 Marek Szyprowski <m.szyprowski@samsung.com>:
> >> > Hello,
> >> >
> >> > Some devices, which have IOMMU, for some use cases might require to
> >> > allocate a buffers for DMA which is contiguous in physical memory. Such
> >> > use cases appears for example in DRM subsystem when one wants to improve
> >> > performance or use secure buffer protection.
> >> >
> >> > I would like to ask if adding a new attribute, as proposed in this RFC
> >> > is a good idea? I feel that it might be an attribute just for a single
> >> > driver, but I would like to know your opinion. Should we look for other
> >> > solution?
> >> >
> >>
> >> In addition, currently we have worked dma-mapping-based iommu support
> >> for exynos drm driver with this patch set so this patch set has been
> >> tested with iommu enabled exynos drm driver and worked fine. actually,
> >> this feature is needed for secure mode such as TrustZone. in case of
> >> Exynos SoC, memory region for secure mode should be physically
> >> contiguous and also maybe OMAP but now dma-mapping framework doesn't
> >> guarantee physically continuous memory allocation so this patch set
> >> would make it possible.
> >
> > Agree that the contigous memory allocation is necessary for us too.
> >
> > In addition to those contiguous/discontiguous page allocation, is
> > there any way to _import_ anonymous pages allocated by a process to be
> > used in dma-mapping API later?
> >
> > I'm considering the following scenario, an user process allocates a
> > buffer by malloc() in advance, and then it asks some driver to convert
> > that buffer into IOMMU'able/DMA'able ones later. In this case, pages
> > are discouguous and even they may not be yet allocated at
> > malloc()/mmap().
> >
> 
> I'm not sure I understand what you mean but we had already tried this
> way and for this, you can refer to below link,
>                http://www.mail-archive.com/dri-devel at lists.freedesktop.org/msg22555.html

The above patch doesn't seem to have so much platform/SoC specific
code but rather it could common over other SoC as well. Is there any
plan to make it more generic, which can be used by other DRM drivers?
