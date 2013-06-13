From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 12:50:16 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130613111903.GA18614@n2100.arm.linux.org.uk>
References: <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
 <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
 <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
 <20130612230057.GY18614@n2100.arm.linux.org.uk>
 <20130613111903.GA18614@n2100.arm.linux.org.uk>
Message-ID: <20130613115016.GB18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 12:19:03PM +0100, Russell King - ARM Linux wrote:
> The deeper I look, the more bugs there seem to be in this DRM stuff,
> and I'm continuing to look because I'm chasing a framebuffer refcount
> bug.

So, this refcount bug - I think I've just found it.  This is the flow of
references to the new fb on mode set:

drm_mode_setcrtc():
                        fb = drm_framebuffer_lookup(dev, crtc_req->fb_id);
        set.fb = fb;
        ret = drm_mode_set_config_internal(&set);
drm_mode_set_config_internal():
        fb = set->fb;
        ret = crtc->funcs->set_config(set);
drm_crtc_helper_set_config():
                        old_fb = set->crtc->fb;
                        set->crtc->fb = set->fb;
                        if (!drm_crtc_helper_set_mode(set->crtc, set->mode,
                                                      set->x, set->y,
                                                      old_fb)) {
                drm_helper_disable_unused_functions(dev);
drm_helper_disable_unused_functions():
        list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
                crtc->enabled = drm_helper_crtc_in_use(crtc);
                if (!crtc->enabled) {
                        crtc->fb = NULL;
		}
	}
back to drm_mode_set_config_internal():
        if (ret == 0) {
                if (fb)
                        drm_framebuffer_reference(fb);
back to drm_mode_setcrtc():
        if (fb)
                drm_framebuffer_unreference(fb);

Assuming success all the way through, what happens when a CRTC is unused
is:

1. We obtain a reference in drm_mode_setcrtc() via the lookup.
2. We set the mode
3. In trying to set the mode, we discover that all connectors for the CRTC
   are in the disconnected state, and so we disable the CRTC
4. We set crtc->fb to NULL
5. back in drm_mode_set_config_internal(), we take a reference on the
   framebuffer irrespective of this.
6. back in drm_mode_setcrtc(), we drop the original reference caused by
   the lookup.

We now have a framebuffer with a reference count incremented by one but
no actual reference to it - the CRTC's reference is completely lost by
the action of drm_helper_disable_unused_functions().

You could argue that it's something the driver should deal with - fine,
but what if it only implements the DPMS method?  Should it drop a
reference to the framebuffer when DPMS instructs it to turn off?  Surely
not, because that means when DPMS turns stuff back on you're missing a
refcount.

Are drivers required to implement a disable function and cater for the
imbalance in the upper layers of code?  If so, this is not a clean
design.
