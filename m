From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 8 Jul 2014 12:03:30 +0200
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <CAF6AEGvp+A7eKWXf8uBoqXHb0Dtnt_Wz_dgFZ7Ua=UaD7yKBDw@mail.gmail.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <53ADEB73.8090301@ti.com>
 <CAF6AEGvp+A7eKWXf8uBoqXHb0Dtnt_Wz_dgFZ7Ua=UaD7yKBDw@mail.gmail.com>
Message-ID: <20140708100330.GU17271@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 06:51:15AM -0400, Rob Clark wrote:
> On Fri, Jun 27, 2014 at 6:08 PM, Darren Etheridge <detheridge@ti.com> wrote:
> > Guido,
> >
> >
> > On 06/17/2014 09:17 AM, Guido Mart?nez wrote:
> >>
> >> The tilcdc driver could be compiled as a module, but was severely broken
> >> and could not be used as such. This patchset attempts to fix the issues
> >> preventing a proper load/unload of the module.
> >>
> >> Issues included dangling sysfs nodes, dangling devices, memory leaks and
> >> a double kfree.
> >>
> >> It now seems to be working ok. We have tested this by loading and
> >> unloading the driver repeteadly, with both panel and slave connectors
> >> and found no flaws.
> >>
> >> There is still one warning left on tilcdc_crtc_destroy, caused by
> >> destroying the connector while still in an ON status. We don't know why
> >> this happens or why it's an issue, so we did not fix it.
> >>
> >
> > Yes I see what you mean, it triggers the WARN_ON in tilcdc_crtc_destroy
> > because DRM_MODE_DPMS_ON is still set.  This WARN_ON does make some sense
> > because DPMS_OFF would have the effect of turning off clocks and putting the
> > monitor to sleep which seems logical considering we have torn down the
> > display.  Adding a tilcdc_crtc_dpms(DPMS_OFF) right before the WARN_ON
> > confirms this, but it seems strange that this hasn't happened automatically
> > (+ Russell doesn't need to do it in his Armada driver) - so I suspect there
> > is a better way.
> 
> tbh, I'm not entirely sure offhand why drm_mode_config_cleanup()
> doesn't remove the fb's first (which should have the effect of
> shutting down any lit crtc/encoder/connector)..  that would seem like
> the sensible way to shut down..

All userspace fbs should be cleared already before going into the driver
unload. Which only leaves you with driver internal fbs (usually just one
for fbdev emulation). It's the driver's job to clean that up explicitly.
Then you can call mode_config_cleanup and the WARN_ON in there is a really
nice space leak check.

If we'd unconditionally clean up all fbs we'd have trouble with
driver-private embedded fbs and their refcounting and would loose the
space leak check.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
