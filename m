From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 13 Jul 2018 10:40:58 +0200
Subject: [PATCH v5 18/22] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <e31090c371ae7f7999b0aa983a20f33451cc89fb.camel@collabora.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-19-paul.kocialkowski@bootlin.com>
 <e31090c371ae7f7999b0aa983a20f33451cc89fb.camel@collabora.com>
Message-ID: <2a64aec733392cd15d87b53a268fb8328af0a82c.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-07-10 at 16:57 -0300, Ezequiel Garcia wrote:
> Hey Paul,
> 
> My comments on v4 of course apply here as well.

Yes, it seems that most of your comments were not already adressed by
this v5. I will answer your remarks and suggestions on the v4 thread.

> One other thing...
> 
> On Tue, 2018-07-10 at 10:01 +0200, Paul Kocialkowski wrote:
> > This introduces the Sunxi-Cedrus VPU driver that supports the VPU
> > found
> > in Allwinner SoCs, also known as Video Engine. It is implemented
> > through
> > a v4l2 m2m decoder device and a media device (used for media
> > requests).
> > So far, it only supports MPEG2 decoding.
> > 
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data
> > that
> > is used to generate the frame.
> > 
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for Allwinner VPU.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> 
> [..]
> > +
> > +static irqreturn_t cedrus_bh(int irq, void *data)
> > +{
> > +	struct cedrus_dev *dev = data;
> > +	struct cedrus_ctx *ctx;
> > +
> > +	ctx = v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > +	if (!ctx) {
> > +		v4l2_err(&dev->v4l2_dev,
> > +			 "Instance released before the end of
> > transaction\n");
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	v4l2_m2m_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx);
> > +
> 
> I don't like the fact that v4l2_m2m_job_finish calls .device_run
> reentrantly. Let me try to make v4l2_m2m_job_finish() safe to be called
> in atomic context, so hopefully drivers can just call it in the top-
> half.

Thanks for your patches in this direction, I will try them and hopefully
base our next Sunxi-Cedrus version on them, if it seems that this
framework change will be picked-up by maintainers.

> You are returning the buffers in the top-half, so this is just a matter
> or better design, not a performance improvement.

This is definitely a nice design improvement IMO (if not only for
avoiding reentrancy)! 

And this reduces our code path between starting decoding and userspace
notification that decoding finished. Starting the worker thread is no
longer required before notifying userspace, so I think we are going to
see performance improvements from this. Hopefully, the worker thread
will run while userspace is busy preparing the next frame, so this
should work a lot better for us!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180713/2680b4da/attachment-0001.sig>
