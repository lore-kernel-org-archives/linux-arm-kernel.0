From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2017 12:31:00 +0000
Subject: [PATCH v4 00/36] i.MX Media Driver
In-Reply-To: <20170217122213.GQ16975@valkosipuli.retiisi.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <20170216222006.GA21222@n2100.armlinux.org.uk>
 <923326d6-43fe-7328-d959-14fd341e47ae@gmail.com>
 <1487331818.3107.46.camel@pengutronix.de>
 <20170217122213.GQ16975@valkosipuli.retiisi.org.uk>
Message-ID: <20170217123100.GG21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 02:22:14PM +0200, Sakari Ailus wrote:
> Hi Philipp, Steve and Russell,
> 
> On Fri, Feb 17, 2017 at 12:43:38PM +0100, Philipp Zabel wrote:
> > I think with Russell's explanation of how the imx219 sensor operates,
> > we'll have to do something before calling the sensor s_stream, but right
> > now I'm still unsure what exactly.
> 
> Indeed there appears to be no other way to achieve the LP-11 state than
> going through the streaming state for this particular sensor, apart from
> starting streaming.
> 
> Is there a particular reason why you're waiting for the transmitter to
> transfer to LP-11 state? That appears to be the last step which is done in
> the csi2_s_stream() callback.
> 
> What the sensor does next is to start streaming, and the first thing it does
> in that process is to switch to LP-11 state.
> 
> Have you tried what happens if you simply drop the LP-11 check? To me that
> would seem the right thing to do.

The Freescale documentation for iMX6's CSI2 receiver (chapter 40.3.1)
specifies a very specific sequence to be followed to safely bring up the
CSI2 receiver.  Bold text gets used, which implies emphasis on certain
points, which suggests that it's important to follow it.

Presumably, the reason for this is to ensure that a state machine within
the CSI2 receiver is properly synchronised to the incoming data stream,
and while avoiding the sequence may work, it may not be guaranteed to
work every time.

I guess we need someone from NXP to comment.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
