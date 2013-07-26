From: tom.cooksey@arm.com (Tom Cooksey)
Date: Fri, 26 Jul 2013 16:58:55 +0100
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
Message-ID: <000001ce8a19$08b1f960$1a15ec20$@cooksey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> >  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
> >    allocate buffers for the GPU. Still not sure how to resolve this
> >    as we don't use DRM for our GPU driver.
> 
> any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
> once the dma-fence stuff is in place), we'd have gpu-specific drm
> (gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
> using prime/dmabuf to share between the two.

The "extra" buffers we were allocating from armsoc DDX were really
being allocated through DRM/GEM so we could get an flink name
for them and pass a reference to them back to our GPU driver on
the client side. If it weren't for our need to access those
extra off-screen buffers with the GPU we wouldn't need to
allocate them with DRM at all. So, given they are really "GPU"
buffers, it does absolutely make sense to allocate them in a
different driver to the display driver.

However, to avoid unnecessary memcpys & related cache
maintenance ops, we'd also like the GPU to render into buffers
which are scanned out by the display controller. So let's say
we continue using DRM_IOCTL_MODE_CREATE_DUMB to allocate scan
out buffers with the display's DRM driver but a custom ioctl
on the GPU's DRM driver to allocate non scanout, off-screen
buffers. Sounds great, but I don't think that really works
with DRI2. If we used two drivers to allocate buffers, which
of those drivers do we return in DRI2ConnectReply? Even if we
solve that somehow, GEM flink names are name-spaced to a
single device node (AFAIK). So when we do a DRI2GetBuffers,
how does the EGL in the client know which DRM device owns GEM
flink name "1234"? We'd need some pretty dirty hacks.

So then we looked at allocating _all_ buffers with the GPU's
DRM driver. That solves the DRI2 single-device-name and single
name-space issue. It also means the GPU would _never_ render
into buffers allocated through DRM_IOCTL_MODE_CREATE_DUMB.
One thing I wasn't sure about is if there was an objection
to using PRIME to export scanout buffers allocated with
DRM_IOCTL_MODE_CREATE_DUMB and then importing them into a GPU
driver to be rendered into? Is that a concern?

Anyway, that latter case also gets quite difficult. The "GPU"
DRM driver would need to know the constraints of the display
controller when allocating buffers intended to be scanned out.
For example, pl111 typically isn't behind an IOMMU and so
requires physically contiguous memory. We'd have to teach the
GPU's DRM driver about the constraints of the display HW. Not
exactly a clean driver model. :-(

I'm still a little stuck on how to proceed, so any ideas
would greatly appreciated! My current train of thought is
having a kind of SoC-specific DRM driver which allocates
buffers for both display and GPU within a single GEM
namespace. That SoC-specific DRM driver could then know the
constraints of both the GPU and the display HW. We could then
use PRIME to export buffers allocated with the SoC DRM driver
and import them into the GPU and/or display DRM driver.

Note: While it doesn't use the DRM framework, the Mali T6xx
kernel driver has supported importing buffers through dma_buf
for some time. I've even written an EGL extension :-):

<http://www.khronos.org/registry/egl/extensions/EXT/EGL_EXT_image_dma_buf_im
port.txt>


> I'm not entirely sure that the directions that the current CDF
> proposals are headed is necessarily the right way forward.  I'd prefer
> to see small/incremental evolution of KMS (ie. add drm_bridge and
> drm_panel, and refactor the existing encoder-slave).  Keeping it
> inside drm means that we can evolve it more easily, and avoid layers
> of glue code for no good reason.

I think CDF could allow vendors to re-use code they've written
for their Android driver stack in DRM drivers more easily. Though
I guess ideally KMS would evolve to a point where it could be used
by an Android driver stack. I.e. Support explicit fences.


Cheers,

Tom
