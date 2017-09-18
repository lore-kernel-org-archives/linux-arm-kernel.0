From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Mon, 18 Sep 2017 10:36:28 +0300
Subject: [PATCH v4 2/3] media: ov7670: Add the get_fmt callback
In-Reply-To: <20170918064514.6841-3-wenyou.yang@microchip.com>
References: <20170918064514.6841-1-wenyou.yang@microchip.com>
 <20170918064514.6841-3-wenyou.yang@microchip.com>
Message-ID: <20170918073628.nwjdyfdk7hvsetfb@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

On Mon, Sep 18, 2017 at 02:45:13PM +0800, Wenyou Yang wrote:
> @@ -998,8 +1002,15 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
>  		ret = ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
>  		if (ret)
>  			return ret;
> -		cfg->try_fmt = format->format;
> +#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> +		struct v4l2_mbus_framefmt *mbus_fmt;

This will emit a compiler warning at least.

> +
> +		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
> +		*mbus_fmt = format->format;
>  		return 0;
> +#else
> +		return -ENOTTY;
> +#endif
>  	}
>  
>  	ret = ov7670_try_fmt_internal(sd, &format->format, &ovfmt, &wsize);

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
