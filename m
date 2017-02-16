From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 13:44:23 +0000
Subject: [PATCH v4 18/36] media: Add i.MX media core driver
In-Reply-To: <1487250123.2377.53.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-19-git-send-email-steve_longerbeam@mentor.com>
 <1487250123.2377.53.camel@pengutronix.de>
Message-ID: <20170216134422.GO27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 02:02:03PM +0100, Philipp Zabel wrote:
> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> > +- imx-csi subdev is not being autoloaded as a kernel module, probably
> > +  because ipu_add_client_devices() does not register the IPU client
> > +  platform devices, but only allocates those devices.
> 
> As Russell points out, this is an issue with the ipu-v3 driver, which
> needs to be fixed to stop setting the ipu client devices' dev->of_node
> field.

>From my local testing (albiet the shambles that is bits of v4l2) setting
dev->of_node is not necessary for imx-drm - imx-drm comes up fine without.

Fixing _this_ code for that is not too difficult - it's a matter of:

	priv->sd.of_node = pdata->of_node;

in imx_csi_probe().  However, the difficult bit is the poor state of
code in v4l2, particularly the v4l2-async crap.  Right now, fixing the
module autoloading will oops the kernel, so it's best that module
autoloading remains broken for the time being.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
