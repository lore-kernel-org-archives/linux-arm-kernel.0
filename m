From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 09 Feb 2017 10:43:11 +0100
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <ca0a2eb3-21b6-d312-c8e0-61da48c4c700@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <1486036237.2289.37.camel@pengutronix.de>
 <ca0a2eb3-21b6-d312-c8e0-61da48c4c700@gmail.com>
Message-ID: <1486633391.2284.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-08 at 15:23 -0800, Steve Longerbeam wrote:
[...]
> >> +
> >> +static int imxcsi2_get_fmt(struct v4l2_subdev *sd,
> >> +			   struct v4l2_subdev_pad_config *cfg,
> >> +			   struct v4l2_subdev_format *sdformat)
> >> +{
> >> +	struct imxcsi2_dev *csi2 = sd_to_dev(sd);
> >> +
> >> +	sdformat->format = csi2->format_mbus;
> > The output formats are different from the input formats, see the media
> > bus format discussion in the other thread. The input pad is the MIPI
> > CSI-2 bus, but the four output pads are connected to the muxes / CSIs
> > via a 16-bit parallel bus.
> >
> > So if the input format is UYVY8_1X16, for example, the output should be
> > set to UYVY8_2X8.
> 
> Since the output buses from the CSI2IPU gasket are 16-bit
> parallel buses, shouldn't an input format UYVY8_1X16 also be
> the same at the output?

I looked at the reference manual again, and I think I have read this
incorrectly, probably confused by the coloring in Figure 19-10 "YUV422-8
data reception" in the CSI2IPU chapter. It looks like indeed the 16-bit
bus carries UYVY8_1X16, whereas the internal 32-bit bus between MIPI
CSI-2 decoder and the CSI2IPU carries two samples (complete UYVY) per
pixel clock.
So UYVY is straight forward. It's the YUV420, RGB, and RAW formats that
would be interesting to describe correctly.

regards
Philipp
