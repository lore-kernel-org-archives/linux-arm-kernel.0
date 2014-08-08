From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 8 Aug 2014 17:52:08 +0100
Subject: [PATCH v3 2/3] xen/arm: reimplement xen_dma_unmap_page & friends
In-Reply-To: <CAG4opy8T1kqfofbbNfAOmynAniwfpS+PktK1t3ZNMo17j4BZ5w@mail.gmail.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1408081530580.2293@kaball.uk.xensource.com>
 <20140808143851.GF29341@zion.uk.xensource.com>
 <CAG4opy9ChMRYFkMz+RHqacGO3=d+mS=6ZS2qMALHpPUDzhSYsQ@mail.gmail.com>
 <20140808150001.GG29341@zion.uk.xensource.com>
 <CAG4opy8T1kqfofbbNfAOmynAniwfpS+PktK1t3ZNMo17j4BZ5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1408081751140.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Thomas Leonard wrote:
> On 8 August 2014 16:00, Wei Liu <wei.liu2@citrix.com> wrote:
> > On Fri, Aug 08, 2014 at 03:49:26PM +0100, Thomas Leonard wrote:
> >> On 8 August 2014 15:38, Wei Liu <wei.liu2@citrix.com> wrote:
> >> > On Fri, Aug 08, 2014 at 03:32:41PM +0100, Stefano Stabellini wrote:
> >> >> On Fri, 1 Aug 2014, Stefano Stabellini wrote:
> >> >> > +static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
> >> >> > +           size_t size, enum dma_data_direction dir)
> >> >> > +{
> >> >> > +   /* Cannot use __dma_page_dev_to_cpu because we don't have a
> >> >> > +    * struct page for handle */
> >> >> > +
> >> >> > +   if (dir == DMA_TO_DEVICE)
> >> >>
> >> >> This should be:
> >> >>     if (dir != DMA_TO_DEVICE)
> >> >>
> >> >> Thomas, could you please confirm that with this small fix
> >> >> http://pastebin.com/FPRf7pgL goes away?
> >> >>
> >> >
> >> > Thomas, please try this fix with my ref-counting patch.
> >> >
> >> > The old "working" version might actually cover this latent bug due to
> >> > it's long delay.
> >>
> >> I'm not sure how to apply this. The function
> >> "__xen_dma_page_dev_to_cpu" doesn't appear in your "for-thomas"
> >> branch. If you push the change to that branch I can test it.
> >>
> >
> > I think you can cherry-pick my three patches to your tree which contains
> > Stefano's patches. It's probably easier because Stefano's patches are
> > not yet in mainline while my patches should be able to apply to 3.16
> > mainline kernel without much effort.
> >
> > I've rebased my patches on top of 3.16, in for-thomas2 branch.
> 
> OK, that works for me! I tried starting the quickly-exiting VM a few
> times and it didn't break anything, and my queue service served up the
> file too. Thanks!
> 
> (for reference, this is the exact commit I tested:
> https://github.com/talex5/linux/commit/026c61c9649e0ef30546222a429a1b11ae7a7555)
> 

Thanks for testing! I'll update my patch series with the small fix.
