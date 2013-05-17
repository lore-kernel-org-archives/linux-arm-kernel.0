From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 May 2013 19:40:23 +0200
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517120115.GF18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
Message-ID: <20130517194023.0c385ea0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 May 2013 13:01:15 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> I already said - I don't support DT.  I don't run any DT based ARM
> devices, so I have no experience with DT.  What I care more about
> is a working cubox platform, which afaik DT still can't offer yet.

I like the DT concept. All the job I did on the Cubox is based on DT,
even when I was still using the aweful Marvell and NXP drivers. I have
nothing which is Cubox specific in my kernel, but the driver modules.

> > - CMA helper
> > 
> >   You don't use DRM_KMS_CMA_HELPER and DRM_GEM_CMA_HELPER which would
> >   simplify some code.  
> 
> Possibly, but the biggest win for me is having cacheable gem objects.
> CMA will be a retrograde step for those.

I did not think yet about the possible problems which could be raised
when the output of the video decoding engine, vMeta, will be the LCD
overlay plane.

> > - device tree
> > 
> >   Our driver depends on the DT and, by this way, it may be used for
> >   various boards (Cubox, DB-MV88AP510 Development Board, CompuLab
> >   CM-A510 Board..). Especially, in the Cubox, only a HDMI screen may be
> >   connected, while the display controller permits connection of a smart
> >   panel (port A) and a VGA screen (port B).   
> 
> I only have a Cubox, so I can't test anything but HDMI.

Sebastian has other Dove based machine(s).

> Given that there's big questions about the polarity of signals coming
> out of the Armada 510 (with the invert bits 0, are the syncs positive
> or negative?) I wouldn't like to lead anyone up the path of thinking
> that this driver supports anything but the tested HDMI scenario yet.
> 
> As that information is not in any of the Armada 510 TRMs, and can only
> be discovered by physically probing the signals with a scope... that's
> on my todo list when I feel like dismantling the Cubox and getting the
> soldering iron out to separate the two boards so I can get access to
> the signals.

Yes, from the beginning, Solidrun did not give us any information about
their hardware..., nor about their software! It seems Rabeeh is only
interested by a closed XBMC.

> I've already tried to explain this to Sebastian on IRC, and kept getting
> nonsense back from him.  "You need to program the whole chain".  Yes,
> but that makes no sense to the question I was asking.
> 
> The reason is this:
> +-----------------------------+      +------------------------+
> | Armada510                   |      |   TDA19988             |
> | LCD controller ---> switch ---------> switch --> processing |
> |   VSYNC/HSYNC               |      |                        |
> +-----------------------------+      +------------------------+
> 
> The issue is that each 'switch' point is capable of inverting the sync
> signal.  If you program both identically then you end up with inversion
> following another inversion.  Which means no inversion.  That's why
> I've found Sebastian's answers to be much less than helpful on this
> point.
> 
> What I have found with the NXP TDA19988 driver is that you need to get
> the input syncs to the TDA19988 set to the correct polarity for the
> TDA19988, which _isn't_ what is advertised in the EDID.  The TDA19988
> then has its own processing internally which places the appropriate
> sync codes onto the output data stream.
> 
> In some cases, getting this wrong shifts the displayed image by a few
> pixels/lines.  In other cases you get no output or invalid output which
> isn't recognised by the connected device.

Right. But I found that using Rob's tda988x driver gives me a full
image on my TV set while with NXP's driver, I had more than 20 pixels
lost on each side (left, right, top and bottom).

	[snip]
> > - module loading (si5351, tda998x)
> > 
> >   As our driver is loaded by the Cubox DT, and as the auxilliary drivers
> >   (external clock, HDMI transmitter) may also be modules, a
> >   synchronization mechanism (inspired by the tegra drm driver) permits
> >   the driver to start when all the other drivers are also started.  
> 
> The lack of Si5351 already gets tested on every cubox boot I do.  That
> causes probe deferal, which allows the driver to properly start when
> it becomes ready.
	[snip]

That's what we have. I added an escape mechanism in case the si5351 is
not present (I was waiting for the driver to be in the kernel). In this
case, after a first -EPROBEDEFER, the LCD works with either AXI or the
LCD PLL (both work fine with my TV set at 1920x1080p).

	[snip]
> > - hardware cursor
> > 
> >   Our driver always proposes the HWC 32 (RGBA 64x64).  
> 
> Hardware cursor support is pretty useless.
> 
> In RGBA mode, it's not 64x64 but you get the choice of either 64x32 or
> 32x64.  This is useless for Xorg's purposes, where it really wants a
> 64x64 cursor.  And the XF86 Xorg backend really wants RGBA for hardware
> cursor, not 2bpp.  So my conclusion is that hardware cursor is not worth
> any effort and I've a good mind to strip that out from my driver (which
> will simplify a few places.)
> 
> I've played with the idea of reducing a RGBA cursor down to 2bpp mode
> where we can fit the required size in, but that doesn't work very well.
> 
> Just because the hardware does something doesn't mean you should write
> code for it! :)

Maybe I did not explain correctly: the colored cursor maybe RGB888 +
transparency (64x64) or full ARGB (64x32 or 32x64). I coded the first
case. And, yes, I better like a hardware cursor: it asks for less
computation, and I get it immediately at graphic starting time!

	[snip]
> > - video overlay
> > 
> >   Same as above: the code is in our driver (overlay plane), but it is
> >   not tested.  
> 
> We as a family, have watched many hours of video on mine. :)

I wrote the drm driver because there was no easy way to use the video
decoding engine with vlc and the Marvell's drivers. Now that the driver
runs, the next step was to extend the 'modesetting' X server module to
handle the overlay planes (I wonder why nobody did it yet). But, if you
already have something running, I'd be glad to get it...

	[snip]
> > What do you think about merging?  
> 
> Yes, I think merging the two together would probably be sane. :)

OK.

The first step is "DT or not DT"? For me, the DT is more flexible
(one or two LCDs, smart panel definition, display controller or not..)
and permits easy inclusion of out of tree drivers as the private VPU
and GPU ones.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
