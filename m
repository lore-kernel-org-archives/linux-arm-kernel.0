From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 22:48:54 +0100
Subject: [PATCH 3/4] arm64: Juno: Add HDLCD support to the Juno boards.
In-Reply-To: <20150805190312.GA31066@e106497-lin.cambridge.arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-4-git-send-email-Liviu.Dudau@arm.com>
 <20150805175303.GB7557@n2100.arm.linux.org.uk>
 <20150805190312.GA31066@e106497-lin.cambridge.arm.com>
Message-ID: <20150805214854.GC7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 08:03:12PM +0100, Liviu Dudau wrote:
> I have to confess that I am not entirely up to speed with the TDA19988
> situation at the moment. Andrew Jackson was dealing with that and
> working with Jean to get that in the upstream, but his contract has
> ended and he has moved to other things.

Umm, I'm the maintainer for TDA998x:

NXP TDA998X DRM DRIVER
M:      Russell King <rmk+kernel@arm.linux.org.uk>
S:      Supported
F:      drivers/gpu/drm/i2c/tda998x_drv.c
F:      include/drm/i2c/tda998x.h

It would be nice if people worked with the actual maintainers of things
rather than random other people...

> > Also, the whole question of representing connectors in a DRM model is
> > yet to be established.  Yes, DT should describe the hardware, but we
> > don't yet know _how_ to describe physical connectors with stuff
> > implemented on top of DRM yet, and we have nothing that makes use of
> > this.
> 
> Please help me understand the current situation: you have added
> support for components that the video drivers can use and the bindings
> for that are described in Documentation/devicetree/bindings/media/video-interfaces.txt.

No.  I added the component helpers, which are entirely firmware agnostic.
The media bindings were created by others, and through development done
by Pengutronix, they were factored out of media into common DT code and
re-used for the IMX DRM driver.  The binding document which describes
that work is not the one you refer to above, but this one:

Documentation/devicetree/bindings/graph.txt

This started them as a basis for DRM drivers on ARM - but it's never been
officially "adopted" as a method to describe DRM drivers - it's only what
some drivers are using.  It ought to be nailed down as a way to ensure
inter-operability between components though, but no one has really made
that decision.

> According to that document my patch should be compliant once I add the
> reg= property. Is that something that cannot be used with tda998x driver
> or is there any other reason why you think the patch is not compliant?

Jean's proposal to add audio support to the TDA998x driver does it via
this change to the binding spec:

+Optional nodes:
+
+  - port: up to three ports.
+       The ports are defined according to [1].
+
+    Video port.
+       There may be only one video port.
+       This one must contain the following property:
+
+       - port-type: must be "rgb"
+
+       and may contain the optional property:
+
+       - reg: 24 bits value which defines how the video controller
+               output is wired to the TDA998x input (video pins)
+               When absent, the default value is <0x230145>.
+
+    Audio ports.
+       There may be one or two audio ports.
+       These ones must contain the following properties:
+
+       - port-type: must be "i2s" or "spdif"
+
+       - reg: 8 bits value which defines how the audio controller
+               output is wired to the TDA998x input (audio pins)
+
+[1] Documentation/devicetree/bindings/graph.txt

(That's not a particularly precise definition, but it's what we have at
the moment.)

> If you are referring to connecting an encoder with a HDMI connector, I
> have tested that and it seems to work, although my situation is simple
> because there are no options in my setup: one HDLCD connects to one
> TDA19988 which connects to one HDMI output.

Right now, the TDA998x will ignore the additional information, but that
won't be the case with Jean's audio work (see the above binding
information.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
