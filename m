From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 27 Apr 2017 00:51:50 +0200
Subject: [patch] autogain support for bayer10 format (was Re: [patch]
 propagating controls in libv4l2)
In-Reply-To: <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
References: <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170426105300.GA857@amd>
 <20170426081330.6ca10e42@vento.lan> <20170426132337.GA6482@amd>
 <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
Message-ID: <20170426225150.GA4188@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>There are two separate things here:
> >>
> >>1) Autofoucs for a device that doesn't use subdev API
> >>2) libv4l2 support for devices that require MC and subdev API
> >
> >Actually there are three: 0) autogain. Unfortunately, I need autogain
> >first before autofocus has a chance...
> >
> >And that means... bayer10 support for autogain.
> >
> >Plus, I changed avg_lum to long long. Quick calculation tells me int
> >could overflow with few megapixel sensor.
> >
> >Oh, btw http://ytse.tricolour.net/docs/LowLightOptimization.html no
> >longer works.
> >
> >Regards,
> >								Pavel
> >
> >diff --git a/lib/libv4lconvert/processing/autogain.c b/lib/libv4lconvert/processing/autogain.c
> >index c6866d6..0b52d0f 100644
> >--- a/lib/libv4lconvert/processing/autogain.c
> >+++ b/lib/libv4lconvert/processing/autogain.c
> >@@ -68,6 +71,41 @@ static void autogain_adjust(struct v4l2_queryctrl *ctrl, int *value,
> > 	}
> > }
> >
> >+static int get_luminosity_bayer10(uint16_t *buf, const struct v4l2_format *fmt)
> >+{
> >+	long long avg_lum = 0;
> >+	int x, y;
> >+	
> >+	buf += fmt->fmt.pix.height * fmt->fmt.pix.bytesperline / 4 +
> >+		fmt->fmt.pix.width / 4;
> >+
> >+	for (y = 0; y < fmt->fmt.pix.height / 2; y++) {
> >+		for (x = 0; x < fmt->fmt.pix.width / 2; x++)
> 
> That would take some time :). AIUI, we have NEON support in ARM kernels
> (CONFIG_KERNEL_MODE_NEON), I wonder if it makes sense (me) to convert the
> above loop to NEON-optimized when it comes to it? Are there any drawbacks in
> using NEON code in kernel?

Well, thanks for offer. This is actualy libv4l2.

But I'd say NEON conversion is not neccessary anytime soon. First,
this is just trying to get average luminosity. We can easily skip
quite a lot of pixels, and still get reasonable answer.

Second, omap3isp actually has a hardware block computing statistics
for us. We just don't use it for simplicity.

(But if you want to play with camera, I'll get you patches; there's
ton of work to be done, both kernel and userspace :-).

Regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170427/664aa13a/attachment.sig>
