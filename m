From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 12:19:03 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130612230057.GY18614@n2100.arm.linux.org.uk>
References: <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
 <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
 <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
 <20130612230057.GY18614@n2100.arm.linux.org.uk>
Message-ID: <20130613111903.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And another issue...

What is drm_crtc_helper_set_mode() passed as the fb argument?  Is it
the old fb, or the new fb?

bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
                              struct drm_display_mode *mode,
                              int x, int y,
                              struct drm_framebuffer *old_fb)
...
int drm_crtc_helper_set_config(struct drm_mode_set *set)
{
...
        save_set.fb = set->crtc->fb;
...
                        old_fb = set->crtc->fb;
                        set->crtc->fb = set->fb;
                        if (!drm_crtc_helper_set_mode(set->crtc, set->mode,
                                                      set->x, set->y,
                                                      old_fb)) {
...
        /* Try to restore the config */
        if (mode_changed &&
            !drm_crtc_helper_set_mode(save_set.crtc, save_set.mode, save_set.x,
                                      save_set.y, save_set.fb))
}
...
int drm_helper_resume_force_mode(struct drm_device *dev)
{
...
                ret = drm_crtc_helper_set_mode(crtc, &crtc->mode,
                                               crtc->x, crtc->y, crtc->fb);

The function prototype implies it's the old fb, as does the first use.
The second and third uses of it clearly show it being the fb which we
wish to be displayed.

The deeper I look, the more bugs there seem to be in this DRM stuff,
and I'm continuing to look because I'm chasing a framebuffer refcount
bug.
