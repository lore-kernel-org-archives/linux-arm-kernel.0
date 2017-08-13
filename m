From: lkp@intel.com (kbuild test robot)
Date: Sun, 13 Aug 2017 09:04:44 +0800
Subject: [PATCH v7] rockchip/rga: v4l2 m2m support
In-Reply-To: <1501737812-24171-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <201708130912.x1Jda6gx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.13-rc4 next-20170811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/rockchip-rga-v4l2-m2m-support/20170803-234713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: s390-allmodconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set_trans_info':
   drivers/media/platform/rockchip-rga/rga-hw.c:237:17: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     if (ctx->op == V4L2_PORTER_DUFF_CLEAR) {
                    ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:237:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set_mode':
   drivers/media/platform/rockchip-rga/rga-hw.c:391:7: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_CLEAR:
          ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/rockchip-rga/rga-hw.c:397:7: error: 'V4L2_PORTER_DUFF_DST' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DST:
          ^~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:398:7: error: 'V4L2_PORTER_DUFF_DSTATOP' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTATOP:
          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:399:7: error: 'V4L2_PORTER_DUFF_DSTIN' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTIN:
          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:400:7: error: 'V4L2_PORTER_DUFF_DSTOUT' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTOUT:
          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/rockchip-rga/rga-hw.c:401:7: error: 'V4L2_PORTER_DUFF_DSTOVER' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTOVER:
          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:402:7: error: 'V4L2_PORTER_DUFF_SRCATOP' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCATOP:
          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:403:7: error: 'V4L2_PORTER_DUFF_SRCIN' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCIN:
          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:404:7: error: 'V4L2_PORTER_DUFF_SRCOUT' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCOUT:
          ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c:405:7: error: 'V4L2_PORTER_DUFF_SRCOVER' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCOVER:
          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set':
   drivers/media/platform/rockchip-rga/rga-hw.c:623:17: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     if (ctx->op != V4L2_PORTER_DUFF_CLEAR) {
                    ^~~~~~~~~~~~~~~~~~~~~~

vim +/V4L2_PORTER_DUFF_DST +397 drivers/media/platform/rockchip-rga/rga-hw.c

   168	
   169	static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
   170	{
   171		struct rockchip_rga *rga = ctx->rga;
   172		u32 *dest = rga->cmdbuf_virt;
   173		unsigned int scale_dst_w, scale_dst_h;
   174		unsigned int src_h, src_w, src_x, src_y, dst_h, dst_w, dst_x, dst_y;
   175		union rga_src_info src_info;
   176		union rga_dst_info dst_info;
   177		union rga_src_x_factor x_factor;
   178		union rga_src_y_factor y_factor;
   179		union rga_src_vir_info src_vir_info;
   180		union rga_src_act_info src_act_info;
   181		union rga_dst_vir_info dst_vir_info;
   182		union rga_dst_act_info dst_act_info;
   183	
   184		struct rga_addr_offset *dst_offset;
   185		struct rga_corners_addr_offset offsets;
   186		struct rga_corners_addr_offset src_offsets;
   187	
   188		src_h = ctx->in.crop.height;
   189		src_w = ctx->in.crop.width;
   190		src_x = ctx->in.crop.left;
   191		src_y = ctx->in.crop.top;
   192		dst_h = ctx->out.crop.height;
   193		dst_w = ctx->out.crop.width;
   194		dst_x = ctx->out.crop.left;
   195		dst_y = ctx->out.crop.top;
   196	
   197		src_info.val = dest[(RGA_SRC_INFO - RGA_MODE_BASE_REG) >> 2];
   198		dst_info.val = dest[(RGA_DST_INFO - RGA_MODE_BASE_REG) >> 2];
   199		x_factor.val = dest[(RGA_SRC_X_FACTOR - RGA_MODE_BASE_REG) >> 2];
   200		y_factor.val = dest[(RGA_SRC_Y_FACTOR - RGA_MODE_BASE_REG) >> 2];
   201		src_vir_info.val = dest[(RGA_SRC_VIR_INFO - RGA_MODE_BASE_REG) >> 2];
   202		src_act_info.val = dest[(RGA_SRC_ACT_INFO - RGA_MODE_BASE_REG) >> 2];
   203		dst_vir_info.val = dest[(RGA_DST_VIR_INFO - RGA_MODE_BASE_REG) >> 2];
   204		dst_act_info.val = dest[(RGA_DST_ACT_INFO - RGA_MODE_BASE_REG) >> 2];
   205	
   206		src_info.data.format = ctx->in.fmt->hw_format;
   207		src_info.data.swap = ctx->in.fmt->color_swap;
   208		dst_info.data.format = ctx->out.fmt->hw_format;
   209		dst_info.data.swap = ctx->out.fmt->color_swap;
   210	
   211		if (ctx->in.fmt->hw_format >= RGA_COLOR_FMT_YUV422SP) {
   212			if (ctx->out.fmt->hw_format < RGA_COLOR_FMT_YUV422SP) {
   213				switch (ctx->in.colorspace) {
   214				case V4L2_COLORSPACE_REC709:
   215					src_info.data.csc_mode =
   216						RGA_SRC_CSC_MODE_BT709_R0;
   217					break;
   218				default:
   219					src_info.data.csc_mode =
   220						RGA_SRC_CSC_MODE_BT601_R0;
   221					break;
   222				}
   223			}
   224		}
   225	
   226		if (ctx->out.fmt->hw_format >= RGA_COLOR_FMT_YUV422SP) {
   227			switch (ctx->out.colorspace) {
   228			case V4L2_COLORSPACE_REC709:
   229				dst_info.data.csc_mode = RGA_SRC_CSC_MODE_BT709_R0;
   230				break;
   231			default:
   232				dst_info.data.csc_mode = RGA_DST_CSC_MODE_BT601_R0;
   233				break;
   234			}
   235		}
   236	
 > 237		if (ctx->op == V4L2_PORTER_DUFF_CLEAR) {
   238			/*
   239			 * Configure the target color to foreground color.
   240			 */
   241			dest[(RGA_SRC_FG_COLOR - RGA_MODE_BASE_REG) >> 2] =
   242				ctx->fill_color;
   243			dst_vir_info.data.vir_stride = ctx->out.stride >> 2;
   244			dst_act_info.data.act_height = dst_h - 1;
   245			dst_act_info.data.act_width = dst_w - 1;
   246	
   247			offsets = rga_get_addr_offset(&ctx->out, dst_x, dst_y,
   248						      dst_w, dst_h);
   249			dst_offset = &offsets.left_top;
   250	
   251			goto write_dst;
   252		}
   253	
   254		if (ctx->vflip)
   255			src_info.data.mir_mode |= RGA_SRC_MIRR_MODE_X;
   256	
   257		if (ctx->hflip)
   258			src_info.data.mir_mode |= RGA_SRC_MIRR_MODE_Y;
   259	
   260		switch (ctx->rotate) {
   261		case 90:
   262			src_info.data.rot_mode = RGA_SRC_ROT_MODE_90_DEGREE;
   263			break;
   264		case 180:
   265			src_info.data.rot_mode = RGA_SRC_ROT_MODE_180_DEGREE;
   266			break;
   267		case 270:
   268			src_info.data.rot_mode = RGA_SRC_ROT_MODE_270_DEGREE;
   269			break;
   270		default:
   271			src_info.data.rot_mode = RGA_SRC_ROT_MODE_0_DEGREE;
   272			break;
   273		}
   274	
   275		/*
   276		 * Cacluate the up/down scaling mode/factor.
   277		 *
   278		 * RGA used to scale the picture first, and then rotate second,
   279		 * so we need to swap the w/h when rotate degree is 90/270.
   280		 */
   281		if (src_info.data.rot_mode == RGA_SRC_ROT_MODE_90_DEGREE ||
   282		    src_info.data.rot_mode == RGA_SRC_ROT_MODE_270_DEGREE) {
   283			if (rga->version.major == 0 || rga->version.minor == 0) {
   284				if (dst_w == src_h)
   285					src_h -= 8;
   286				if (abs(src_w - dst_h) < 16)
   287					src_w -= 16;
   288			}
   289	
   290			scale_dst_h = dst_w;
   291			scale_dst_w = dst_h;
   292		} else {
   293			scale_dst_w = dst_w;
   294			scale_dst_h = dst_h;
   295		}
   296	
   297		if (src_w == scale_dst_w) {
   298			src_info.data.hscl_mode = RGA_SRC_HSCL_MODE_NO;
   299			x_factor.val = 0;
   300		} else if (src_w > scale_dst_w) {
   301			src_info.data.hscl_mode = RGA_SRC_HSCL_MODE_DOWN;
   302			x_factor.data.down_scale_factor =
   303				rga_get_scaling(src_w, scale_dst_w) + 1;
   304		} else {
   305			src_info.data.hscl_mode = RGA_SRC_HSCL_MODE_UP;
   306			x_factor.data.up_scale_factor =
   307				rga_get_scaling(src_w - 1, scale_dst_w - 1);
   308		}
   309	
   310		if (src_h == scale_dst_h) {
   311			src_info.data.vscl_mode = RGA_SRC_VSCL_MODE_NO;
   312			y_factor.val = 0;
   313		} else if (src_h > scale_dst_h) {
   314			src_info.data.vscl_mode = RGA_SRC_VSCL_MODE_DOWN;
   315			y_factor.data.down_scale_factor =
   316				rga_get_scaling(src_h, scale_dst_h) + 1;
   317		} else {
   318			src_info.data.vscl_mode = RGA_SRC_VSCL_MODE_UP;
   319			y_factor.data.up_scale_factor =
   320				rga_get_scaling(src_h - 1, scale_dst_h - 1);
   321		}
   322	
   323		/*
   324		 * Cacluate the framebuffer virtual strides and active size,
   325		 * note that the step of vir_stride / vir_width is 4 byte words
   326		 */
   327		src_vir_info.data.vir_stride = ctx->in.stride >> 2;
   328		src_vir_info.data.vir_width = ctx->in.stride >> 2;
   329	
   330		src_act_info.data.act_height = src_h - 1;
   331		src_act_info.data.act_width = src_w - 1;
   332	
   333		dst_vir_info.data.vir_stride = ctx->out.stride >> 2;
   334		dst_act_info.data.act_height = dst_h - 1;
   335		dst_act_info.data.act_width = dst_w - 1;
   336	
   337		/*
   338		 * Cacluate the source framebuffer base address with offset pixel.
   339		 */
   340		src_offsets = rga_get_addr_offset(&ctx->in, src_x, src_y,
   341						  src_w, src_h);
   342	
   343		/*
   344		 * Configure the dest framebuffer base address with pixel offset.
   345		 */
   346		offsets = rga_get_addr_offset(&ctx->out, dst_x, dst_y, dst_w, dst_h);
   347		dst_offset = rga_lookup_draw_pos(&offsets, src_info.data.rot_mode,
   348						 src_info.data.mir_mode);
   349	
   350		dest[(RGA_SRC_Y_RGB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   351			src_offsets.left_top.y_off;
   352		dest[(RGA_SRC_CB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   353			src_offsets.left_top.u_off;
   354		dest[(RGA_SRC_CR_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   355			src_offsets.left_top.v_off;
   356	
   357		dest[(RGA_SRC_X_FACTOR - RGA_MODE_BASE_REG) >> 2] = x_factor.val;
   358		dest[(RGA_SRC_Y_FACTOR - RGA_MODE_BASE_REG) >> 2] = y_factor.val;
   359		dest[(RGA_SRC_VIR_INFO - RGA_MODE_BASE_REG) >> 2] = src_vir_info.val;
   360		dest[(RGA_SRC_ACT_INFO - RGA_MODE_BASE_REG) >> 2] = src_act_info.val;
   361	
   362		dest[(RGA_SRC_INFO - RGA_MODE_BASE_REG) >> 2] = src_info.val;
   363	
   364	write_dst:
   365		dest[(RGA_DST_Y_RGB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   366			dst_offset->y_off;
   367		dest[(RGA_DST_CB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   368			dst_offset->u_off;
   369		dest[(RGA_DST_CR_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
   370			dst_offset->v_off;
   371	
   372		dest[(RGA_DST_VIR_INFO - RGA_MODE_BASE_REG) >> 2] = dst_vir_info.val;
   373		dest[(RGA_DST_ACT_INFO - RGA_MODE_BASE_REG) >> 2] = dst_act_info.val;
   374	
   375		dest[(RGA_DST_INFO - RGA_MODE_BASE_REG) >> 2] = dst_info.val;
   376	}
   377	
   378	static void rga_cmd_set_mode(struct rga_ctx *ctx)
   379	{
   380		struct rockchip_rga *rga = ctx->rga;
   381		u32 *dest = rga->cmdbuf_virt;
   382		union rga_mode_ctrl mode;
   383		union rga_alpha_ctrl0 alpha_ctrl0;
   384		union rga_alpha_ctrl1 alpha_ctrl1;
   385	
   386		mode.val = 0;
   387		alpha_ctrl0.val = 0;
   388		alpha_ctrl1.val = 0;
   389	
   390		switch (ctx->op) {
   391		case V4L2_PORTER_DUFF_CLEAR:
   392			mode.data.gradient_sat = 1;
   393			mode.data.render = RGA_MODE_RENDER_RECTANGLE_FILL;
   394			mode.data.cf_rop4_pat = RGA_MODE_CF_ROP4_SOLID;
   395			mode.data.bitblt = RGA_MODE_BITBLT_MODE_SRC_TO_DST;
   396			break;
 > 397		case V4L2_PORTER_DUFF_DST:
 > 398		case V4L2_PORTER_DUFF_DSTATOP:
   399		case V4L2_PORTER_DUFF_DSTIN:
   400		case V4L2_PORTER_DUFF_DSTOUT:
 > 401		case V4L2_PORTER_DUFF_DSTOVER:
   402		case V4L2_PORTER_DUFF_SRCATOP:
   403		case V4L2_PORTER_DUFF_SRCIN:
   404		case V4L2_PORTER_DUFF_SRCOUT:
   405		case V4L2_PORTER_DUFF_SRCOVER:
   406			mode.data.gradient_sat = 1;
   407			mode.data.render = RGA_MODE_RENDER_BITBLT;
   408			mode.data.bitblt = RGA_MODE_BITBLT_MODE_SRC_TO_DST;
   409	
   410			alpha_ctrl0.data.rop_en = 1;
   411			alpha_ctrl0.data.rop_mode = RGA_ALPHA_ROP_MODE_3;
   412			alpha_ctrl0.data.rop_select = RGA_ALPHA_SELECT_ALPHA;
   413	
   414			alpha_ctrl1.data.dst_alpha_cal_m0 = RGA_ALPHA_CAL_NORMAL;
   415			alpha_ctrl1.data.src_alpha_cal_m0 = RGA_ALPHA_CAL_NORMAL;
   416			alpha_ctrl1.data.dst_alpha_cal_m1 = RGA_ALPHA_CAL_NORMAL;
   417			alpha_ctrl1.data.src_alpha_cal_m1 = RGA_ALPHA_CAL_NORMAL;
   418			break;
   419		default:
   420			mode.data.gradient_sat = 1;
   421			mode.data.render = RGA_MODE_RENDER_BITBLT;
   422			mode.data.bitblt = RGA_MODE_BITBLT_MODE_SRC_TO_DST;
   423			break;
   424		}
   425	
   426		switch (ctx->op) {
   427		case V4L2_PORTER_DUFF_DST:
   428			/* A=Dst.a */
   429			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   430	
   431			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   432			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   433			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_ONE;
   434	
   435			/* C=Dst.c */
   436			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_ZERO;
   437	
   438			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   439			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   440			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   441			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_ONE;
   442			break;
   443		case V4L2_PORTER_DUFF_DSTATOP:
   444			/* A=Src.a */
   445			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   446			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   447			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ONE;
   448	
   449			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   450	
   451			/* C=Src.a*Dst.c+Src.c*(1.0-Dst.a) */
   452			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   453			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   454			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   455			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   456	
   457			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   458			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   459			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   460			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_OTHER;
   461			break;
   462		case V4L2_PORTER_DUFF_DSTIN:
   463			/* A=Dst.a*Src.a */
   464			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   465			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   466			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   467	
   468			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   469			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   470			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_OTHER;
   471	
   472			/* C=Dst.c*Src.a */
   473			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   474			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   475			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   476			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_ZERO;
   477	
   478			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   479			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   480			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   481			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_OTHER;
   482			break;
   483		case V4L2_PORTER_DUFF_DSTOUT:
   484			/* A=Dst.a*(1.0-Src.a) */
   485			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   486			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   487			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   488	
   489			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   490			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   491			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   492	
   493			/* C=Dst.c*(1.0-Src.a) */
   494			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   495			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   496			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   497			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_ZERO;
   498	
   499			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   500			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   501			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   502			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   503			break;
   504		case V4L2_PORTER_DUFF_DSTOVER:
   505			/* A=Src.a+Dst.a*(1.0-Src.a) */
   506			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   507			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   508			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ONE;
   509	
   510			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   511			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   512			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   513	
   514			/* C=Dst.c+Src.c*(1.0-Dst.a) */
   515			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   516			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   517			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   518			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   519	
   520			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   521			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   522			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   523			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_ONE;
   524			break;
   525		case V4L2_PORTER_DUFF_SRCATOP:
   526			/* A=Dst.a */
   527			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   528	
   529			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   530			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   531			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_ONE;
   532	
   533			/* C=Dst.a*Src.c+Dst.c*(1.0-Src.a) */
   534			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   535			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   536			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   537			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_OTHER;
   538	
   539			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   540			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   541			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   542			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   543			break;
   544		case V4L2_PORTER_DUFF_SRCIN:
   545			/* A=Src.a*Dst.a */
   546			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   547			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   548			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   549	
   550			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   551			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   552			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_OTHER;
   553	
   554			/* C=Src.c*Dst.a */
   555			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   556			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   557			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   558			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_OTHER;
   559	
   560			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   561			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   562			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   563			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_ZERO;
   564			break;
   565		case V4L2_PORTER_DUFF_SRCOUT:
   566			/* A=Src.a*(1.0-Dst.a) */
   567			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   568			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   569			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   570	
   571			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   572			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   573			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_ZERO;
   574	
   575			/* C=Src.c*(1.0-Dst.a) */
   576			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   577			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   578			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   579			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   580	
   581			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   582			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   583			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   584			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_ZERO;
   585			break;
   586		case V4L2_PORTER_DUFF_SRCOVER:
   587			/* A=Src.a+Dst.a*(1.0-Src.a) */
   588			alpha_ctrl1.data.src_alpha_m1 = RGA_ALPHA_NORMAL;
   589			alpha_ctrl1.data.src_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   590			alpha_ctrl1.data.src_factor_m1 = RGA_ALPHA_FACTOR_ONE;
   591	
   592			alpha_ctrl1.data.dst_alpha_m1 = RGA_ALPHA_NORMAL;
   593			alpha_ctrl1.data.dst_blend_m1 = RGA_ALPHA_BLEND_NORMAL;
   594			alpha_ctrl1.data.dst_factor_m1 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   595	
   596			/* C=Src.c+Dst.c*(1.0-Src.a) */
   597			alpha_ctrl1.data.src_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   598			alpha_ctrl1.data.src_alpha_m0 = RGA_ALPHA_NORMAL;
   599			alpha_ctrl1.data.src_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   600			alpha_ctrl1.data.src_factor_m0 = RGA_ALPHA_FACTOR_ONE;
   601	
   602			alpha_ctrl1.data.dst_color_m0 = RGA_ALPHA_COLOR_NORMAL;
   603			alpha_ctrl1.data.dst_alpha_m0 = RGA_ALPHA_NORMAL;
   604			alpha_ctrl1.data.dst_blend_m0 = RGA_ALPHA_BLEND_NORMAL;
   605			alpha_ctrl1.data.dst_factor_m0 = RGA_ALPHA_FACTOR_OTHER_REVERSE;
   606			break;
   607		default:
   608			break;
   609		}
   610	
   611		dest[(RGA_ALPHA_CTRL0 - RGA_MODE_BASE_REG) >> 2] = alpha_ctrl0.val;
   612		dest[(RGA_ALPHA_CTRL1 - RGA_MODE_BASE_REG) >> 2] = alpha_ctrl1.val;
   613	
   614		dest[(RGA_MODE_CTRL - RGA_MODE_BASE_REG) >> 2] = mode.val;
   615	}
   616	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47252 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170813/556d37e5/attachment-0001.gz>
