From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 17 Feb 2017 14:22:14 +0200
Subject: [PATCH v4 00/36] i.MX Media Driver
In-Reply-To: <1487331818.3107.46.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <20170216222006.GA21222@n2100.armlinux.org.uk>
 <923326d6-43fe-7328-d959-14fd341e47ae@gmail.com>
 <1487331818.3107.46.camel@pengutronix.de>
Message-ID: <20170217122213.GQ16975@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp, Steve and Russell,

On Fri, Feb 17, 2017 at 12:43:38PM +0100, Philipp Zabel wrote:
> On Thu, 2017-02-16 at 14:27 -0800, Steve Longerbeam wrote:
> > 
> > On 02/16/2017 02:20 PM, Russell King - ARM Linux wrote:
> > > On Wed, Feb 15, 2017 at 06:19:02PM -0800, Steve Longerbeam wrote:
> > >> In version 4:
> > >
> > > With this version, I get:
> > >
> > > [28762.892053] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000000
> > > [28762.899409] ipu1_csi0: pipeline_set_stream failed with -110
> > >
> > 
> > Right, in the imx219, on exit from s_power(), the clock and data lanes
> > must be placed in the LP-11 state. This has been done in the ov5640 and
> > tc358743 subdevs.
> > 
> > If we want to bring in the patch that adds a .prepare_stream() op,
> > the csi-2 bus would need to be placed in LP-11 in that op instead.
> > 
> > Philipp, should I go ahead and add your .prepare_stream() patch?
> 
> I think with Russell's explanation of how the imx219 sensor operates,
> we'll have to do something before calling the sensor s_stream, but right
> now I'm still unsure what exactly.

Indeed there appears to be no other way to achieve the LP-11 state than
going through the streaming state for this particular sensor, apart from
starting streaming.

Is there a particular reason why you're waiting for the transmitter to
transfer to LP-11 state? That appears to be the last step which is done in
the csi2_s_stream() callback.

What the sensor does next is to start streaming, and the first thing it does
in that process is to switch to LP-11 state.

Have you tried what happens if you simply drop the LP-11 check? To me that
would seem the right thing to do.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
