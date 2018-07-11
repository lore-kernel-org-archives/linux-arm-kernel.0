From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 13:12:30 +0200
Subject: [PATCH v10 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20180705154802.03604f156709be11892b19c0@magewell.com>
References: <1525417745-37964-1-git-send-email-yong.deng@magewell.com>
 <20180626110821.wkal6fcnoncsze6y@valkosipuli.retiisi.org.uk>
 <20180705154802.03604f156709be11892b19c0@magewell.com>
Message-ID: <20180711111230.gpv7ww2nhaha5hou@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Thu, Jul 05, 2018 at 03:48:02PM +0800, Yong wrote:
> > > +
> > > +/* -----------------------------------------------------------------------------
> > > + * Media Operations
> > > + */
> > > +static int sun6i_video_formats_init(struct sun6i_video *video,
> > > +				    const struct media_pad *remote)
> > > +{
> > > +	struct v4l2_subdev_mbus_code_enum mbus_code = { 0 };
> > > +	struct sun6i_csi *csi = video->csi;
> > > +	struct v4l2_format format;
> > > +	struct v4l2_subdev *subdev;
> > > +	u32 pad;
> > > +	const u32 *pixformats;
> > > +	int pixformat_count = 0;
> > > +	u32 subdev_codes[32]; /* subdev format codes, 32 should be enough */
> > > +	int codes_count = 0;
> > > +	int num_fmts = 0;
> > > +	int i, j;
> > > +
> > > +	pad = remote->index;
> > > +	subdev = media_entity_to_v4l2_subdev(remote->entity);
> > > +	if (subdev == NULL)
> > > +		return -ENXIO;
> > > +
> > > +	/* Get supported pixformats of CSI */
> > > +	pixformat_count = sun6i_csi_get_supported_pixformats(csi, &pixformats);
> > > +	if (pixformat_count <= 0)
> > > +		return -ENXIO;
> > > +
> > > +	/* Get subdev formats codes */
> > > +	mbus_code.pad = pad;
> > > +	mbus_code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > > +	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code, NULL,
> > > +				 &mbus_code)) {
> > 
> > The formats supported by the external sub-device may depend on horizontal
> > and vertical flipping. You shouldn't assume any particular configuration
> > here: instead, bridge drivers generally just need to make sure the formats
> > match in link validation when streaming is started. At least the CSI-2
> > receiver driver and the DMA engine driver (video device) should check the
> > configuration is valid. See e.g. the IPU3 driver:
> > drivers/media/pci/intel/ipu3/ipu3-cio2.c .
> 
> Can mbus_code be added dynamically ?
> The code here only enum the mbus code and get the possible supported
> pairs of pixformat and mbus by SoC. Not try to check if the formats
> (width height ...) is valid or not. The formats validation will be 
> in link validation when streaming is started as per your advise. 

Can you reply to this so that Yong has a chance to resubmit his serie
before the 4.19 merge window starts?

Or alternatively, is this something we can fix later on, once it's
merged?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/705b024f/attachment.sig>
