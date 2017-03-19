From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 18:51:33 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <6e2879a0-1f2e-9da7-b7e1-d134a0301ca2@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319121402.GS21222@n2100.armlinux.org.uk>
 <6e2879a0-1f2e-9da7-b7e1-d134a0301ca2@gmail.com>
Message-ID: <20170319185132.GY21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 11:37:15AM -0700, Steve Longerbeam wrote:
> On 03/19/2017 05:14 AM, Russell King - ARM Linux wrote:
> >Right now, CSI doesn't do that - it only looks at the width, height,
> >code, and field.
> 
> Correct, there is currently no propagation of the colorimetry
> parameters (colorspace, ycbcr_enc, quantization, and xfer_func).
> For the most part, those are just ignored ATM. Philipp Zabel did
> do some work earlier to start propagating those, but that's still
> TODO.


> 
> >
> >I think we've got other bugs though that haven't been picked up by any
> >review - csi_try_fmt() adjusts the format using the _current_
> >configuration of the sink pad, even when using V4L2_SUBDEV_FORMAT_TRY.
> >This seems wrong according to the docs: the purpose of the try
> >mechanism is to be able to setup the _entire_ pipeline using the TRY
> >mechanism to work out whether the configuration works, before then
> >setting for real.  If we're validating the TRY formats against the
> >live configuration, then we're not doing that.
> 
> I don't believe that is correct. csi_try_fmt() for the source pads calls
> __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sdformat->which) to get
> the sink format, and for the TRY trial-run from csi_set_fmt(),
> sdformat->which will be set to TRY, so the returned sink format
> is the TRY format.

Look at csi_try_fmt() - it validates the source pad against
priv->crop, which is the actively live cropping rectangle, not the
one which has been configured for the TRY trial-run.

Also, as I mention elsewhere, I believe the way we're doing scaling
is completely wrong...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
