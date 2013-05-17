From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 19:00:29 +0100
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517194023.0c385ea0@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
Message-ID: <20130517180028.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 07:40:23PM +0200, Jean-Francois Moine wrote:
> On Fri, 17 May 2013 13:01:15 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > - CMA helper
> > > 
> > >   You don't use DRM_KMS_CMA_HELPER and DRM_GEM_CMA_HELPER which would
> > >   simplify some code.  
> > 
> > Possibly, but the biggest win for me is having cacheable gem objects.
> > CMA will be a retrograde step for those.
> 
> I did not think yet about the possible problems which could be raised
> when the output of the video decoding engine, vMeta, will be the LCD
> overlay plane.

Not talking about vMeta here, but the vivante GPU.  vMeta has entirely
different requirements because vMeta does not have any IOMMU, whereas
the GPU has a built-in MMU.  That alone allows us to deal with SHM-backed
buffer objects in a sensible way.

> > I've already tried to explain this to Sebastian on IRC, and kept getting
> > nonsense back from him.  "You need to program the whole chain".  Yes,
> > but that makes no sense to the question I was asking.
> > 
> > The reason is this:
> > +-----------------------------+      +------------------------+
> > | Armada510                   |      |   TDA19988             |
> > | LCD controller ---> switch ---------> switch --> processing |
> > |   VSYNC/HSYNC               |      |                        |
> > +-----------------------------+      +------------------------+
> > 
> > The issue is that each 'switch' point is capable of inverting the sync
> > signal.  If you program both identically then you end up with inversion
> > following another inversion.  Which means no inversion.  That's why
> > I've found Sebastian's answers to be much less than helpful on this
> > point.
> > 
> > What I have found with the NXP TDA19988 driver is that you need to get
> > the input syncs to the TDA19988 set to the correct polarity for the
> > TDA19988, which _isn't_ what is advertised in the EDID.  The TDA19988
> > then has its own processing internally which places the appropriate
> > sync codes onto the output data stream.
> > 
> > In some cases, getting this wrong shifts the displayed image by a few
> > pixels/lines.  In other cases you get no output or invalid output which
> > isn't recognised by the connected device.
> 
> Right. But I found that using Rob's tda988x driver gives me a full
> image on my TV set while with NXP's driver, I had more than 20 pixels
> lost on each side (left, right, top and bottom).

At the moment, Rob's driver has many problems, one of them is that it
mis-programs the NPIX and NLINE registers in such a way that it causes
my TV to complain about the input.  Basically, the driver as it stands
in mainline is totally unusable for me.  The TV doesn't recognise any
output.

Yet, program the device with the CEA mode (where it uses its own internal
settings) and lo and behold, picture.  I tracked that down to NPIX and
NLINE being completely wrong.

What you're actually seeing is what's called "overscan" which is something
that TVs do with broadcast images.  The left and right pixels, top and
bottom lines are always "off screen".  However, our computer displays,
we expect the display to be "underscanned" where the top left and bottom
right most pixels correspond with the corners of the display.

There are bits in the HDMI data stream which tell the TV whether the
display should be overscanned or underscanned.  Unfortunately, many
TVs choose to ignore this data (they're permitted to do this by the
standards), and instead decide that if it's a computer resolution, they
will underscan, otherwise if it's a broadcast resolution, they will
overscan.

That's not a bug in the transmission.  That's a bug in the display device.

> > > - hardware cursor
> > > 
> > >   Our driver always proposes the HWC 32 (RGBA 64x64).  
> > 
> > Hardware cursor support is pretty useless.
> > 
> > In RGBA mode, it's not 64x64 but you get the choice of either 64x32 or
> > 32x64.  This is useless for Xorg's purposes, where it really wants a
> > 64x64 cursor.  And the XF86 Xorg backend really wants RGBA for hardware
> > cursor, not 2bpp.  So my conclusion is that hardware cursor is not worth
> > any effort and I've a good mind to strip that out from my driver (which
> > will simplify a few places.)
> > 
> > I've played with the idea of reducing a RGBA cursor down to 2bpp mode
> > where we can fit the required size in, but that doesn't work very well.
> > 
> > Just because the hardware does something doesn't mean you should write
> > code for it! :)
> 
> Maybe I did not explain correctly: the colored cursor maybe RGB888 +
> transparency (64x64) or full ARGB (64x32 or 32x64). I coded the first
> case. And, yes, I better like a hardware cursor: it asks for less
> computation, and I get it immediately at graphic starting time!

Interesting.  Where did you find the documentation for the transparency?
The FS lists HWC32_TRANS_CNTL but omits to specify where that gets used.

> 	[snip]
> > > - video overlay
> > > 
> > >   Same as above: the code is in our driver (overlay plane), but it is
> > >   not tested.  
> > 
> > We as a family, have watched many hours of video on mine. :)
> 
> I wrote the drm driver because there was no easy way to use the video
> decoding engine with vlc and the Marvell's drivers. Now that the driver
> runs, the next step was to extend the 'modesetting' X server module to
> handle the overlay planes (I wonder why nobody did it yet). But, if you
> already have something running, I'd be glad to get it...

Ahem.  You're duplicating all my work.  I've had working vlc for mpeg2
and mpeg4 (not h264) since August/September last year!

> 	[snip]
> > > What do you think about merging?  
> > 
> > Yes, I think merging the two together would probably be sane. :)
> 
> OK.
> 
> The first step is "DT or not DT"? For me, the DT is more flexible
> (one or two LCDs, smart panel definition, display controller or not..)
> and permits easy inclusion of out of tree drivers as the private VPU
> and GPU ones.

I'd argue supporting both. :)
