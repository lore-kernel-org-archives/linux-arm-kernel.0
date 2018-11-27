From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 27 Nov 2018 08:56:02 +0100
Subject: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
In-Reply-To: <20181126224102.1efbf2d1@bbrezillon>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
 <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
 <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
 <87o9abbmq4.fsf@anholt.net> <20181126224102.1efbf2d1@bbrezillon>
Message-ID: <20181127075602.GV4266@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 10:41:02PM +0100, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 12:36:03 -0800
> Eric Anholt <eric@anholt.net> wrote:
> 
> > Michael Zoran <mzoran@crowfest.net> writes:
> > 
> > > On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:  
> > >> 
> > >> The point here is not about setting and resetting the plane->fb
> > >> pointer. It's about what happens inside
> > >> drm_atomic_set_fb_for_plane().
> > >> 
> > >> It calls drm_framebuffer_get() for the new fb and
> > >> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> > >> the old fb, which had its reference count incremented in the atomic
> > >> commit that set it to the plane before, has its reference count
> > >> decremented. Moreover, if the new reference count becomes 0,
> > >> drm_framebuffer_put() will immediately free the buffer.
> > >> 
> > >> Freeing a buffer when the hardware is still scanning out of it isn't
> > >> a
> > >> good idea, is it?  
> > >
> > > No, it's not.  But the board I submitted the patch for doesn't have
> > > anything like hot swapable ram.  The ram access is still going to work,
> > > just it might display something it shouldn't. Say for example if that
> > > frame buffer got reused by somethig else and filled with new data in
> > > the very small window.
> > >
> > > But yes, I agree the best solution would be to not release the buffer
> > > until the next vblank.
> > >
> > > Perhaps a good solution would be for the DRM api to have the concept of
> > > a deferred release?  Meaning if the put() call just added the frame
> > > buffer to a list that DRM core could walk during the vblank.  That
> > > might be better then every single driver trying to work up a custom
> > > solution.
> > >  
> > >> The vc4 driver seems to be able to program the hardware to switch the
> > >> scanout to the new buffer immediately:
> > >> 
> > >> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> > >> 
> > >> Although I wonder if there isn't still a tiny race there - the
> > >> hardware may have just started refilling the FIFO from the old
> > >> address. Still, if the FIFO is small, the FIFO refill operation may
> > >> be
> > >> much shorter than it takes for the kernel code to actually free the
> > >> buffer. Eric and Michael, could you confirm?
> > >>   
> > >
> > > I don't have those boards anymore, and I don't have access to any
> > > technical documentation on the GPU so I can't really add much here.  
> > > Eric can probably provide the best information.  
> > 
> > I don't think I understood my scanout hardware well enough when I
> > started on the async update stuff for rpi.  vc4 probably needs to wait
> > until the HW starts scanning out a new line before letting the old BO
> > get freed.
> 
> That's also my understanding. Note that even if the BO is freed before
> the HVS has finished generating a line it shouldn't crash, because
> accesses are done through DMA. Might be a security issue though if we
> start re-using the memory for something else while it's still being
> accessed.
> 
> The solution would be to wait for the EOL (End Of Line) interrupt in
> the async update path, but I'm not sure this is allowed.

For subsuming async page_flip into the async atomic commit stuff we need
completion events anyway. Firing those from the EOL (or some other
hw-dependent interrupt, could also be the next vblank) should be hard to
arrange for drivers. And the heleprs could then easily offload the
cleanup_planes work to a worker and delay it until after the event has
fired. Like it already does for normal atomic commits.

But yeah right now that's all missing. The biggest issue here is figuring
out what these events should look like, and how generic userspace needs to
use them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
