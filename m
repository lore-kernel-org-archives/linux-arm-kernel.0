From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Mar 2016 19:14:51 +0000
Subject: [PATCH] drm/fb_cma_helper: Implement fb_mmap callback
In-Reply-To: <20160316152825.GR14170@phenom.ffwll.local>
References: <11eb10d95109abc104beb94c0409d49644ea8517.1458140105.git.robin.murphy@arm.com>
 <20160316152825.GR14170@phenom.ffwll.local>
Message-ID: <20160316191450.GY19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 04:28:25PM +0100, Daniel Vetter wrote:
> On Wed, Mar 16, 2016 at 02:57:49PM +0000, Robin Murphy wrote:
> > In the absence of an fb_mmap callback, the fbdev code falls back to a
> > naive implementation which relies upon the DMA address being the same
> > as the physical address, and the buffer being physically contiguous
> > from there. Whilst this often holds for standard CMA allocations via
> > the platform's regular DMA ops, if the allocation is provided by an
> > IOMMU then such assumptions can fall apart spectacularly.
> > 
> > To resolve this, reroute the fb_mmap call to the appropriate DMA API
> > implementation, as per the other cma_helper calls.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > Hi dri-devel,
> > 
> > This is an empirical fix for something I tickled via the newly-added
> > ARM HDLCD driver on a Juno platform - I have no idea whatsoever about
> > how "proper" it is in terms of the DRM infrastructure, so feel free to
> > treat this as a bug report rather than an actual patch if appropriate ;)
> 
> I think the best case would be if we could have a generic fbdev helper
> that remaps to dumb mmap support. But that's a bit tricky to pull of:
> 1. from fb_info we can get at the fbdev drm_framebuffer.
> 2. from a drm_framebuffer we can get at the underlying backing storage
> object using fb->funcs->get_handle.
> 3. With that handle we could go into the dumb mmap support (using als the
> vma) and create the mmap.
> 
> Except that ->get_handle needs a file_priv, and that just exist for the
> fbdev emulation kms client. I guess we could fix that by creating a
> minimal fake drm file_priv for the fbdev emulation (and treat it more like
> any other kms client), but I think that's way too much work when this
> simple patch here gets the job done.

I think first, a different question needs to be answered:

include/uapi/linux/fb.h:

struct fb_fix_screeninfo {
        char id[16];                    /* identification string eg "TT Builtin" */
        unsigned long smem_start;       /* Start of frame buffer mem */
                                        /* (physical address) */

Should a DMA address be exposed through smem_start, rather than a
physical address as the long-standing documentation quoted above
has stated?

Is it, in fact, a driver bug to store something that isn't a physical
address there?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
