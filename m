From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 3 May 2018 12:09:09 +0300
Subject: [PATCH v6 05/17] media: rkisp1: add Rockchip ISP1 subdev driver
In-Reply-To: <20180308094807.9443-6-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-6-jacob-chen@iotwrt.com>
Message-ID: <20180503090909.o3dyhukzs2y7em5z@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On Thu, Mar 08, 2018 at 05:47:55PM +0800, Jacob Chen wrote:
> +static int rkisp1_isp_sd_s_power(struct v4l2_subdev *sd, int on)
> +{
> +	struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> +	int ret;
> +
> +	v4l2_dbg(1, rkisp1_debug, &isp_dev->v4l2_dev, "s_power: %d\n", on);
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(isp_dev->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		rkisp1_config_clk(isp_dev);
> +	} else {
> +		ret = pm_runtime_put(isp_dev->dev);

I commented this line out to make more than one STREAMON work. Otherwise, the 
second STREAMON hangs. I guess the bug is not this driver. Probably something 
in drivers/soc/rockchip/pm_domains.c. Just noting that in case you or someone 
on Cc would like to investigate it further.

I tested v4.16-rc4 on the Tinkerboard.

baruch

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
