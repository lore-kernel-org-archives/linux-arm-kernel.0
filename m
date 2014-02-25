From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 25 Feb 2014 17:51:21 +0100
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <20140225134139.GA23898@earth.universe>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
 <20140225134139.GA23898@earth.universe>
Message-ID: <2364124.7r818M0xAj@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 14:41:48 Sebastian Reichel wrote:
> On Tue, Feb 25, 2014 at 12:39:21PM +0000, Russell King - ARM Linux wrote:
> > > That compatible string is correct according to the latest series
> > > posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> > > SubSystem (DSS) [0].
> > 
> > in which case:
> > 
> > N    N   AA     CCCC  K  K
> > NN   N  A  A   C    C K K
> > N N  N A    A C       KK
> > N  N N AAAAAA C       KK
> > N   NN A    A  C    C K K
> > N    N A    A   CCCC  K  K
> > 
> > Yes, that's a very big nack.  Two things:
> > 
> > 1. OMAP really doesn't have the right to define a compatible string which
> >    is as generic as "hdmi-connector".
> 
> AFAIK the idea was to have "hdmi-connector" as part of the common
> display framework [1]. It's not really platform specific, since it's
> just a connector.
> 
> Since omapdss does not yet implement the common display framework,
> but wants to keep a stable DT API it rewrites "hdmi-connector" to
> "omapdss,hdmi-connector" for now.

And since the common display framework has been pretty much nacked, we have no 
framework on which drivers can rely ;-)

> > 2. Even with "omapdss," before it, the convention that DT people have
> >    adopted is for the prefix to be "companyname," and not a subsystem.
> > 
> > I'm not the only one with this concern - I discussed it with Arnd last
> > night and his comments were about it being "obviously bogus".
> > 
> > > The property is added on this patch [1] and as far as I understood the
> > > idea is that it could be a generic DT binding that can be used by
> > > platform specific HDMI connectors like the omap dss HDMI connector [2].
> > 
> > Why do the physical connectors need a DT binding?
> 
> This is the termination of the video bus and useful information for
> xrandr.

I don't think all physical connectors require a DT binding per-se, but they 
need to be represented in DT as they're part of the hardware. We could push 
connector-related information to the nodes of all chips that have interfaces 
wired directly to connectors, but that would result in more complex DT 
bindings and core. I believe modeling connectors using separate DT nodes is be 
best, and would allow easier support for more complex connectors that carry 
multiple streams/signals in parallel (video, audio, DDC, ...).

> > Surely what needs the DT binding is the HDMI encoder - and that certainly
> > should no way be a generic name, because there's no such thing as a
> > generic HDMI encoder chip.
> 
> The HDMI encoder and companion chips are described separatly and properly
> prefixed [0].
> 
> [0] http://www.spinics.net/lists/linux-omap/msg102522.html
> [1] https://lwn.net/Articles/563157/

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/b6e28a40/attachment.sig>
