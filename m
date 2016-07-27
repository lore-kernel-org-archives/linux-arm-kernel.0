From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Jul 2016 18:07:55 +0200 (CEST)
Subject: [xlnx:master 2553/2625]
 drivers/gpu/drm/xilinx/xilinx_drm_dp.c:1005:31-32:
 WARNING: Unsigned expression compared with zero: i >= 0
Message-ID: <alpine.DEB.2.10.1607271806290.3117@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This looks like an infinite loop, unless the break is guaranteed to
occur.

julia


tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: 28f06f4dd82e9915e7ee2cae6cf52b9e2666c68c [2553/2625] drm: xilinx: dp: Reduce the bit rate if the link training fails
:::::: branch date: 4 hours ago
:::::: commit date: 5 weeks ago

>> drivers/gpu/drm/xilinx/xilinx_drm_dp.c:1005:31-32: WARNING: Unsigned expression compared with zero: i >= 0

git remote add xlnx https://github.com/Xilinx/linux-xlnx
git remote update xlnx
git checkout 28f06f4dd82e9915e7ee2cae6cf52b9e2666c68c
vim +1005 drivers/gpu/drm/xilinx/xilinx_drm_dp.c

1ec84245 Hyun Kwon 2014-05-05   989   * Find the link configuration values, rate and lane count for requested pixel
1ec84245 Hyun Kwon 2014-05-05   990   * clock @pclock.
28f06f4d Hyun Kwon 2016-06-17   991   *
28f06f4d Hyun Kwon 2016-06-17   992   * Return: Current link rate code, or -EINVAL.
1ec84245 Hyun Kwon 2014-05-05   993   */
28f06f4d Hyun Kwon 2016-06-17   994  static int xilinx_drm_dp_mode_configure(struct xilinx_drm_dp *dp, int pclock,
28f06f4d Hyun Kwon 2016-06-17   995  					u8 current_bw)
1ec84245 Hyun Kwon 2014-05-05   996  {
1ec84245 Hyun Kwon 2014-05-05   997  	int max_rate = dp->link_config.max_rate;
1ec84245 Hyun Kwon 2014-05-05   998  	u8 bws[3] = { DP_LINK_BW_1_62, DP_LINK_BW_2_7, DP_LINK_BW_5_4 };
1ec84245 Hyun Kwon 2014-05-05   999  	u8 max_lanes = dp->link_config.max_lanes;
1ec84245 Hyun Kwon 2014-05-05  1000  	u8 max_link_rate_code = drm_dp_link_rate_to_bw_code(max_rate);
1ec84245 Hyun Kwon 2014-05-05  1001  	u8 bpp = dp->config.bpp;
1ec84245 Hyun Kwon 2014-05-05  1002  	u8 lane_cnt, i;
1ec84245 Hyun Kwon 2014-05-05  1003  	s8 clock;
1ec84245 Hyun Kwon 2014-05-05  1004
28f06f4d Hyun Kwon 2016-06-17 @1005  	for (i = ARRAY_SIZE(bws) - 1; i >= 0; i--) {
28f06f4d Hyun Kwon 2016-06-17  1006  		if (current_bw && bws[i] >= current_bw)
28f06f4d Hyun Kwon 2016-06-17  1007  			continue;
28f06f4d Hyun Kwon 2016-06-17  1008
28f06f4d Hyun Kwon 2016-06-17  1009  		if (bws[i] <= max_link_rate_code)
1ec84245 Hyun Kwon 2014-05-05  1010  			break;
28f06f4d Hyun Kwon 2016-06-17  1011  	}
1ec84245 Hyun Kwon 2014-05-05  1012
1ec84245 Hyun Kwon 2014-05-05  1013  	for (lane_cnt = 1; lane_cnt <= max_lanes; lane_cnt <<= 1)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
