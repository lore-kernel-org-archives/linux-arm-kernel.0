From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Jul 2014 13:21:15 +0100
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <53B7E86D.5040109@gmail.com>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk> <53B7E86D.5040109@gmail.com>
Message-ID: <20140705122115.GP21766@n2100.arm.linux.org.uk>
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

pixelclk may be a better name for it.  I would like to think about the
clock handling further though - the issues surrounding clock selection
are not limited to just Armada - imx-drm has the exact same problem.

The issue with clocking of CRTCs is that it seems to be common that:

1. you have multiple clocks to choose from, some of which may be more
   suitable than others depending on the type of output.

2. clocks end up being shared between multiple CRTCs, and one CRTC
   can (at the moment) interfere with the clock rate delivered to
   another CRTC.

This happens on imx-drm today, where the two DIs (CRTCs) are in use -
one for HDMI, the other for LVDS.  We end up with HDMI set first to
148.5MHz, and then LVDS sets it's clock to 65MHz, which results in
HDMI receiving a clock at over 500MHz!  At the moment, there are hacks
to solve this by adjusting the muxes in the clock paths to ensure that
they both derive from different PLLs - moving the LVDS onto the USB OTG
PLL rather than the video PLL.  That works fine until USB OTG wants
to change the OTG PLL.

There's also the issue whether the output can cope with fractional
clock-skipping dividers - entirely synchronous display systems can
(such as synchronously clocked LCD panels), but asynchronous display
systems (such as HDMI, TV out, etc) can't.  That said, the other
parameter that needs to be taken account of here is that even with the
fractional divider, the minimum output clock period isn't the average
frequency, but the maximum frequency, which may violate a panel's minimum
clock period specification.

I think there's lots to do on the clocking side, and as it's a fairly
complex problem which is common to multiple implementations, I think
that any solution should not be specific.

However, this topic isn't one which I want to work on until I have
reduced down my patch sets to something more manageable - something
which I'm desperate to do.  (I've been trying to avoid adding any
further patches to any tree for some time now.)  This is why (eg) I'm
not going to fix the kernel oops-able bugs I found in the SGTL5000
codec - someone else can do that.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
