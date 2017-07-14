From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Jul 2017 18:15:05 +0800
Subject: [PATCH 12/18] drm/sun4i: Add Allwinner A31 MIPI-DSI controller
 support
In-Reply-To: <55729048aa9c57b46ed3f8d284eec2fbf5f1ae6a.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <201707141831.7a4ow1hs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test ERROR on next-20170710]
[cannot apply to mripard/sunxi/for-next robh/for-next regmap/for-next v4.12 v4.12-rc7 v4.12-rc6 v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Allwinner-MIPI-DSI-support/20170714-123103
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c: In function 'sun6i_dphy_init':
>> drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c:92:2: error: implicit declaration of function 'clk_set_rate_protect' [-Werror=implicit-function-declaration]
     clk_set_rate_protect(dphy->mod_clk, 150000000);
     ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c: In function 'sun6i_dphy_exit':
>> drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c:199:2: error: implicit declaration of function 'clk_rate_unprotect' [-Werror=implicit-function-declaration]
     clk_rate_unprotect(dphy->mod_clk);
     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function 'sun6i_dsi_probe':
>> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:984:2: error: implicit declaration of function 'clk_set_rate_protect' [-Werror=implicit-function-declaration]
     clk_set_rate_protect(dsi->mod_clk, 297000000);
     ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1016:2: error: implicit declaration of function 'clk_rate_unprotect' [-Werror=implicit-function-declaration]
     clk_rate_unprotect(dsi->mod_clk);
     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/clk_set_rate_protect +92 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c

    87	
    88	int sun6i_dphy_init(struct sun6i_dphy *dphy, unsigned int lanes)
    89	{
    90		reset_control_deassert(dphy->reset);
    91		clk_prepare_enable(dphy->mod_clk);
  > 92		clk_set_rate_protect(dphy->mod_clk, 150000000);
    93	
    94		regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
    95			     SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT);
    96	
    97		regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME0_REG,
    98			     SUN6I_DPHY_TX_TIME0_LP_CLK_DIV(14) |
    99			     SUN6I_DPHY_TX_TIME0_HS_PREPARE(6) |
   100			     SUN6I_DPHY_TX_TIME0_HS_TRAIL(10));
   101	
   102		regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME1_REG,
   103			     SUN6I_DPHY_TX_TIME1_CLK_PREPARE(7) |
   104			     SUN6I_DPHY_TX_TIME1_CLK_ZERO(50) |
   105			     SUN6I_DPHY_TX_TIME1_CLK_PRE(3) |
   106			     SUN6I_DPHY_TX_TIME1_CLK_POST(10));
   107	
   108		regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME2_REG,
   109			     SUN6I_DPHY_TX_TIME2_CLK_TRAIL(30));
   110	
   111		regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME3_REG, 0);
   112	
   113		regmap_write(dphy->regs, SUN6I_DPHY_TX_TIME4_REG,
   114			     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
   115			     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
   116	
   117		/* FIXME: Number of lanes? */
   118		regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
   119			     SUN6I_DPHY_GCTL_LANE_NUM(lanes) |
   120			     SUN6I_DPHY_GCTL_EN);
   121	
   122		return 0;
   123	}
   124	
   125	int sun6i_dphy_power_on(struct sun6i_dphy *dphy, unsigned int lanes)
   126	{
   127		u8 lanes_mask = GENMASK(lanes - 1, 0);
   128	
   129		regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
   130			     SUN6I_DPHY_ANA0_REG_PWS |
   131			     SUN6I_DPHY_ANA0_REG_DMPC |
   132			     SUN6I_DPHY_ANA0_REG_SLV(7) |
   133			     SUN6I_DPHY_ANA0_REG_DMPD(lanes_mask) |
   134			     SUN6I_DPHY_ANA0_REG_DEN(lanes_mask));
   135	
   136		regmap_write(dphy->regs, SUN6I_DPHY_ANA1_REG,
   137			     SUN6I_DPHY_ANA1_REG_CSMPS(1) |
   138			     SUN6I_DPHY_ANA1_REG_SVTT(7));
   139	
   140		regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG,
   141			     SUN6I_DPHY_ANA4_REG_CKDV(1) |
   142			     SUN6I_DPHY_ANA4_REG_TMSC(1) |
   143			     SUN6I_DPHY_ANA4_REG_TMSD(1) |
   144			     SUN6I_DPHY_ANA4_REG_TXDNSC(1) |
   145			     SUN6I_DPHY_ANA4_REG_TXDNSD(1) |
   146			     SUN6I_DPHY_ANA4_REG_TXPUSC(1) |
   147			     SUN6I_DPHY_ANA4_REG_TXPUSD(1) |
   148			     SUN6I_DPHY_ANA4_REG_DMPLVC |
   149			     SUN6I_DPHY_ANA4_REG_DMPLVD(lanes_mask));
   150	
   151		regmap_write(dphy->regs, SUN6I_DPHY_ANA2_REG,
   152			     SUN6I_DPHY_ANA2_REG_ENIB);
   153		udelay(5);
   154	
   155		regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG,
   156			     SUN6I_DPHY_ANA3_EN_LDOR |
   157			     SUN6I_DPHY_ANA3_EN_LDOC |
   158			     SUN6I_DPHY_ANA3_EN_LDOD);
   159		udelay(1);
   160	
   161		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA3_REG,
   162				   SUN6I_DPHY_ANA3_EN_VTTC |
   163				   SUN6I_DPHY_ANA3_EN_VTTD_MASK,
   164				   SUN6I_DPHY_ANA3_EN_VTTC |
   165				   SUN6I_DPHY_ANA3_EN_VTTD(lanes_mask));
   166		udelay(1);
   167	
   168		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA3_REG,
   169				   SUN6I_DPHY_ANA3_EN_DIV,
   170				   SUN6I_DPHY_ANA3_EN_DIV);
   171		udelay(1);
   172	
   173		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
   174				   SUN6I_DPHY_ANA2_EN_CK_CPU,
   175				   SUN6I_DPHY_ANA2_EN_CK_CPU);
   176		udelay(1);
   177	
   178		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA1_REG,
   179				   SUN6I_DPHY_ANA1_REG_VTTMODE,
   180				   SUN6I_DPHY_ANA1_REG_VTTMODE);
   181	
   182		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA2_REG,
   183				   SUN6I_DPHY_ANA2_EN_P2S_CPU_MASK,
   184				   SUN6I_DPHY_ANA2_EN_P2S_CPU(lanes_mask));
   185	
   186		return 0;
   187	}
   188	
   189	int sun6i_dphy_power_off(struct sun6i_dphy *dphy)
   190	{
   191		regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA1_REG,
   192				   SUN6I_DPHY_ANA1_REG_VTTMODE, 0);
   193	
   194		return 0;
   195	}
   196	
   197	int sun6i_dphy_exit(struct sun6i_dphy *dphy)
   198	{
 > 199		clk_rate_unprotect(dphy->mod_clk);
   200		clk_disable_unprepare(dphy->mod_clk);
   201		reset_control_assert(dphy->reset);
   202	
   203		return 0;
   204	}
   205	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21270 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170714/d5911796/attachment-0001.gz>
