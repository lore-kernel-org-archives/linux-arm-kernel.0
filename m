From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 13:36:07 +0000
Subject: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
In-Reply-To: <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
 <20130123104216.1de2eee1@armhf>
 <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
Message-ID: <20130123133607.GE2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 07:24:33AM -0600, Rob Clark wrote:
> On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > Hi Rob,
> >
> > As I wanted to re-use your nxp-tda998x driver for the Marvell Dove SoC,
> > I had a look at your IT LCD driver. Comments below.
> 
> Just fyi, you can re-use the nxp-tda998x part independently of tilcdc
> (just in case that wasn't clear).

Great, this chip is also used on the cubox too.

The one thing I wonder is how you deal with the VSYNC/HSYNC polarities
that are provided to the TDA9988x chip.  On the cubox, I have to adjust
the mode parameters such that the polarities are fixed up thusly:

        adjusted->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
                             DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
                             DRM_MODE_FLAG_PCSYNC | DRM_MODE_FLAG_NCSYNC);

        /* The TDA19988 always requires negative VSYNC? */
        adjusted->flags |= DRM_MODE_FLAG_NVSYNC;

        /* The TDA19988 requires positive HSYNC on 1080p or 720p */
        if ((adjusted->hdisplay == 1920 && adjusted->vdisplay == 1080) ||
            (adjusted->hdisplay == 1280 && adjusted->vdisplay == 720))
                adjusted->flags |= DRM_MODE_FLAG_PHSYNC;
        else
                adjusted->flags |= DRM_MODE_FLAG_NHSYNC;

        return true;

for these resolutions to be displayed correctly.

Also, when the only output is the HDMI device, reporting the display
"disconnected" and without any modes seems to cause problems - I have to
report "unknown" status when there's nothing connected, and also provide
a default (720p) mode when no EDID is received.
