From: mzoran@crowfest.net (Michael Zoran)
Date: Thu, 22 Nov 2018 22:58:10 -0600
Subject: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
In-Reply-To: <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
 <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
Message-ID: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
> 
> The point here is not about setting and resetting the plane->fb
> pointer. It's about what happens inside
> drm_atomic_set_fb_for_plane().
> 
> It calls drm_framebuffer_get() for the new fb and
> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> the old fb, which had its reference count incremented in the atomic
> commit that set it to the plane before, has its reference count
> decremented. Moreover, if the new reference count becomes 0,
> drm_framebuffer_put() will immediately free the buffer.
> 
> Freeing a buffer when the hardware is still scanning out of it isn't
> a
> good idea, is it?

No, it's not.  But the board I submitted the patch for doesn't have
anything like hot swapable ram.  The ram access is still going to work,
just it might display something it shouldn't. Say for example if that
frame buffer got reused by somethig else and filled with new data in
the very small window.

But yes, I agree the best solution would be to not release the buffer
until the next vblank.

Perhaps a good solution would be for the DRM api to have the concept of
a deferred release?  Meaning if the put() call just added the frame
buffer to a list that DRM core could walk during the vblank.  That
might be better then every single driver trying to work up a custom
solution.

> The vc4 driver seems to be able to program the hardware to switch the
> scanout to the new buffer immediately:
> 
> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> 
> Although I wonder if there isn't still a tiny race there - the
> hardware may have just started refilling the FIFO from the old
> address. Still, if the FIFO is small, the FIFO refill operation may
> be
> much shorter than it takes for the kernel code to actually free the
> buffer. Eric and Michael, could you confirm?
> 

I don't have those boards anymore, and I don't have access to any
technical documentation on the GPU so I can't really add much here.  
Eric can probably provide the best information.

I submitted the patch because I was working on arm64 support for fun
and was becomming very annoyed by desktop lockups for long periods of
time on the desktop enviroment of my choice due to the driver being
flooded with curser animation updates.  I sent the patch to Eric who
was kind enough to review it and suggest some improvements.  
