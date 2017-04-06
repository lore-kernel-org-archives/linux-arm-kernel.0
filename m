From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Apr 2017 16:10:33 +0100
Subject: [PATCH] [media] imx: csi: retain current field order and
 colorimetry setting as default
In-Reply-To: <1491490912.2392.74.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-22-git-send-email-steve_longerbeam@mentor.com>
 <1491486929.2392.29.camel@pengutronix.de>
 <20170406140533.GF17774@n2100.armlinux.org.uk>
 <1491490912.2392.74.camel@pengutronix.de>
Message-ID: <20170406151032.GH17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 05:01:52PM +0200, Philipp Zabel wrote:
> On Thu, 2017-04-06 at 15:05 +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 06, 2017 at 03:55:29PM +0200, Philipp Zabel wrote:
> > > +
> > > +	/* Retain current field setting as default */
> > > +	if (sdformat->format.field == V4L2_FIELD_ANY)
> > > +		sdformat->format.field = fmt->field;
> > > +
> > > +	/* Retain current colorspace setting as default */
> > > +	if (sdformat->format.colorspace == V4L2_COLORSPACE_DEFAULT) {
> > > +		sdformat->format.colorspace = fmt->colorspace;
> > > +		if (sdformat->format.xfer_func == V4L2_XFER_FUNC_DEFAULT)
> > > +			sdformat->format.xfer_func = fmt->xfer_func;
> > > +		if (sdformat->format.ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT)
> > > +			sdformat->format.ycbcr_enc = fmt->ycbcr_enc;
> > > +		if (sdformat->format.quantization == V4L2_QUANTIZATION_DEFAULT)
> > > +			sdformat->format.quantization = fmt->quantization;
> > > +	} else {
> > > +		if (sdformat->format.xfer_func == V4L2_XFER_FUNC_DEFAULT) {
> > > +			sdformat->format.xfer_func =
> > > +				V4L2_MAP_XFER_FUNC_DEFAULT(
> > > +						sdformat->format.colorspace);
> > > +		}
> > > +		if (sdformat->format.ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT) {
> > > +			sdformat->format.ycbcr_enc =
> > > +				V4L2_MAP_YCBCR_ENC_DEFAULT(
> > > +						sdformat->format.colorspace);
> > > +		}
> > > +		if (sdformat->format.quantization == V4L2_QUANTIZATION_DEFAULT) {
> > > +			sdformat->format.quantization =
> > > +				V4L2_MAP_QUANTIZATION_DEFAULT(
> > > +						cc->cs != IPUV3_COLORSPACE_YUV,
> > > +						sdformat->format.colorspace,
> > > +						sdformat->format.ycbcr_enc);
> > > +		}
> > > +	}
> > 
> > Would it make sense for this to be a helper function?
> 
> Quite possible, the next subdev that has to set frame_interval on both
> pads manually because its upstream source pad doesn't suport
> frame_interval might want to do the same.

Hmm.  I'm not sure I agree with this approach.  If a subdev hardware
does not support any modification of the colourspace or field, then
it should not be modifyable at the source pad - it should retain the
propagated settings from the sink pad.

I thought I had already sent a patch doing exactly that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
