From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 12 Oct 2017 07:41:34 +0800
Subject: [arm:csi-v6 4/10] drivers/media//i2c/imx219.c:2046:16: warning:
 logical not is only applied to the left hand side of comparison
Message-ID: <201710120732.bmFcxcs5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git csi-v6
head:   3cde32460e243fb799a9174900da2e27beb0b0b9
commit: e3f847cd37b007d55b76282414bfcf13abb8fc9a [4/10] media: i2c: imx219 camera driver
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e3f847cd37b007d55b76282414bfcf13abb8fc9a
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   drivers/media//i2c/imx219.c: In function 'imx219_set_fmt':
>> drivers/media//i2c/imx219.c:2046:16: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]
     if (!fmt->pad < sd->entity.num_pads) {
                   ^
>> drivers/media//i2c/imx219.c:2082:5: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (ret == 0) {
        ^

vim +2046 drivers/media//i2c/imx219.c

  2019	
  2020	static int imx219_set_fmt(struct v4l2_subdev *sd,
  2021				  struct v4l2_subdev_pad_config *cfg,
  2022				  struct v4l2_subdev_format *fmt)
  2023	{
  2024		struct imx219_private *priv = imx219_get_priv(sd);
  2025		struct imx219_sub *sub = imx219_get_sub(sd);
  2026		struct v4l2_mbus_framefmt *pad_fmt, *other_fmt;
  2027		struct v4l2_rect *pad_crop, *other_rect, fmtr, crop, compose;
  2028		struct v4l2_rect *rect[4] = {
  2029			&fmtr,
  2030			&crop,
  2031			&compose,
  2032			&compose,
  2033		};
  2034		struct v4l2_rect *pad_compose;
  2035		int ret;
  2036	
  2037		if (!sub->pad_ops->adj_format)
  2038			return -ENOTTY;
  2039	
  2040		pad_compose = imx219_get_pad_compose(sd, cfg, fmt->which, fmt->pad);
  2041		pad_crop = imx219_get_pad_crop(sd, cfg, fmt->which, fmt->pad);
  2042		pad_fmt = imx219_get_pad_fmt(sd, cfg, fmt->which, fmt->pad);
  2043		if (!pad_fmt)
  2044			return -EINVAL;
  2045	
> 2046		if (!fmt->pad < sd->entity.num_pads) {
  2047			other_fmt = imx219_get_pad_fmt(sd, cfg, fmt->which, !fmt->pad);
  2048			other_rect = imx219_get_pad_compose(sd, cfg, fmt->which, !fmt->pad);
  2049		} else {
  2050			other_fmt = NULL;
  2051			other_rect = NULL;
  2052		}
  2053	
  2054		mutex_lock(&priv->mutex);
  2055	
  2056		/* Sink pads never have to consider their sources, enforce that. */
  2057		if (fmt->pad == PAD_SINK)
  2058			sub->pad_ops->adj_format(priv, fmt, NULL, NULL);
  2059		else
  2060			sub->pad_ops->adj_format(priv, fmt, other_fmt, other_rect);
  2061	
  2062		/* Setting the format sets the crop to the same size, located at 0,0 */
  2063		imx219_framefmt_to_rect(&fmtr, &fmt->format);
  2064		compose = crop = fmtr;
  2065		if (sub->pad_ops->adj_selection) {
  2066			sub->pad_ops->adj_selection(priv, V4L2_SEL_TGT_CROP, 0,
  2067						    &crop, rect + 1);
  2068			sub->pad_ops->adj_selection(priv, V4L2_SEL_TGT_COMPOSE, 0,
  2069						    &compose, rect + 2);
  2070		}
  2071	
  2072		if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
  2073			ret = sub->pad_ops->set_fmt(priv, sub, fmt->pad, &crop,
  2074						    &fmt->format);
  2075	
  2076			/* Propagate to source pad if setting sink pad */
  2077			if (ret == 0 && fmt->pad == PAD_SINK)
  2078				ret = sub->pad_ops->set_fmt(priv, sub, PAD_SRC, NULL,
  2079							    &fmt->format);
  2080		}
  2081	
> 2082		if (ret == 0) {
  2083			*pad_fmt = fmt->format;
  2084	
  2085			/*
  2086			 * Setting the sink pad sets the sink crop and compose
  2087			 * rectangles, and propagates the format to the source pad
  2088			 */
  2089			if (fmt->pad == PAD_SINK) {
  2090				if (pad_crop)
  2091					*pad_crop = crop;
  2092				if (pad_compose)
  2093					*pad_compose = compose;
  2094				if (other_fmt) {
  2095					*other_fmt = fmt->format;
  2096					other_fmt->width = compose.width;
  2097					other_fmt->height = compose.height;
  2098				}
  2099			}
  2100		}
  2101		mutex_unlock(&priv->mutex);
  2102	
  2103		return ret;
  2104	}
  2105	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46067 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171012/af3222f3/attachment-0001.gz>
