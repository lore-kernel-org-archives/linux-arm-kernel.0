From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Thu, 8 Dec 2016 17:57:55 +0200
Subject: [PATCH] drm: zte: add overlay plane support
In-Reply-To: <1481166761-5100-1-git-send-email-shawnguo@kernel.org>
References: <1481166761-5100-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20161208155755.GY31595@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 11:12:41AM +0800, Shawn Guo wrote:
<snip>
> +static void zx_vl_plane_atomic_update(struct drm_plane *plane,
> +				      struct drm_plane_state *old_state)
> +{
> +	struct zx_plane *zplane = to_zx_plane(plane);
> +	struct drm_framebuffer *fb = plane->state->fb;
> +	struct drm_gem_cma_object *cma_obj;
> +	void __iomem *layer = zplane->layer;
> +	void __iomem *hbsc = zplane->hbsc;
> +	void __iomem *paddr_reg;
> +	dma_addr_t paddr;
> +	u32 src_x, src_y, src_w, src_h;
> +	u32 dst_x, dst_y, dst_w, dst_h;
> +	uint32_t format;
> +	u32 fmt;
> +	int num_planes;
> +	int i;
> +
> +	if (!fb)
> +		return;
> +
> +	format = fb->pixel_format;
> +
> +	src_x = plane->state->src_x >> 16;
> +	src_y = plane->state->src_y >> 16;
> +	src_w = plane->state->src_w >> 16;
> +	src_h = plane->state->src_h >> 16;
> +
> +	dst_x = plane->state->crtc_x;
> +	dst_y = plane->state->crtc_y;
> +	dst_w = plane->state->crtc_w;
> +	dst_h = plane->state->crtc_h;

This shouls use the clipped coordiantes.

> +
> +	/* Set up data address registers for Y, Cb and Cr planes */
> +	num_planes = drm_format_num_planes(format);
> +	paddr_reg = layer + VL_Y;
> +	for (i = 0; i < num_planes; i++) {
> +		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
> +		paddr = cma_obj->paddr + fb->offsets[i];
> +		paddr += src_y * fb->pitches[i];
> +		paddr += src_x * drm_format_plane_cpp(format, i);
> +		zx_writel(paddr_reg, paddr);
> +		paddr_reg += 4;
> +	}
> +


-- 
Ville Syrj?l?
Intel OTC
