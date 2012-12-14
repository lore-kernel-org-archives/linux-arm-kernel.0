From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 14 Dec 2012 21:50:59 +0100
Subject: [RFC] drm/lcdc: add TI LCD Controller DRM driver
In-Reply-To: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
Message-ID: <CAKMK7uHxABma1JO_WPT54_p3wXCP3-BVbo5_XnUox-fez+tV2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 1:04 AM, Rob Clark <robdclark@gmail.com> wrote:
> +static int lcdc_crtc_page_flip(struct drm_crtc *crtc,
> +               struct drm_framebuffer *fb,
> +               struct drm_pending_vblank_event *event)
> +{
> +       struct lcdc_crtc *lcdc_crtc = to_lcdc_crtc(crtc);
> +       struct drm_device *dev = crtc->dev;
> +
> +       if (lcdc_crtc->event) {
> +               dev_err(dev->dev, "already pending page flip!\n");
> +               return -EBUSY;
> +       }
> +
> +       // TODO we should hold a ref to the fb somewhere..

Note that with the current fb refcounting nothing prevents you from
fixing this. The ugly problems I've had to solve for the locking
rework are all due to the drm core (i.e. setcrtc/pageflip/...) ioctl
functions assuming that an fb can't suddenly disappear while holding
the mode_config lock. Since I wanted to remove that requirement I've
had to changed the refcounting in the drm core functions.

But drivers can already extend the lifetime of an fb simply by
grabbing a reference (as long as they grab that reference while
holding the struct mutex all the time between fb lookup and grabbing
the reference). And it will continue to work the same with the new
locking scheme.
-Daniel

> +       crtc->fb = fb;
> +       lcdc_crtc->event = event;
> +       update_scanout(crtc);
> +
> +       return 0;
> +}
> +



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
