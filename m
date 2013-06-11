From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 11 Jun 2013 09:33:56 +0200
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610223254.GC18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <CAKMK7uHSCigrTvKENjZRgEsgtA0BeaORcj15n7JFW_uQoNp37Q@mail.gmail.com>
 <20130610223254.GC18614@n2100.arm.linux.org.uk>
Message-ID: <20130611073356.GQ22870@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:32:54PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 11, 2013 at 12:01:59AM +0200, Daniel Vetter wrote:
> > On Mon, Jun 10, 2013 at 9:59 PM, Rob Clark <robdclark@gmail.com> wrote:
> > > On Mon, Jun 10, 2013 at 1:06 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > >> On Mon, Jun 10, 2013 at 11:57:32AM -0400, Rob Clark wrote:
> > >>> On Sun, Jun 9, 2013 at 3:29 PM, Russell King
> > >>> <rmk+kernel@arm.linux.org.uk> wrote:
> > >>> > This patch adds support for the pair of LCD controllers on the Marvell
> > >>> > Armada 510 SoCs.  This driver supports:
> > >>> > - multiple contiguous scanout buffers for video and graphics
> > >>> > - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
> > >>> >   acceleration
> > >>> > - dual lcd0 and lcd1 crt operation
> > >>> > - video overlay on each LCD crt
> > >>>
> > >>> Any particular reason for not exposing the overlays as drm_plane's?
> > >>> That is probably something that should change before merging the
> > >>> driver.
> > >>
> > >> Only through not understanding much of DRM when I started this.
> > >> Provided DRM planes can do everything that I'm already doing with
> > >> the overlay support, then yes.  Otherwise, I want to stick with this
> > >> which is modelled after the i915 overlay interface.
> > 
> > Oh i915 overlays aren't a good reason ;-) I've done those way back
> > when drm didn't have any plane infrastructure and pretty much as my
> > very contribution. So totally lacked any clue.
> > 
> > If I can scrap together a bit of time I want to port the legacy
> > overlay code over to drm planes (and remap the current ioctl interface
> > to the drm plane interface for backwards compat). But atm that's
> > crushed under a giant pile of other todo items.
> 
> Aren't we all :(  The amount of time I have to touch this has reduced
> substantially over the last couple of months, which is why there's been
> a few weeks between the RFC's for this.
> 
> The issue here is that with the overlay interface, all I have to do
> with one of these pass-by-phys-address things which the X server gets
> is to:
> 
> 1. associate the phys address with a gem object
> 2. pass it in via the overlay interface
> 
> With the DRM plane stuff, this gets more complicated:
> 
> 1. associate the phys address with a gem object
> 2. call another driver private ioctl to bind the gem object to a framebuffer
>    (there is no support for this in the generic ioctl API afaics) which
>    has to allocate and setup a framebuffer

drm_mode_addfb2 is the ioctl which packs up a bunch of driver objects
(lookup is done in the driver callback, so could in theory be something
else than gem) and wraps them up into a fb with a pile of metadata
(per-plane stride&offset, fourcc code, ...). drm_mode_addfb is the legacy
ioctl for simple packed rgb formats. The drm core has helpers to map
between the two kinds of metadata (as far as possible).

> 3. use setplane to update the plane
> 
> That all increases the expense of overlay, and adds further memory
> allocations to the path (and frees when the previous framebuffer is
> discarded.)
> 
> That all makes for higher load due to more CPU expense.

CPU load won't kill you for these, the problem was more that up to 3.8 the
locking was a bit b0rked and background probing (e.g. the output poll work
reading an edid) could block framebuffer creation and pageflips. That
should be all fixed no in 3.9 (with the execption of set_planes, for those
I'd like to use the ww mutexes ... but could also be fixed now with a few
hacks).

The addfb overhead should also be easy to amortize (if it really hurts
you) as long as you keep a queue of buffers around (like X/wayland do).
Then it's even better for planar since you avoid to do per-plane lookup
;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
