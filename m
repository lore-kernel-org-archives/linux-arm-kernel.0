From: lkp@intel.com (kbuild test robot)
Date: Mon, 18 Sep 2017 11:57:17 +0800
Subject: [PATCH v3 2/3] media: ov7670: Add the get_fmt callback
In-Reply-To: <20170918012928.13278-3-wenyou.yang@microchip.com>
Message-ID: <201709181122.hBgnvQmw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.14-rc1 next-20170915]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/media-ov7670-Add-entity-init-and-power-operation/20170918-093913
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-x009-09180108 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/media//i2c/ov7670.c: In function 'ov7670_set_fmt':
>> drivers/media//i2c/ov7670.c:1004:14: error: implicit declaration of function 'v4l2_subdev_get_try_format' [-Werror=implicit-function-declaration]
      mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media//i2c/ov7670.c:1004:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
               ^
   drivers/media//i2c/ov7670.c: In function 'ov7670_get_fmt':
   drivers/media//i2c/ov7670.c:1056:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, 0);
               ^
   drivers/media//i2c/ov7670.c: In function 'ov7670_open':
>> drivers/media//i2c/ov7670.c:1547:38: error: 'struct v4l2_subdev_fh' has no member named 'pad'
        v4l2_subdev_get_try_format(sd, fh->pad, 0);
                                         ^~
   drivers/media//i2c/ov7670.c: In function 'ov7670_probe':
   drivers/media//i2c/ov7670.c:1750:10: error: 'struct v4l2_subdev' has no member named 'entity'
     info->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
             ^
   drivers/media//i2c/ov7670.c:1751:40: error: 'struct v4l2_subdev' has no member named 'entity'
     ret = media_entity_pads_init(&info->sd.entity, 1, &info->pad);
                                           ^
   drivers/media//i2c/ov7670.c:1764:32: error: 'struct v4l2_subdev' has no member named 'entity'
     media_entity_cleanup(&info->sd.entity);
                                   ^
   drivers/media//i2c/ov7670.c: In function 'ov7670_remove':
   drivers/media//i2c/ov7670.c:1781:32: error: 'struct v4l2_subdev' has no member named 'entity'
     media_entity_cleanup(&info->sd.entity);
                                   ^
   cc1: some warnings being treated as errors

vim +/v4l2_subdev_get_try_format +1004 drivers/media//i2c/ov7670.c

   982	
   983	/*
   984	 * Set a format.
   985	 */
   986	static int ov7670_set_fmt(struct v4l2_subdev *sd,
   987			struct v4l2_subdev_pad_config *cfg,
   988			struct v4l2_subdev_format *format)
   989	{
   990		struct ov7670_format_struct *ovfmt;
   991		struct ov7670_win_size *wsize;
   992		struct ov7670_info *info = to_state(sd);
   993		struct v4l2_mbus_framefmt *mbus_fmt;
   994		unsigned char com7;
   995		int ret;
   996	
   997		if (format->pad)
   998			return -EINVAL;
   999	
  1000		if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
  1001			ret = ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
  1002			if (ret)
  1003				return ret;
> 1004			mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
  1005			*mbus_fmt = format->format;
  1006			return 0;
  1007		}
  1008	
  1009		ret = ov7670_try_fmt_internal(sd, &format->format, &ovfmt, &wsize);
  1010	
  1011		if (ret)
  1012			return ret;
  1013		/*
  1014		 * COM7 is a pain in the ass, it doesn't like to be read then
  1015		 * quickly written afterward.  But we have everything we need
  1016		 * to set it absolutely here, as long as the format-specific
  1017		 * register sets list it first.
  1018		 */
  1019		com7 = ovfmt->regs[0].value;
  1020		com7 |= wsize->com7_bit;
  1021		ov7670_write(sd, REG_COM7, com7);
  1022		/*
  1023		 * Now write the rest of the array.  Also store start/stops
  1024		 */
  1025		ov7670_write_array(sd, ovfmt->regs + 1);
  1026		ov7670_set_hw(sd, wsize->hstart, wsize->hstop, wsize->vstart,
  1027				wsize->vstop);
  1028		ret = 0;
  1029		if (wsize->regs)
  1030			ret = ov7670_write_array(sd, wsize->regs);
  1031		info->fmt = ovfmt;
  1032	
  1033		/*
  1034		 * If we're running RGB565, we must rewrite clkrc after setting
  1035		 * the other parameters or the image looks poor.  If we're *not*
  1036		 * doing RGB565, we must not rewrite clkrc or the image looks
  1037		 * *really* poor.
  1038		 *
  1039		 * (Update) Now that we retain clkrc state, we should be able
  1040		 * to write it unconditionally, and that will make the frame
  1041		 * rate persistent too.
  1042		 */
  1043		if (ret == 0)
  1044			ret = ov7670_write(sd, REG_CLKRC, info->clkrc);
  1045		return 0;
  1046	}
  1047	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28336 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/83bcaa5f/attachment-0001.gz>
