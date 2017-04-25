From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Apr 2017 13:23:10 +0200
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <20170424225731.7532e368@vento.lan>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424220701.GA27846@amd>
 <20170424225731.7532e368@vento.lan>
Message-ID: <20170425112310.GA7926@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Umm, and it looks like libv4l can not automatically convert from
> > GRBG10.. and if it could, going through RGB24 would probably be too
> > slow on this device :-(.
> 
> I suspect it shouldn't be hard to add support for GRBG10. It already
> supports 8 and 16 bits Bayer formats, at lib/libv4lconvert/bayer.c
> (to both RGB and YUV formats).

Proper format for 16 bit bayer would be tricky, AFAICT. Anyway, does
this look reasonable? It does not work too well here, since omap3isp
driver does not seem to support ENUM_FMT. (And I get just half of the
vertical image, strange. Interlacing?)

Best regards,
								Pavel

diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
index d3d8936..2a469b2 100644
--- a/lib/libv4lconvert/libv4lconvert.c
+++ b/lib/libv4lconvert/libv4lconvert.c
@@ -123,6 +126,8 @@ static const struct v4lconvert_pixfmt supported_src_pixfmts[] = {
 	{ V4L2_PIX_FMT_SGRBG8,		 8,	 8,	 8,	1 },
 	{ V4L2_PIX_FMT_SRGGB8,		 8,	 8,	 8,	1 },
 	{ V4L2_PIX_FMT_STV0680,		 8,	 8,	 8,	1 },
+
+	{ V4L2_PIX_FMT_SGRBG10,		16,	 8,	 8,	1 },
 	/* compressed bayer */
 	{ V4L2_PIX_FMT_SPCA561,		 0,	 9,	 9,	1 },
 	{ V4L2_PIX_FMT_SN9C10X,		 0,	 9,	 9,	1 },
@@ -668,6 +680,7 @@ static int v4lconvert_processing_needs_double_conversion(
 	case V4L2_PIX_FMT_SGRBG8:
 	case V4L2_PIX_FMT_SRGGB8:
 	case V4L2_PIX_FMT_STV0680:
+	case V4L2_PIX_FMT_SGRBG10:
 		return 0;
 	}
 	switch (dest_pix_fmt) {
@@ -694,6 +707,17 @@ unsigned char *v4lconvert_alloc_buffer(int needed,
 	return *buf;
 }
 
+static void v4lconvert_10to8(void *_src, unsigned char *dst, int width, int height)
+{
+	int i;
+	uint16_t *src = _src;
+	
+	printf("sizes %d x %d\n", width, height);
+	for (i=0; i<width*height; i++) {
+		dst[i] = src[i] >> 2;
+	}
+}
+
 int v4lconvert_oom_error(struct v4lconvert_data *data)
 {
 	V4LCONVERT_ERR("could not allocate memory\n");
@@ -867,7 +893,8 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
 #endif
 	case V4L2_PIX_FMT_SN9C2028:
 	case V4L2_PIX_FMT_SQ905C:
-	case V4L2_PIX_FMT_STV0680: { /* Not compressed but needs some shuffling */
+	case V4L2_PIX_FMT_STV0680:
+	case V4L2_PIX_FMT_SGRBG10: { /* Not compressed but needs some shuffling */
 		unsigned char *tmpbuf;
 		struct v4l2_format tmpfmt = *fmt;
 
@@ -877,6 +904,11 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
 			return v4lconvert_oom_error(data);
 
 		switch (src_pix_fmt) {
+		case V4L2_PIX_FMT_SGRBG10:
+			v4lconvert_10to8(src, tmpbuf, width, height);
+
+			tmpfmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SGRBG8;
+			break;
 		case V4L2_PIX_FMT_SPCA561:
 			v4lconvert_decode_spca561(src, tmpbuf, width, height);
 			tmpfmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SGBRG8;
@@ -949,6 +981,7 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
 			V4LCONVERT_ERR("short raw bayer data frame\n");
 			errno = EPIPE;
 			result = -1;
+			/* FIXME: but then we proceed anyway?! */
 		}
 		switch (dest_pix_fmt) {
 		case V4L2_PIX_FMT_RGB24:




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/a03b799f/attachment-0001.sig>
