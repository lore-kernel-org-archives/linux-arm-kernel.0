From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jul 2014 18:06:30 +0100
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <20140721154313.1de8bf6f@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143428.078b68a4@bbrezillon> <20140721125522.GE15238@ulmo>
 <2695740.osZpCPIB8S@avalon> <20140721133034.GI15238@ulmo>
 <20140721154313.1de8bf6f@bbrezillon>
Message-ID: <20140721170630.GG21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:43:13PM +0200, Boris BREZILLON wrote:
> How about using a list instead of an array ?
> This way we can add elements to this list when parsing the EDID.
> 
> Or we can just define a maximum size for the bus_formats array when
> retrieving this info from EDID. If I'm correct we have at most 18 bus
> formats:
>  - 3 color formats:
>    * RGB 4:4:4
>    * YCbCr 4:4:4
>    * YCbCr 4:4:2
>  - 6 color depths: 6, 8, 10, 12, 14 and 16 bits per color

This starts to worry me.  What are we trying to do here - are we trying
to encode the connection between the CRTC and the encoder, the encoder
and the connector, or the connector and the device?

The encoder to connector and connector to device is mostly a function of
the interface spec itself (for example, many HDMI encoders take either a
RGB or YUV input and can convert it to the HDMI specified colourspaces for
transmission over the connector.)

If you want to do encoder to connector, what about VGA or some other
analogue signalling such as TV composite?  It's easy to take this too
far...

Surely the only one which matters is the CRTC to the encoder - that's
certainly true of all the setups I've come across so far.  As for that
interface, CRTCs I've seen can produce a /wide/ range of different
representations.

Some CRTCs (eg, AMBA CLCD) produce R, G, B signals scrunched down on to
the LSB bits of a LCD data bus (so RGB888 uses 24 bits, RGB444 would
use the LSB 12 bits of those 24 - rather than outputting the R4 bits on
a subset of the R8 bits.)

What about RGB565 - where you have differing number of bits for the
green channel from red/blue?

Then you have red/blue colour swapping at the CRTC (and similar for YUV)
such as on Dove / Armada.

Then there are some encoders have the ability to almost arbitarily map
their input pins according to whatever you choose (eg, TDA998x).

This problem isn't as quite as simple as "this is what EDID gives us"
and "these are the number of bits representing a colour".

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
