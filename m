From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 15:03:37 +0000
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <1485872710.2932.65.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1485870854.2932.63.camel@pengutronix.de>
 <1485872710.2932.65.camel@pengutronix.de>
Message-ID: <20170131150337.GZ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 03:25:10PM +0100, Philipp Zabel wrote:
> On Tue, 2017-01-31 at 14:54 +0100, Philipp Zabel wrote:
> > Hi Steve,
> > 
> > I have just tested the imx-media-staging-md-wip branch on a Nitrogen6X
> > with a tc358743 (BD_HDMI_MIPI HDMI to MIPI CSI-2 receiver board). Some
> > observations:
> > 
> > # Link pipeline
> > media-ctl -l "'tc358743 1-000f':0->'imx6-mipi-csi2':0[1]"
> > media-ctl -l "'imx6-mipi-csi2':1->'ipu1_csi0_mux':0[1]"
> > media-ctl -l "'ipu1_csi0_mux':2->'ipu1_csi0':0[1]"
> > media-ctl -l "'ipu1_csi0':2->'ipu1_csi0 capture':0[1]"
> > 
> > # Provide an EDID to the HDMI source
> > v4l2-ctl -d /dev/v4l-subdev2 --set-edid=file=edid-1080p.hex
> > # At this point the HDMI source is enabled and sends a 1080p60 signal
> > # Configure detected DV timings
> > media-ctl --set-dv "'tc358743 1-000f':0"
> > 
> > # Set pad formats
> > media-ctl --set-v4l2 "'tc358743 1-000f':0[fmt:UYVY/1920x1080]"
> > media-ctl --set-v4l2 "'imx6-mipi-csi2':1[fmt:UYVY2X8/1920x1080]"
> > media-ctl --set-v4l2 "'ipu1_csi0_mux':2[fmt:UYVY2X8/1920x1080]"
> 
> I noticed this seems to get ignored. The format is incorrectly set to
> UYVY even though I request UYVY2X8 (see CSI2IPU chapter, Figure 19-10.
> YUV422-8 data reception in the reference manual), but it seems to work
> anyway.

That's because the driver at imx-csi level bypasses the proper media pad
formats on its sink pads, and instead goes poking about at the "sensor"
to get the format.

This is one of the reasons it wants to know which entity is the "sensor".

The "sensor" stuff in there needs to be scrapped...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
