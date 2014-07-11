From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jul 2014 15:37:34 +0100
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <53B7E86D.5040109@gmail.com>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk> <53B7E86D.5040109@gmail.com>
Message-ID: <20140711143733.GB21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 05, 2014 at 01:58:37PM +0200, Sebastian Hesselbarth wrote:
> On 07/05/2014 12:38 PM, Russell King wrote:
> > Move the variant initialisation entirely to the CRTC init function -
> > the variant support is really about the CRTC properties than the whole
> > system, and we want to treat each CRTC individually when we support DT.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> [...]
> > diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
> > index 531a9b0bdcfb..3f0e70bb2e9c 100644
> > --- a/drivers/gpu/drm/armada/armada_crtc.h
> > +++ b/drivers/gpu/drm/armada/armada_crtc.h
> > @@ -38,6 +38,7 @@ struct armada_crtc {
> >  	unsigned		num;
> >  	void __iomem		*base;
> >  	struct clk		*clk;
> > +	struct clk		*extclk[2];
> 
> Russell,
> 
> I wonder, if we should rename above array srcclk instead of extclk
> while moving it anyway. That way we can use it for the other variant
> specific clocks, too.

As the patches are prepared with this change, I'd prefer to submit them
as-is, and then we can update that as and when the support for things
like the MMP/610 is finished off.  I think they're good to go, so I'll
send them off later today to David.

This leaves the TDA998x componentisation patches which I need to kick
out, and the initial DT changes.  Once those are in place, we should
have almost all ducks lined up for working DRM support - it'll certainly
be advanced enough to describe the LCD controllers and the TDA998x as
three separate DT entities using the of graph helpers.

What's left is the display-subsystem { } entity to describe the makeup
of the subsystem.  That's not included as we currently need to pass
a block of memory, and the DT support for reserving chunks of memory
appeared (last time I looked) to only be botch-merged (only half of it
seems to have been merged making the whole reserved memory thing
totally useless - why people only half-merge features I've no idea.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
