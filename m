From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 16:13:20 +0000
Subject: [PATCH RFC 21/46] drm: provide a helper for the encoder
 possible_crtcs mask
In-Reply-To: <CANq1E4RanNbeeh4YDLJuHMgSPStHaVN7wCD-dU-BT=3ohL7e1Q@mail.gmail.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypnh-0007Ev-3v@rmk-PC.arm.linux.org.uk>
 <CANq1E4RanNbeeh4YDLJuHMgSPStHaVN7wCD-dU-BT=3ohL7e1Q@mail.gmail.com>
Message-ID: <20140103161320.GR7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 05:05:46PM +0100, David Herrmann wrote:
> Hi
> 
> On Thu, Jan 2, 2014 at 10:27 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > The encoder possible_crtcs mask identifies which CRTCs can be bound to
> > a particular encoder.  Each bit from bit 0 defines an index in the list
> > of CRTCs held in the DRM mode_config crtc_list.  Rather than having
> > drivers trying to track the position of their CRTCs in the list, expose
> > the code which already exists for calculating the appropriate mask bit
> > for a CRTC.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/gpu/drm/drm_crtc_helper.c |   39 ++++++++++++++++++++++++------------
> >  include/drm/drm_crtc_helper.h     |    1 +
> >  2 files changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> > index 01361aba033b..10708c248196 100644
> > --- a/drivers/gpu/drm/drm_crtc_helper.c
> > +++ b/drivers/gpu/drm/drm_crtc_helper.c
> > @@ -325,6 +325,29 @@ void drm_helper_disable_unused_functions(struct drm_device *dev)
> >  EXPORT_SYMBOL(drm_helper_disable_unused_functions);
> >
> >  /**
> > + * drm_helper_crtc_possible_mask - find the mask of a registered CRTC
> > + * @crtc: crtc to find mask for
> > + *
> > + * Given a registered CRTC, return the mask bit of that CRTC for an
> > + * encoder's possible_crtcs field.
> 
> I think this is a nice cleanup which we could pick up right away. Most
> drivers can be simplified by using this. Only the name is misleading,
> imo, I'd use something like drm_helper_crtc_to_mask().

I'm not so sure - since the only place this mask gets used is with
the "possible_crtcs" field.  It's got nothing to do with the
"possible_clones" field as that isn't a mask of CRTCs.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
