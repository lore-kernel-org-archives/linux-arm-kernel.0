From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Tue, 3 Dec 2013 10:51:13 +0200
Subject: [PATCH 1/3] drm: Add LCD display clock polarity flags
In-Reply-To: <CAF6AEGtgsqea_FkkH6EaA_yg_a12A4vdw6ASr9+GGWgU2HEdGg@mail.gmail.com>
References: <1385998768-23512-1-git-send-email-marex@denx.de>
 <20131202200117.GN16735@n2100.arm.linux.org.uk>
 <CAF6AEGtgsqea_FkkH6EaA_yg_a12A4vdw6ASr9+GGWgU2HEdGg@mail.gmail.com>
Message-ID: <20131203085113.GQ10036@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 03:32:30PM -0500, Rob Clark wrote:
> On Mon, Dec 2, 2013 at 3:01 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 02, 2013 at 04:39:26PM +0100, Marek Vasut wrote:
> >> Add DRM flags for the LCD display clock polarity so the pixelclk-active DT
> >> property can be properly handled by drivers using the DRM API.
> >
> > I still say that not even this should be part of the DRM mode API to
> > userspace.  The hint that you're changing the user API is that you're
> > modifying a header file below a 'uapi' directory.
> >
> > The settings of double scan, sync polarity etc are all part of the
> > display mode specification (check CEA-861 documents).  Things like
> > pixel clock polarity are not part of the mode specification, they're
> > a property of the display itself and are independent of the mode.
> >
> > Therefore, they should not be part of struct drm_mode_modeinfo.
> 
> Note that we could make them part of drm_display_mode (but
> drm_crtc_convert_to_umode() should filter them out when copying from
> drm_mode_modeinfo.. I agree this information should not be coming from
> userspace).  Seems like the sort of thing that the bridge or encoder
> could set on the adjusted_mode.

Probably better to not mix user visible and internal flags in
drm_display_mode.flags. Just makes it more difficult to add
real flags. Maybe just stick them into private_flags for the
drivers that care.

-- 
Ville Syrj?l?
Intel OTC
