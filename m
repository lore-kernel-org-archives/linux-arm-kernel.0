From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 29 Oct 2018 11:11:16 +0800
Subject: [PATCH 3/3] drm/mediatek: Use drm_gem_cma_object instead of
 mtk_drm_gem_obj
In-Reply-To: <20181026102156.GH21967@phenom.ffwll.local>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
 <1540538523-1973-4-git-send-email-ck.hu@mediatek.com>
 <20181026102156.GH21967@phenom.ffwll.local>
Message-ID: <1540782676.13715.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,Daniel:

On Fri, 2018-10-26 at 12:21 +0200, Daniel Vetter wrote:
> On Fri, Oct 26, 2018 at 03:22:03PM +0800, CK Hu wrote:
> > After adding dma_dev in struct drm_device and
> > drm_gem_cma_dumb_create_no_kmap(), drm_gem_cma_object could replace
> > mtk_drm_gem_obj, so use drm_gem_cma_object instead of mtk_drm_gem_obj to
> > reduce redundant code.
> > 
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> 
> A few questions/thoughts:
> 
> - Why do you need both drm_device->dev and drm_device->dma_dev? Can't you
>   just register the drm_device with the right struct device?
> 

In [1], mmsys is the drm driver and ovl0 and ovl1 is the sub device
which has dma function.
In this drm, there are two crtc and each one is comprised of many
component.
This is an example of mt8173:

crtc0: ovl0, color0, aal, od, rdma0, ufoe, dsi0
crtc1: ovl1, color1, gamma, rdma1, dpi0

In the device node of ovl0 and ovl1, there is a 'iommus' parameter in
it, so use dma_alloc_xxx() and dma_map_xxx() with that device would get
iova rather than pa. I don't think it's a good idea to register ovl0 or
ovl1 as drm device because each one is just a component in a pipeline.
mmsys controls the clock and routing of multi-media system which include
this drm system, so it's better to register mmsys as drm device. Maybe
we could move 'iommus' parameter from ovl device to mmsys device, so the
dma device changes from ovl device to mmsys device. I'm not sure this
would be a good choice, how do you think?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=v4.19

> - You don't use drm_gem_prime_import_dev, so prime import isn't using the
>   right device either.

Yes, you are right. I'm not familiar with whore drm core, so I start to
modify what Mediatek drm use. But this function still works for the drm
device that itself is dma device. If one day there is a drm device which
itself is not a dma device and need this function, send a patch to
modify this function and test it with that drm device. If you want me to
modify all in advance, I'm ok but need others to test it because
Mediatek drm driver does not use them.

> 
> - exynos seems to have the same or at least similar issue, stronger case
>   for your patches if you can solve both.

I'm still Mediatek's employee. If I modify other company's driver and it
is not a MUST-BE for Mediatek, Mediatek may think I give contribution to
other company. So I've better not to modify exynos driver.

> - I'd start out with using struct drm_gem_cma_object in mtk (similar to
>   what vc4 does), and then reusing as much as possible of the existing
>   helpers. And then looking later on what's still left (like the support
>   for leaving out the virtual mapping).

I'm not clear what vc4 does. It looks like that you want me to redefine
mtk_drm_gem_obj based on drm_gem_cma_object. So it would be like

struct mtk_drm_gem_obj {
	struct drm_gem_cma_object base;
	void *cookie;
	unsigned long dma_attrs;
};

I could try to modify as this and see what have left.

Regards,
CK

> 
> -Daniel
> 

[Snip...]

> > ---
> > -- 
> > 1.9.1
> > 
> 
