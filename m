From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2015 10:23:33 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1442474516.6617.6.camel@pengutronix.de>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
 <m3a8su4llv.fsf@t19.piap.pl>
 <20150910104930.GI21084@n2100.arm.linux.org.uk>
 <1442474516.6617.6.camel@pengutronix.de>
Message-ID: <20150917092333.GK21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 09:21:56AM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 10.09.2015, 11:49 +0100 schrieb Russell King - ARM
> Linux:
> > On Thu, Sep 10, 2015 at 12:25:32PM +0200, Krzysztof Ha?asa wrote:
> > > The Y plane is ok, but the Xv window is green, like on old monochrome
> > > CRTs - what could that be? It looks like the UV planes are all wrong.
> > 
> > From a quick read of the imx-drm ipuv3-plane code, it looks like it
> > doesn't bother with the U/V planes for planar images.  Nothing looks
> > at fb->offsets[1,2] nor fb->pitches[1,2].  However, it claims to
> > support DRM_FORMAT_YUV420 and DRM_FORMAT_YVU420 formats - which is
> > wrong if it doesn't look at these other offsets and pitches.
> 
> The IDMAC has a few funny restrictions for multiplanar formats, and the
> current code silently assumes that the U and V planes follow right after
> Y.
> 
> I have a patch to enforce the same base address:
> http://lists.freedesktop.org/archives/dri-devel/2015-August/089293.html
> but it still doesn't check the offset/pitch limitations properly.

	int planes = drm_format_num_planes(fb->pixel_format);
	dma_addr_t base, end;

	for (i = 0; i < planes; i++) {
		cma_obj[i] = drm_fb_cma_get_gem_obj(fb, i);
		if (!cma_obj[i]) {
			DRM_DEBUG_KMS("plane %d entry is null.\n", i);
			return -EINVAL;
		}
	}

EFAULT is not appropriate there - EFAULT means "userspace passed a bad
address into kernel space".  That's not what you're trying to convey
there, so EINVAL or some other error code more suited to the error
condition would be more appropriate.

	base = cma_obj[0]->paddr + fb->offsets[0];
	end = base + fb->pitches[0] * fb->height;
	eba = base + fb->pitches[0] * y + (fb->bits_per_pixel >> 3) * x;

	for (i = 1; i < planes; i++) {
		dma_addr_t this_base;

		if (y || x) {
			DRM_DEBUG_KMS("can't support planar with offset\n");
			return -EINVAL;
		}

		this_base = cma_obj[i]->paddr + fb->offsets[i];
		if (this_base != end) {
			DRM_DEBUG_KMS("plane does follow previous.\n");
			return -EINVAL;
		}

		end += fb->pitches[i] * fb->height;
	}

should do the trick.  Note that if x or y is non-zero, it's specifying
an offset into the image, which means that there _will_ be a gap
between the planes (consisting of the undisplayed portion of the plane.)
As you said they need to be contiguous, they aren't contiguous in this
situation, so we have to error that out if there's more than one plane.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
