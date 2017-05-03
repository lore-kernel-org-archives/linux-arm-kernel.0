From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 May 2017 21:58:29 +0200
Subject: [patch] autogain support for bayer10 format (was Re: [patch]
 propagating controls in libv4l2)
In-Reply-To: <20170503190556.GT23750@n2100.armlinux.org.uk>
References: <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170426105300.GA857@amd>
 <20170426081330.6ca10e42@vento.lan> <20170426132337.GA6482@amd>
 <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
 <20170503190556.GT23750@n2100.armlinux.org.uk>
Message-ID: <20170503195829.GA17315@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-05-03 20:05:56, Russell King - ARM Linux wrote:
> On Wed, Apr 26, 2017 at 06:43:54PM +0300, Ivaylo Dimitrov wrote:
> > >+static int get_luminosity_bayer10(uint16_t *buf, const struct v4l2_format *fmt)
> > >+{
> > >+	long long avg_lum = 0;
> > >+	int x, y;
> > >+	
> > >+	buf += fmt->fmt.pix.height * fmt->fmt.pix.bytesperline / 4 +
> > >+		fmt->fmt.pix.width / 4;
> > >+
> > >+	for (y = 0; y < fmt->fmt.pix.height / 2; y++) {
> > >+		for (x = 0; x < fmt->fmt.pix.width / 2; x++)
> > 
> > That would take some time :). AIUI, we have NEON support in ARM kernels
> > (CONFIG_KERNEL_MODE_NEON), I wonder if it makes sense (me) to convert the
> > above loop to NEON-optimized when it comes to it? Are there any drawbacks in
> > using NEON code in kernel?
> 
> Using neon without the VFP state saved and restored corrupts userspace's
> FP state.  So, you have to save the entire VFP state to use neon in kernel
> mode.  There are helper functions for this: kernel_neon_begin() and
> kernel_neon_end().
...
> Given that, do we really want to be walking over multi-megabytes of image
> data in the kernel with preemption disabled - it sounds like a recipe for
> a very sluggish system.  I think this should (and can only sensibly be
> done) in userspace.

The patch was for libv4l2. (And I explained why we don't need to
overoptimize this.)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170503/e1091649/attachment.sig>
