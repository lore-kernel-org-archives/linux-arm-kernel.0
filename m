From: lkp@intel.com (kbuild test robot)
Date: Mon, 18 Sep 2017 15:35:28 +0800
Subject: [PATCH v4 2/3] media: ov7670: Add the get_fmt callback
In-Reply-To: <20170918064514.6841-3-wenyou.yang@microchip.com>
Message-ID: <201709181533.LgOaU9L5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.14-rc1 next-20170918]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/media-ov7670-Add-entity-init-and-power-operation/20170918-145527
base:   git://linuxtv.org/media_tree.git master
config: x86_64-randconfig-x003-201738 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/media/i2c/ov7670.c: In function 'ov7670_set_fmt':
>> drivers/media/i2c/ov7670.c:1006:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      struct v4l2_mbus_framefmt *mbus_fmt;
      ^~~~~~

vim +1006 drivers/media/i2c/ov7670.c

   984	
   985	/*
   986	 * Set a format.
   987	 */
   988	static int ov7670_set_fmt(struct v4l2_subdev *sd,
   989			struct v4l2_subdev_pad_config *cfg,
   990			struct v4l2_subdev_format *format)
   991	{
   992		struct ov7670_format_struct *ovfmt;
   993		struct ov7670_win_size *wsize;
   994		struct ov7670_info *info = to_state(sd);
   995		unsigned char com7;
   996		int ret;
   997	
   998		if (format->pad)
   999			return -EINVAL;
  1000	
  1001		if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
  1002			ret = ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
  1003			if (ret)
  1004				return ret;
  1005	#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> 1006			struct v4l2_mbus_framefmt *mbus_fmt;
  1007	
  1008			mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
  1009			*mbus_fmt = format->format;
  1010			return 0;
  1011	#else
  1012			return -ENOTTY;
  1013	#endif
  1014		}
  1015	
  1016		ret = ov7670_try_fmt_internal(sd, &format->format, &ovfmt, &wsize);
  1017	
  1018		if (ret)
  1019			return ret;
  1020		/*
  1021		 * COM7 is a pain in the ass, it doesn't like to be read then
  1022		 * quickly written afterward.  But we have everything we need
  1023		 * to set it absolutely here, as long as the format-specific
  1024		 * register sets list it first.
  1025		 */
  1026		com7 = ovfmt->regs[0].value;
  1027		com7 |= wsize->com7_bit;
  1028		ov7670_write(sd, REG_COM7, com7);
  1029		/*
  1030		 * Now write the rest of the array.  Also store start/stops
  1031		 */
  1032		ov7670_write_array(sd, ovfmt->regs + 1);
  1033		ov7670_set_hw(sd, wsize->hstart, wsize->hstop, wsize->vstart,
  1034				wsize->vstop);
  1035		ret = 0;
  1036		if (wsize->regs)
  1037			ret = ov7670_write_array(sd, wsize->regs);
  1038		info->fmt = ovfmt;
  1039	
  1040		/*
  1041		 * If we're running RGB565, we must rewrite clkrc after setting
  1042		 * the other parameters or the image looks poor.  If we're *not*
  1043		 * doing RGB565, we must not rewrite clkrc or the image looks
  1044		 * *really* poor.
  1045		 *
  1046		 * (Update) Now that we retain clkrc state, we should be able
  1047		 * to write it unconditionally, and that will make the frame
  1048		 * rate persistent too.
  1049		 */
  1050		if (ret == 0)
  1051			ret = ov7670_write(sd, REG_CLKRC, info->clkrc);
  1052		return 0;
  1053	}
  1054	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31190 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/5d393aa1/attachment-0001.gz>
