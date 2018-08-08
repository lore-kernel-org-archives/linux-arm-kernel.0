From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 08 Aug 2018 11:28:55 +0200
Subject: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <130e4f08534d0dfbd26f97f9b95d533ce86ceada.camel@bootlin.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
 <faa0436aad809ca562b5c152420b1e4d4b6f507b.camel@collabora.com>
 <130e4f08534d0dfbd26f97f9b95d533ce86ceada.camel@bootlin.com>
Message-ID: <d807ea19fa4fbbab81d6580399d406f351ac324e.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-08-06 at 16:21 +0200, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri, 2018-08-03 at 17:49 -0300, Ezequiel Garcia wrote:
> > On Wed, 2018-07-25 at 12:02 +0200, Paul Kocialkowski wrote:
> > > This introduces the Cedrus VPU driver that supports the VPU found in
> > > Allwinner SoCs, also known as Video Engine. It is implemented through
> > > a v4l2 m2m decoder device and a media device (used for media requests).
> > > So far, it only supports MPEG2 decoding.
> > > 
> > > Since this VPU is stateless, synchronization with media requests is
> > > required in order to ensure consistency between frame headers that
> > > contain metadata about the frame to process and the raw slice data that
> > > is used to generate the frame.
> > > 
> > > This driver was made possible thanks to the long-standing effort
> > > carried out by the linux-sunxi community in the interest of reverse
> > > engineering, documenting and implementing support for Allwinner VPU.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> > [..]
> > > +static int cedrus_probe(struct platform_device *pdev)
> > > +{
> > > +	struct cedrus_dev *dev;
> > > +	struct video_device *vfd;
> > > +	int ret;
> > > +
> > > +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> > > +	if (!dev)
> > > +		return -ENOMEM;
> > > +
> > > +	dev->dev = &pdev->dev;
> > > +	dev->pdev = pdev;
> > > +
> > > +	ret = cedrus_hw_probe(dev);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to probe hardware\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	dev->dec_ops[CEDRUS_CODEC_MPEG2] = &cedrus_dec_ops_mpeg2;
> > > +
> > > +	mutex_init(&dev->dev_mutex);
> > > +	spin_lock_init(&dev->irq_lock);
> > > +
> > 
> > A minor thing.
> > 
> > I believe this spinlock is not needed. All the data structures
> > it's accessing are already protected, and some operations
> > (stop_streaming) are guaranteed to not run at the same
> > time as a job.
> 
> I think we were afraid of this kind of scenario happening, but
> everything seems to indicate that these data structures are already
> properly protected by the core, as you're suggesting.
> 
> Removing the lock does not cause any noticeable issue at first try, but
> I'd like to test decoding for a few hours in a row to reduce the
> probability of missing a corner case that our lock was preventing.

After testing for several hours in a row, I got some cases of CPU stall
which did not happen with the driver lock. So it seems safer to keep the
lock around for now and maybe revisit this later, when there is time to
investigate why it is needed.

Cheers,

Paul

> If that goes well, I guess we can remove it from our driver.
> 
> Cheers,
> 
> Paul
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/72645cb0/attachment.sig>
