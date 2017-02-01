From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 09:20:28 +0000
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <15fdc901-d342-4761-e86e-caef8912a0a2@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <20170131004510.GQ27312@n2100.armlinux.org.uk>
 <951c1a08-c0f2-4333-b4bf-410de8dd863f@gmail.com>
 <20170131110027.GU27312@n2100.armlinux.org.uk>
 <3a673cba-bbf6-5611-5857-4605797bf049@gmail.com>
 <20170201002331.GG27312@n2100.armlinux.org.uk>
 <15fdc901-d342-4761-e86e-caef8912a0a2@gmail.com>
Message-ID: <20170201092028.GK27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 05:54:52PM -0800, Steve Longerbeam wrote:
> On 01/31/2017 04:23 PM, Russell King - ARM Linux wrote:
> First, thank you for the explanation, it clears up a lot.
> 
> But of_parse_subdev() is used to parse the OF graph starting
> from the CSI ports, to discover all the nodes to add to subdev
> async registration. It also forms the media link info to be used
> later to create the media graph, after all discovered subdevs
> have come online (registered themselves). This happens at
> driver load time, it doesn't have anything to do with pad
> negotiation.

Right, but I'm discussing why you need to know which is the sensor
subdev, and why you need to get parameters from the sensor subdev.

> >   I think the
> >issue here is how you're going about dealing with the subdevs.
> >Here's the subdev setup:
> >
> >+---------camera--------+
> >| pixel array -> binner |---> csi2 --> ipu1csi0 mux --> csi0 --> smfc --> idmac
> >+-----------------------+
> >
> >How the subdevs are supposed to work is that you start from the first
> >subdev in sequence (in this case the pixel array) and negotiate with
> >the driver through the TRY formats on its source pad, as well as
> >negotiating with the sink pad of the directly neighbouring subdev.
> >
> >The neighbouring subdev propagates the configuration in a driver
> >specific manner from its source pad to the sink pad, giving a default
> >configuration at its source.
> 
> Let me try to re-phrase. You mean the subdev's set_fmt(), when
> configured  its source pad(s), should call set_fmt() at the connected
> sink subdev to automatically propagate the format to the sink's pad?

No.  For any individual subdev, if you configure it's _sink_ then it
should propagate the configuration to its _source_, potentially
modifying the configuration according to its function.  It should
never forward the configuration to the other side of any links.

The responsibility for setting up the neighbours source pad is the
userspace media application.

See Documentation/media/uapi/v4l/dev-subdev.rst and the section
named "Format Negotiation".

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
