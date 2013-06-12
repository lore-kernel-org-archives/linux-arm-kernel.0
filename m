From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jun 2013 20:40:21 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130612170512.GU18614@n2100.arm.linux.org.uk>
References: <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
 <20130610225607.GE18614@n2100.arm.linux.org.uk>
 <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
 <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
 <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
Message-ID: <20130612194021.GX18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:05:12PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 12, 2013 at 05:49:14PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 12, 2013 at 09:56:22AM -0400, Rob Clark wrote:
> > > On Wed, Jun 12, 2013 at 9:48 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > And having thought about this driver, DRM some more, I'm now of the
> > > > opinion that DRM is not suitable for driving hardware where the GPU is
> > > > an entirely separate IP block from the display side.
> > > >
> > > > DRM is modelled after the PC setup where your "graphics card" does
> > > > everything - it has the GPU, display and connectors all integrated
> > > > together.  This is not the case on embedded SoCs, which can be a
> > > > collection of different IPs all integrated together.
> > > 
> > > actually it isn't even the case on desktop/laptop anymore, where you
> > > can have one gpu with scanout and a second one without (or just with
> > > display controller not hooked up to anything, etc, etc)
> > > 
> > > That is the point of dmabuf and the upcoming fence/reservation stuff.
> > 
> > Okay, but dmabuf really needs to be fixed, because as it stands this API
> > is really quite broken wrt the DMA API.  dma_map_sg() is (a) not supposed
> > to have its return value ignored - mappings can fail, and (b) the returned
> > number indicates how many entries are valid for the _mapped_ version of
> > the scatterlist.
> > 
> > Both these points are important if your DMA API implementation uses an
> > IOMMU, which may coalesce the scatterlist array when creating mappings -
> > much as described in Documentation/DMA-API.txt and
> > Documentation/DMA-API-HOWTO.txt.
> > 
> > That is not all DRMs fault - (a) is attributable to DRM's prime
> > implementation:
> > 
> >         sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
> > 
> >         if (!IS_ERR_OR_NULL(sgt))
> >                 dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> > 
> > and quite why it does the dma_map_sg() beneath the struct_mutex is
> > beyond me - if the array of pages isn't safe without the mutex being
> > held, then it isn't safe after the dma_map_sg() operation has completed
> > and the mutex has been released.
> > 
> > However, (b) is more a problem for dmabuf (which I just rather aptly
> > mistyped as dmabug) because either dmabuf's .map_dma_buf method needs
> > to return the value from dma_map_sg(), or it needs to stop requiring
> > this of the .map_dma_buf method and have it done by the caller of
> > this method so the caller can have access to that returned value.
> > 
> > Added Sumit Semwal to this email for the dmabuf issue.
> > 
> > Thankfully, this being correct isn't a requirement for me, but it's
> > something which _should_ be fixed.
> 
> Okay, so Sumit Semwal has been a victim of TI's cuts, so don't expect
> dma_buf to get sorted by the original author...

And now the next muckup in dma-buf/drm_prime - though it's arguably the
fault of IS_ERR_OR_NULL existing in the first place:

drm_gem_prime_import()
{
        sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
        if (IS_ERR_OR_NULL(sgt)) {
                ret = PTR_ERR(sgt);
                goto fail_detach;
        }
fail_detach:
        dma_buf_detach(dma_buf, attach);
        return ERR_PTR(ret);
}

What happens if sgt is NULL here?  What value does ret get?  What does
drm_gem_prime_import() return?  How is that interpreted by
drm_gem_prime_fd_to_handle() ?

I can probably oops a kernel running DRM through this if I can manipulate
a dma_buf_map_attachment() to return NULL (there probably is a driver
which is capable of doing so.)

APIs which use IS_ERR_OR_NULL() are problems waiting to happen; we've
already reached some concensus a while back to get rid of this helper,
if only it wasn't soo prolific (like its errors are.)
