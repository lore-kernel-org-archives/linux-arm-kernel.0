From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 Feb 2017 11:39:11 +0100
Subject: [PATCH v4 00/36] i.MX Media Driver
In-Reply-To: <20170216225742.GB21222@n2100.armlinux.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <20170216222006.GA21222@n2100.armlinux.org.uk>
 <923326d6-43fe-7328-d959-14fd341e47ae@gmail.com>
 <20170216225742.GB21222@n2100.armlinux.org.uk>
Message-ID: <1487327951.3107.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-02-16 at 22:57 +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2017 at 02:27:41PM -0800, Steve Longerbeam wrote:
> > 
> > 
> > On 02/16/2017 02:20 PM, Russell King - ARM Linux wrote:
> > >On Wed, Feb 15, 2017 at 06:19:02PM -0800, Steve Longerbeam wrote:
> > >>In version 4:
> > >
> > >With this version, I get:
> > >
> > >[28762.892053] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000000
> > >[28762.899409] ipu1_csi0: pipeline_set_stream failed with -110
> > >
> > 
> > Right, in the imx219, on exit from s_power(), the clock and data lanes
> > must be placed in the LP-11 state. This has been done in the ov5640 and
> > tc358743 subdevs.
> 
> The only way to do that is to enable streaming from the sensor, wait
> an initialisation time, and then disable streaming, and wait for the
> current line to finish.  There is _no_ other way to get the sensor to
> place its clock and data lines into LP-11 state.

I thought going through LP-11 is part of the D-PHY transmitter
initialization, during the LP->HS wakeup sequence. But then I have no
access to MIPI specs.
It is unfortunate that the i.MX6 MIPI CSI-2 core needs software
assistance here, but could it be possible to trigger that sequence in
the sensor and then without waiting switching to polling for LP-11 state
in the i.MX6 MIPI CSI-2 receiver?

> For that to happen, we need to program the sensor a bit more than we
> currently do at power on (to a minimal resolution, and setting up the
> PLLs), and introduce another 4ms on top of the 8ms or so that the
> runtime resume function already takes.
> 
> Looking at the SMIA driver, things are worse, and I suspect that it also
> will not work with the current setup - the SMIA spec shows that the CSI
> clock and data lines are tristated while the sensor is not streaming,
> which means they aren't held at a guaranteed LP-11 state, even if that
> driver momentarily enabled streaming.  Hence, Freescale's (or is it
> Synopsis') requirement may actually be difficult to satisfy.
> 
> However, I regard runtime PM broken with the current imx-capture setup.
> At the moment, power is controlled at the sensor by whether the media
> links are enabled.  So, if you have an enabled link coming off the
> sensor, the sensor will be powered up, whether you're using it or not.
> 
> Given that the number of applications out there that know about the
> media subdevs is really quite small, this combination makes having
> runtime PM in sensor devices completely pointless - they can't sleep
> as long as they have an enabled link, which could be persistent over
> many days or weeks.

regards
Philipp
