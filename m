From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 31 May 2017 21:58:21 +0200
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170531195821.GA16962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +/* min/typical/max system clock (xclk) frequencies */
> +#define OV5640_XCLK_MIN  6000000
> +#define OV5640_XCLK_MAX 24000000
> +
> +/*
> + * FIXME: there is no subdev API to set the MIPI CSI-2
> + * virtual channel yet, so this is hardcoded for now.
> + */
> +#define OV5640_MIPI_VC	1

Can the FIXME be fixed?

> +/*
> + * image size under 1280 * 960 are SUBSAMPLING

-> Image

> + * image size upper 1280 * 960 are SCALING

above?

> +/*
> + * FIXME: all of these register tables are likely filled with
> + * entries that set the register to their power-on default values,
> + * and which are otherwise not touched by this driver. Those entries
> + * should be identified and removed to speed register load time
> + * over i2c.
> + */

load->loading? Can the FIXME be fixed?

> +	/* Auto/manual exposure */
> +	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> +						 V4L2_CID_EXPOSURE_AUTO,
> +						 V4L2_EXPOSURE_MANUAL, 0,
> +						 V4L2_EXPOSURE_AUTO);
> +	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> +					    V4L2_CID_EXPOSURE_ABSOLUTE,
> +					    0, 65535, 1, 0);

Is exposure_absolute supposed to be in microseconds...?


> +	/* Auto/manual gain */
> +	ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTOGAIN,
> +					     0, 1, 1, 1);
> +	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN,
> +					0, 1023, 1, 0);
> +
> +	ctrls->saturation = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_SATURATION,
> +					      0, 255, 1, 64);
> +	ctrls->hue = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HUE,
> +				       0, 359, 1, 0);
> +	ctrls->contrast = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_CONTRAST,
> +					    0, 255, 1, 0);
> +	ctrls->test_pattern =
> +		v4l2_ctrl_new_std_menu_items(hdl, ops, V4L2_CID_TEST_PATTERN,
> +					     ARRAY_SIZE(test_pattern_menu) - 1,
> +					     0, 0, test_pattern_menu);
> +

It is good to see sensor that has autogain/etc. I'm emulating them in
v4l-utils, and hardware that supports it is a good argument. 

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170531/4a85ce8e/attachment.sig>
