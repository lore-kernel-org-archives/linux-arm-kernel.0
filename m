From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 27 Dec 2017 04:09:35 +0800
Subject: [arm:csi-v6 5/15] drivers/media/i2c/imx219.c:1190:37: sparse: cast
 to restricted __be16
Message-ID: <201712270434.kTHKpq1n%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git csi-v6
head:   ed3a8e14cfa42d5bb506326186c2092cc69d2899
commit: d63078ff2c761da0b393889c2f909fd379c1fa5b [5/15] media: i2c: imx219 camera driver
reproduce:
        # apt-get install sparse
        git checkout d63078ff2c761da0b393889c2f909fd379c1fa5b
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +1190 drivers/media/i2c/imx219.c

  1086	
  1087	/*
  1088	 * The line length in conjunction with the VT clock determines the
  1089	 * start of transmission of each line on the CSI bus.
  1090	 *
  1091	 * The frame length in conjunction with the line length and VT clock
  1092	 * determines the start of transmission of each frame on the CSI bus.
  1093	 *
  1094	 * Note: these two parameters have nothing to do with the pixel array
  1095	 * addressing parameters.
  1096	 */
  1097	static void imx219_update_frame_size(struct imx219_private *priv)
  1098	{
  1099		unsigned long vt_pixclk = imx219_get_vt_pixclk(priv);
  1100		unsigned long op_sysclk;
  1101		unsigned int div, lane_line_bits;
  1102		unsigned int line_clk, line_length, line_blank;
  1103		unsigned int min_frame_length, frame_length, frame_blank;
  1104	
  1105		/* see comments above, this is definitely wrong */
  1106		unsigned int width = be16_to_cpu(priv->params.x_output_size);
  1107		unsigned int height = be16_to_cpu(priv->params.y_output_size);
  1108	
  1109		dev_info(priv->root.sd.dev, "%s() for %ux%u %ubpp fi=%u/%u:\n", __func__,
  1110			width, height, priv->bits_per_pixel,
  1111			priv->frame_interval.numerator,
  1112			priv->frame_interval.denominator);
  1113	
  1114		/*
  1115		 * This works for calculating a working line length, but is
  1116		 * less than ideal, as we always run the VT block at maximum,
  1117		 * and wind the output block up to maximum for large widths.
  1118		 */
  1119		lane_line_bits = imx219_calc_lane_line_bits(priv);
  1120	
  1121		line_clk = 2 * vt_pixclk / priv->min_line_length_pck;
  1122	
  1123		dev_info(priv->root.sd.dev, "VT: pixclk=%luHz line=%uHz\n",
  1124			vt_pixclk, line_clk);
  1125	
  1126		/* Calculate the required output sysclk */
  1127		op_sysclk = line_clk * lane_line_bits;
  1128	
  1129		/*
  1130		 * Try to find a sysclk divisor that gives us the highest PLL
  1131		 * speed - otherwise errors seem to occur at the CSI2 receiver:
  1132		 * i.MX6 CS2 error 2/1 registers = 0x00000120/0x11000113
  1133		 *  - header ecc contains 2 errors
  1134		 *  - crc error on vc0
  1135		 *  - incorrect frame sequence on vc0
  1136		 *  - error matching frame start with frame end on vc0
  1137		 *  - sot sync failed on lane 1
  1138		 *  - sot sync failed on lane 0
  1139		 *  - sot error on lane 1
  1140		 *  - header error detected and corrected on vc0
  1141		 * Note: docs say 432MHz as the PLL low bound, hardware says 400MHz,
  1142		 * experimentation with my imx219 is stable at 464MHz but not 456MHz.
  1143		 */
  1144		for (div = priv->pll[PLL_OP].clk[CLK_SYS].max_div;
  1145		     div > priv->pll[PLL_OP].clk[CLK_SYS].min_div; div--)
  1146			if (op_sysclk * div <= priv->pll[PLL_OP].clk[CLK_SYS].max_freq)
  1147				break;
  1148	
  1149		priv->op_sys_div = div;
  1150		op_sysclk *= div;
  1151	
  1152		dev_info(priv->root.sd.dev, "OP: sysclk=%luHz/%u for %u bits/line/lane\n",
  1153			op_sysclk, div, lane_line_bits);
  1154	
  1155		priv->op_mpy = clamp_val(DIV_ROUND_UP(op_sysclk,
  1156						      priv->pll_ip_freq),
  1157					 priv->pll[PLL_OP].min_mpy,
  1158					 priv->pll[PLL_OP].max_mpy);
  1159	
  1160		/* Now calculate the real output sysclk */
  1161		op_sysclk = priv->pll_ip_freq * priv->op_mpy / div;
  1162	
  1163		/* ... and the resulting line clock for the output */
  1164		line_clk = op_sysclk / lane_line_bits;
  1165	
  1166		dev_info(priv->root.sd.dev, "OP: real sysclk %luHz line %uHz\n",
  1167			 op_sysclk, line_clk);
  1168	
  1169		/* ... and the final line length */
  1170		line_length = clamp_val(DIV_ROUND_UP(2 * vt_pixclk, line_clk),
  1171					priv->min_line_length_pck,
  1172					priv->max_line_length_pck);
  1173	
  1174		priv->params.line_length = cpu_to_be16(line_length);
  1175	
  1176		/* ... and the final line rate */
  1177		line_clk = 2 * vt_pixclk / line_length;
  1178	
  1179		/*
  1180		 * Calculate the frame length required to give the requested
  1181		 * frame interval.
  1182		 */
  1183		min_frame_length = imx219_calc_total_lines(priv);
  1184		frame_length = div_u64((u64)line_clk * priv->frame_interval.numerator,
  1185				       priv->frame_interval.denominator);
  1186	
  1187		frame_length = clamp_val(frame_length, min_frame_length,
  1188					 priv->max_frame_lines);
  1189	
> 1190		priv->params.frame_length = be16_to_cpu(frame_length);
  1191	
  1192		dev_info(priv->root.sd.dev, "VT: line length %u frame length %u line %uHz\n",
  1193			 line_length, frame_length, line_clk);
  1194	
  1195	
  1196	
  1197		/* See comments above, this is definitely wrong. */
  1198		line_blank = line_length - width;
  1199		frame_blank = frame_length - height;
  1200	
  1201		v4l2_ctrl_s_ctrl_int64(priv->pixel.ctrls[CTRL_P_PIXEL_RATE],
  1202					2 * vt_pixclk);
  1203	
  1204		v4l2_ctrl_modify_range(priv->pixel.ctrls[CTRL_P_HBLANK],
  1205				       max_t(s32, priv->min_line_length_pck - width,
  1206					     priv->min_line_blank_pck),
  1207				       priv->max_line_length_pck - width, 1,
  1208				       line_blank);
  1209		v4l2_ctrl_s_ctrl(priv->pixel.ctrls[CTRL_P_HBLANK], line_blank);
  1210	
  1211		v4l2_ctrl_modify_range(priv->pixel.ctrls[CTRL_P_VBLANK],
  1212				max_t(s32, priv->min_frame_lines - height,
  1213				      priv->min_frame_blank_lines),
  1214				priv->max_frame_lines - height, 1, frame_blank);
  1215		v4l2_ctrl_s_ctrl(priv->pixel.ctrls[CTRL_P_VBLANK], frame_blank);
  1216	
  1217		imx219_set_exposure_limits(priv);
  1218	}
  1219	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
