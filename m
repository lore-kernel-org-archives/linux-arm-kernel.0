From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Jan 2017 17:31:51 +0100
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <c6e98327-7e2c-f34a-2d23-af7b236de441@xs4all.nl>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <c6e98327-7e2c-f34a-2d23-af7b236de441@xs4all.nl>
Message-ID: <1484929911.2897.70.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, 2017-01-20 at 14:52 +0100, Hans Verkuil wrote:
> Hi Steve, Philipp,
> 
> On 01/07/2017 03:11 AM, Steve Longerbeam wrote:
> > In version 3:
> > 
> > Changes suggested by Rob Herring <robh@kernel.org>:
> > 
> >   - prepended FIM node properties with vendor prefix "fsl,".
> > 
> >   - make mipi csi-2 receiver compatible string SoC specific:
> >     "fsl,imx6-mipi-csi2" instead of "fsl,imx-mipi-csi2".
> > 
> >   - redundant "_clk" removed from mipi csi-2 receiver clock-names property.
> > 
> >   - removed board-specific info from the media driver binding doc. These
> >     were all related to sensor bindings, which already are (adv7180)
> >     or will be (ov564x) covered in separate binding docs. All reference
> >     board info not related to DT bindings has been moved to
> >     Documentation/media/v4l-drivers/imx.rst.
> > 
> >   - removed "_mipi" from the OV5640 compatible string.
> > 
> > Changes suggested by Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>:
> > 
> >   Mostly cosmetic/non-functional changes which I won't list here, except
> >   for the following:
> > 
> >   - spin_lock_irqsave() changed to spin_lock() in a couple interrupt handlers.
> > 
> >   - fixed some unnecessary of_node_put()'s in for_each_child_of_node() loops.
> > 
> >   - check/handle return code from required reg property of CSI port nodes.
> > 
> >   - check/handle return code from clk_prepare_enable().
> > 
> > Changes suggested by Fabio Estevam <festevam@gmail.com>:
> > 
> >   - switch to VGEN3 Analog Vdd supply assuming rev. C SabreSD boards.
> > 
> >   - finally got around to passing valid IOMUX pin config values to the
> >     pin groups.
> > 
> > Other changes:
> > 
> >   - removed the FIM properties that overrided the v4l2 FIM control defaults
> >     values. This was left-over from a requirement of a customer and is not
> >     necessary here.
> > 
> >   - The FIM must be explicitly enabled in the fim child node under the CSI
> >     port nodes, using the status property. If not enabled, FIM v4l2 controls
> >     will not appear in the video capture driver.
> > 
> >   - brought in additional media types patch from Philipp Zabel. Use new
> >     MEDIA_ENT_F_VID_IF_BRIDGE in mipi csi-2 receiver subdev.
> > 
> >   - brought in latest platform generic video multiplexer subdevice driver
> >     from Philipp Zabel (squashed with patch that uses new MEDIA_ENT_F_MUX).
> > 
> >   - removed imx-media-of.h, moved those prototypes into imx-media.h.
> 
> Based on the discussion on the mailinglist it seems everyone agrees that this
> is the preferred driver, correct?

No. I have some major reservations against the custom mem2mem framework
embedded in Steve's driver.
I think it is a misuse of the media entity links (which should describe
hardware connections) for something that should be done at the vb2 level
(letting one device's capture EOF interrupt trigger the next device's
m2m device_run without going through userspace).
Steve and I disagree on that point, so we'd appreciate if we could get
some more eyes on the above issue.

regards
Philipp
