From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 25 Jun 2018 15:48:48 +0200
Subject: [PATCH 6/9] media: cedrus: Add ops structure
In-Reply-To: <20180625132933.tzr36vsucqsq3mmb@flea>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-7-maxime.ripard@bootlin.com>
 <939381a854760b1d54984ae0f534ec03312ec8e0.camel@bootlin.com>
 <20180625132933.tzr36vsucqsq3mmb@flea>
Message-ID: <0d20a3159ea710f47d1860a83b7c027116e8e97c.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-06-25 at 15:29 +0200, Maxime Ripard wrote:
> Hi!
> 
> On Thu, Jun 21, 2018 at 11:49:54AM +0200, Paul Kocialkowski wrote:
> > Hi,
> > 
> > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > In order to increase the number of codecs supported, we need to decouple
> > > the MPEG2 only code that was there up until now and turn it into something
> > > a bit more generic.
> > > 
> > > Do that by introducing an intermediate ops structure that would need to be
> > > filled by each supported codec. Start by implementing in that structure the
> > > setup and trigger hooks that are currently the only functions being
> > > implemented by codecs support.
> > > 
> > > To do so, we need to store the current codec in use, which we do at
> > > start_streaming time.
> > 
> > With the comments below taken in account, this is:
> > 
> > Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Thanks!
> 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >  .../platform/sunxi/cedrus/sunxi_cedrus.c      |  2 ++
> > >  .../sunxi/cedrus/sunxi_cedrus_common.h        | 11 +++++++
> > >  .../platform/sunxi/cedrus/sunxi_cedrus_dec.c  | 10 +++---
> > >  .../sunxi/cedrus/sunxi_cedrus_mpeg2.c         | 11 +++++--
> > >  .../sunxi/cedrus/sunxi_cedrus_mpeg2.h         | 33 -------------------
> > >  .../sunxi/cedrus/sunxi_cedrus_video.c         | 17 +++++++++-
> > >  6 files changed, 42 insertions(+), 42 deletions(-)
> > >  delete mode 100644 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h
> > > 
> > > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus.c
> > > index ccd41d9a3e41..bc80480f5dfd 100644
> > > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus.c
> > > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus.c
> > > @@ -244,6 +244,8 @@ static int sunxi_cedrus_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	dev->dec_ops[SUNXI_CEDRUS_CODEC_MPEG2] = &sunxi_cedrus_dec_ops_mpeg2;
> > > +
> > >  	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > >  	if (ret)
> > >  		goto unreg_media;
> > > diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > index a5f83c452006..c2e2c92d103b 100644
> > > --- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > +++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_common.h
> > > @@ -75,6 +75,7 @@ struct sunxi_cedrus_ctx {
> > >  	struct v4l2_pix_format_mplane src_fmt;
> > >  	struct sunxi_cedrus_fmt *vpu_dst_fmt;
> > >  	struct v4l2_pix_format_mplane dst_fmt;
> > > +	enum sunxi_cedrus_codec current_codec;
> > 
> > Nit: for consistency with the way things are named, "codec_current"
> > probably makes more sense.
> 
> I'm not quite sure what you mean by consitency here. This structure
> has 5 other variables with two words: vpu_src_fmt, src_fmt,
> vpu_dst_fmt, dst_fmt and dst_bufs. codec_current would be going
> against the consistency of that structure.

Mhh, not sure what I meant after all regarding consistency. I was
thinking in terms of name/qualifier, but it's clear that the structure
for the names of already-existing elements has qualifiers first and name
at the end, so "curent_codec" indeed fits best.

Sorry for the noise!

> > IMO using the natural English order is fine for temporary variables, but
> >  less so for variables used in common parts like structures. This allows
> > seeing "_" as a logical hierarchical delimiter that automatically makes
> > us end up with consistent prefixes that can easily be grepped for and
> > derived.
> > 
> > But that's just my 2 cents, it's really not a big deal, especially in
> > this case!
> > 
> > >  	struct v4l2_ctrl_handler hdl;
> > >  	struct v4l2_ctrl *ctrls[SUNXI_CEDRUS_CTRL_MAX];
> > > @@ -107,6 +108,14 @@ struct sunxi_cedrus_buffer *vb2_to_cedrus_buffer(const struct vb2_buffer *p)
> > >  	return vb2_v4l2_to_cedrus_buffer(to_vb2_v4l2_buffer(p));
> > >  }
> > >  
> > > +struct sunxi_cedrus_dec_ops {
> > > +	void (*setup)(struct sunxi_cedrus_ctx *ctx,
> > > +		      struct sunxi_cedrus_run *run);
> > > +	void (*trigger)(struct sunxi_cedrus_ctx *ctx);
> > 
> > By the way, are we sure that these functions won't ever fail?
> > I think this is the case for MPEG2 (there is virtually nothing to check
> > for errors) but perhaps it's different for H264.
> 
> It won't fail either, and if we need to change it somewhere down the
> line, it's quite easy to do.

Right, let's keep it that way then.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/d387e14f/attachment-0001.sig>
