From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 10:37:07 +0200
Subject: [PATCH v4 06/11] drm/sun4i: add support for Allwinner DE2 mixers
In-Reply-To: <88F5FAC9-1873-4C76-9AB9-FF361C07664E@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-7-icenowy@aosc.io>
 <20170418090047.7i2k6dtoqxfdqwwy@lukather>
 <88F5FAC9-1873-4C76-9AB9-FF361C07664E@aosc.io>
Message-ID: <20170420083707.wdtrdlxpvocpzc7g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 06:47:56PM +0800, Icenowy Zheng wrote:
> >> +	/* Get the physical address of the buffer in memory */
> >> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
> >> +
> >> +	DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
> >> +
> >> +	/* Compute the start of the displayed memory */
> >> +	bpp = fb->format->cpp[0];
> >> +	paddr = gem->paddr + fb->offsets[0];
> >> +	paddr += (state->src_x >> 16) * bpp;
> >> +	paddr += (state->src_y >> 16) * fb->pitches[0];
> >> +
> >> +	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
> >> +
> >> +	paddr_u32 = (uint32_t) paddr;
> >
> >How does that work on 64-bits systems ?
> 
> The hardware is not designed to work on 64-bit systems.
> 
> Even 64-bit A64/H5 has also 3GiB memory limit.

That's a fragile assumption.

> The address cell in mixer hardware is also only 32-bit.
> 
> So we should just keep the force conversion here. If we then really
> met 4GiB-capable AW SoC without changing DE2, I think we should have
> other way to limit CMA pool inside 4GiB.

The register name looks like this is only the lower 32 bits that you
can set here, and that there is another register for the upper 32 bits
of that address somewhere.

In that case, please use the lower_32_bits and upper_32_bits helper,
and don't cast it that way.

If it isn't the case, you should set the DMA mask (through
dma_set_mask) so that we only allocate memory that can be accessed by
this device.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/77277f32/attachment.sig>
