From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Fri, 03 Aug 2018 17:49:38 -0300
Subject: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
Message-ID: <faa0436aad809ca562b5c152420b1e4d4b6f507b.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-25 at 12:02 +0200, Paul Kocialkowski wrote:
> This introduces the Cedrus VPU driver that supports the VPU found in
> Allwinner SoCs, also known as Video Engine. It is implemented through
> a v4l2 m2m decoder device and a media device (used for media requests).
> So far, it only supports MPEG2 decoding.
> 
> Since this VPU is stateless, synchronization with media requests is
> required in order to ensure consistency between frame headers that
> contain metadata about the frame to process and the raw slice data that
> is used to generate the frame.
> 
> This driver was made possible thanks to the long-standing effort
> carried out by the linux-sunxi community in the interest of reverse
> engineering, documenting and implementing support for Allwinner VPU.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
[..]
> +static int cedrus_probe(struct platform_device *pdev)
> +{
> +	struct cedrus_dev *dev;
> +	struct video_device *vfd;
> +	int ret;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->dev = &pdev->dev;
> +	dev->pdev = pdev;
> +
> +	ret = cedrus_hw_probe(dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to probe hardware\n");
> +		return ret;
> +	}
> +
> +	dev->dec_ops[CEDRUS_CODEC_MPEG2] = &cedrus_dec_ops_mpeg2;
> +
> +	mutex_init(&dev->dev_mutex);
> +	spin_lock_init(&dev->irq_lock);
> +

A minor thing.

I believe this spinlock is not needed. All the data structures
it's accessing are already protected, and some operations
(stop_streaming) are guaranteed to not run at the same
time as a job.

Regards,
Eze
