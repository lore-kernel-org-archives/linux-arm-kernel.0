From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 10 Mar 2017 22:55:16 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170310174228.3fe39100@vento.lan>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310130733.GU21222@n2100.armlinux.org.uk>
 <20170310122634.0ffda7c6@vento.lan>
 <20170310155708.GX21222@n2100.armlinux.org.uk>
 <20170310174228.3fe39100@vento.lan>
Message-ID: <20170310215515.GA6540@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Argh! that is indeed a bug at libv4l (and maybe at gstreamer).
> 
> I guess that the always_needs_conversion logic was meant to be used to
> really odd proprietary formats, e. g:
> 	
> /*  Vendor-specific formats   */
> #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> #define V4L2_PIX_FMT_WNVA     v4l2_fourcc('W', 'N', 'V', 'A') /* Winnov hw compress */
> #define V4L2_PIX_FMT_SN9C10X  v4l2_fourcc('S', '9', '1', '0') /* SN9C10x compression */
> ...
> 
> I suspect that nobody uses libv4l2 with MC-based V4L2 devices. That's
> likely why nobody reported this bug before (that I know of).
> 
> In any case, for non-proprietary formats, the default should be to
> always offer both the emulated format and the original one.
> 
> I suspect that the enclosed patch should fix the issue with bayer formats.

...
> @@ -178,7 +178,7 @@ struct v4lconvert_data *v4lconvert_create_with_dev_ops(int fd, void *dev_ops_pri
>  	/* This keeps tracks of devices which have only formats for which apps
>  	   most likely will need conversion and we can thus safely add software
>  	   processing controls without a performance impact. */
> -	int always_needs_conversion = 1;
> +	int always_needs_conversion = 0;
>  
>  	if (!data) {
>  		fprintf(stderr, "libv4lconvert: error: out of memory!\n");
> @@ -208,8 +208,8 @@ struct v4lconvert_data *v4lconvert_create_with_dev_ops(int fd, void *dev_ops_pri
>  		if (j < ARRAY_SIZE(supported_src_pixfmts)) {
>  			data->supported_src_formats |= 1ULL << j;
>  			v4lconvert_get_framesizes(data, fmt.pixelformat, j);
> -			if (!supported_src_pixfmts[j].needs_conversion)
> -				always_needs_conversion = 0;
> +			if (supported_src_pixfmts[j].needs_conversion)
> +				always_needs_conversion = 1;
>  		} else
>  			always_needs_conversion = 0;
>  	}

Is the else still needed? You changed default to 0...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/9f4e10d8/attachment-0001.sig>
