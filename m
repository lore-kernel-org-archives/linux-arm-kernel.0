From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 15:28:22 +0000
Subject: [PATCH v3 16/24] media: Add i.MX media core driver
In-Reply-To: <1485170006.2874.63.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-17-git-send-email-steve_longerbeam@mentor.com>
 <1484320822.31475.96.camel@pengutronix.de>
 <a94025b4-c4dd-de51-572e-d2615a7246e4@gmail.com>
 <1484574468.8415.136.camel@pengutronix.de>
 <e38feca9-ed6f-8288-e006-768d6ba2fe5a@gmail.com>
 <1485170006.2874.63.camel@pengutronix.de>
Message-ID: <20170130152822.GB27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 12:13:26PM +0100, Philipp Zabel wrote:
> Hi Steve,
> 
> On Sun, 2017-01-22 at 18:31 -0800, Steve Longerbeam wrote:
> > Second, ignoring the above locking issue for a moment, 
> > v4l2_pipeline_pm_use()
> > will call s_power on the sensor _first_, then the mipi csi-2 s_power, 
> > when executing
> > media-ctl -l '"ov5640 1-003c":0 -> "imx6-mipi-csi2":0[1]'. Which is the 
> > wrong order.
> > In my version which enforces the correct power on order, the mipi csi-2 
> > s_power
> > is called first in that link setup, followed by the sensor.
> 
> I don't understand why you want to power up subdevs as soon as the links
> are established. Shouldn't that rather be done for all subdevices in the
> pipeline when the corresponding capture device is opened?
> It seems to me that powering up the pipeline should be the last step
> before userspace actually starts the capture.

I agree with Philipp here - configuration of the software pipeline
shouldn't result in hardware being forced to be powered up.  That's
more of a decision for the individual sub-driver than for core.

Executing media-ctl to enable a link between two sub-device endpoints
should really be a matter of setting the software state, and when the
video device is opened for streaming, surely that's when the hardware
in the chain between the source and the capture device should be
powered up and programmed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
