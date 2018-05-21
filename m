From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 15:47:08 +0800
Subject: [PATCH 12/15] drm/sun4i: Add support for second clock parent to
 DW HDMI PHY clk driver
In-Reply-To: <20180519183127.2718-13-jernej.skrabec@siol.net>
References: <20180519183127.2718-13-jernej.skrabec@siol.net>
Message-ID: <201805211503.lxHMbRXG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Add-support-for-R40-HDMI-pipeline/20180521-131839
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h:12:0,
                    from drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c:9:
   drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c: In function 'sun8i_hdmi_phy_config_h3':
>> drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c:191:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
          ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
          ^
   include/linux/regmap.h:76:36: note: in definition of macro 'regmap_update_bits'
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
                                       ^~~~

vim +191 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c

     8	
   > 9	#include "sun8i_dw_hdmi.h"
    10	
    11	/*
    12	 * Address can be actually any value. Here is set to same value as
    13	 * it is set in BSP driver.
    14	 */
    15	#define I2C_ADDR	0x69
    16	
    17	static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
    18					      struct sun8i_hdmi_phy *phy,
    19					      unsigned int clk_rate)
    20	{
    21		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
    22				   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
    23				   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
    24	
    25		/* power down */
    26		dw_hdmi_phy_gen2_txpwron(hdmi, 0);
    27		dw_hdmi_phy_gen2_pddq(hdmi, 1);
    28	
    29		dw_hdmi_phy_reset(hdmi);
    30	
    31		dw_hdmi_phy_gen2_pddq(hdmi, 0);
    32	
    33		dw_hdmi_phy_i2c_set_addr(hdmi, I2C_ADDR);
    34	
    35		/*
    36		 * Values are taken from BSP HDMI driver. Although AW didn't
    37		 * release any documentation, explanation of this values can
    38		 * be found in i.MX 6Dual/6Quad Reference Manual.
    39		 */
    40		if (clk_rate <= 27000000) {
    41			dw_hdmi_phy_i2c_write(hdmi, 0x01e0, 0x06);
    42			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x15);
    43			dw_hdmi_phy_i2c_write(hdmi, 0x08da, 0x10);
    44			dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
    45			dw_hdmi_phy_i2c_write(hdmi, 0x0318, 0x0e);
    46			dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
    47		} else if (clk_rate <= 74250000) {
    48			dw_hdmi_phy_i2c_write(hdmi, 0x0540, 0x06);
    49			dw_hdmi_phy_i2c_write(hdmi, 0x0005, 0x15);
    50			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
    51			dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
    52			dw_hdmi_phy_i2c_write(hdmi, 0x02b5, 0x0e);
    53			dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
    54		} else if (clk_rate <= 148500000) {
    55			dw_hdmi_phy_i2c_write(hdmi, 0x04a0, 0x06);
    56			dw_hdmi_phy_i2c_write(hdmi, 0x000a, 0x15);
    57			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
    58			dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
    59			dw_hdmi_phy_i2c_write(hdmi, 0x0021, 0x0e);
    60			dw_hdmi_phy_i2c_write(hdmi, 0x8029, 0x09);
    61		} else {
    62			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x06);
    63			dw_hdmi_phy_i2c_write(hdmi, 0x000f, 0x15);
    64			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
    65			dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
    66			dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x0e);
    67			dw_hdmi_phy_i2c_write(hdmi, 0x802b, 0x09);
    68		}
    69	
    70		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x1e);
    71		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x13);
    72		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x17);
    73	
    74		dw_hdmi_phy_gen2_txpwron(hdmi, 1);
    75	
    76		return 0;
    77	}
    78	
    79	static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
    80					    struct sun8i_hdmi_phy *phy,
    81					    unsigned int clk_rate)
    82	{
    83		u32 pll_cfg1_init;
    84		u32 pll_cfg2_init;
    85		u32 ana_cfg1_end;
    86		u32 ana_cfg2_init;
    87		u32 ana_cfg3_init;
    88		u32 b_offset = 0;
    89		u32 val;
    90	
    91		/* bandwidth / frequency independent settings */
    92	
    93		pll_cfg1_init = SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN |
    94				SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN |
    95				SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(7) |
    96				SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(1) |
    97				SUN8I_HDMI_PHY_PLL_CFG1_PLLDBEN |
    98				SUN8I_HDMI_PHY_PLL_CFG1_CS |
    99				SUN8I_HDMI_PHY_PLL_CFG1_CP_S(2) |
   100				SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63) |
   101				SUN8I_HDMI_PHY_PLL_CFG1_BWS;
   102	
   103		pll_cfg2_init = SUN8I_HDMI_PHY_PLL_CFG2_SV_H |
   104				SUN8I_HDMI_PHY_PLL_CFG2_VCOGAIN_EN |
   105				SUN8I_HDMI_PHY_PLL_CFG2_SDIV2;
   106	
   107		ana_cfg1_end = SUN8I_HDMI_PHY_ANA_CFG1_REG_SVBH(1) |
   108			       SUN8I_HDMI_PHY_ANA_CFG1_AMP_OPT |
   109			       SUN8I_HDMI_PHY_ANA_CFG1_EMP_OPT |
   110			       SUN8I_HDMI_PHY_ANA_CFG1_AMPCK_OPT |
   111			       SUN8I_HDMI_PHY_ANA_CFG1_EMPCK_OPT |
   112			       SUN8I_HDMI_PHY_ANA_CFG1_ENRCAL |
   113			       SUN8I_HDMI_PHY_ANA_CFG1_ENCALOG |
   114			       SUN8I_HDMI_PHY_ANA_CFG1_REG_SCKTMDS |
   115			       SUN8I_HDMI_PHY_ANA_CFG1_TMDSCLK_EN |
   116			       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK |
   117			       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_ALL |
   118			       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDSCLK |
   119			       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS2 |
   120			       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS1 |
   121			       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS0 |
   122			       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS2 |
   123			       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS1 |
   124			       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS0 |
   125			       SUN8I_HDMI_PHY_ANA_CFG1_CKEN |
   126			       SUN8I_HDMI_PHY_ANA_CFG1_LDOEN |
   127			       SUN8I_HDMI_PHY_ANA_CFG1_ENVBS |
   128			       SUN8I_HDMI_PHY_ANA_CFG1_ENBI;
   129	
   130		ana_cfg2_init = SUN8I_HDMI_PHY_ANA_CFG2_M_EN |
   131				SUN8I_HDMI_PHY_ANA_CFG2_REG_DENCK |
   132				SUN8I_HDMI_PHY_ANA_CFG2_REG_DEN |
   133				SUN8I_HDMI_PHY_ANA_CFG2_REG_CKSS(1) |
   134				SUN8I_HDMI_PHY_ANA_CFG2_REG_CSMPS(1);
   135	
   136		ana_cfg3_init = SUN8I_HDMI_PHY_ANA_CFG3_REG_WIRE(0x3e0) |
   137				SUN8I_HDMI_PHY_ANA_CFG3_SDAEN |
   138				SUN8I_HDMI_PHY_ANA_CFG3_SCLEN;
   139	
   140		/* bandwidth / frequency dependent settings */
   141		if (clk_rate <= 27000000) {
   142			pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
   143					 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
   144			pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
   145					 SUN8I_HDMI_PHY_PLL_CFG2_S(4);
   146			ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
   147			ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
   148					 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
   149			ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(3) |
   150					 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(5);
   151		} else if (clk_rate <= 74250000) {
   152			pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
   153					 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
   154			pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
   155					 SUN8I_HDMI_PHY_PLL_CFG2_S(5);
   156			ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
   157			ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
   158					 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
   159			ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(5) |
   160					 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(7);
   161		} else if (clk_rate <= 148500000) {
   162			pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
   163					 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
   164			pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
   165					 SUN8I_HDMI_PHY_PLL_CFG2_S(6);
   166			ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
   167					 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
   168					 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(2);
   169			ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(7) |
   170					 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(9);
   171		} else {
   172			b_offset = 2;
   173			pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63);
   174			pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(6) |
   175					 SUN8I_HDMI_PHY_PLL_CFG2_S(7);
   176			ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
   177					 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
   178					 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4);
   179			ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(9) |
   180					 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(13);
   181		}
   182	
   183		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
   184				   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
   185	
   186		/*
   187		 * NOTE: We have to be careful not to overwrite PHY parent
   188		 * clock selection bit and clock divider.
   189		 */
   190		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
 > 191				   ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
   192				   pll_cfg1_init);
   193		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
   194				   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
   195				   pll_cfg2_init);
   196		usleep_range(10000, 15000);
   197		regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG3_REG,
   198			     SUN8I_HDMI_PHY_PLL_CFG3_SOUT_DIV2);
   199		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
   200				   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN,
   201				   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN);
   202		msleep(100);
   203	
   204		/* get B value */
   205		regmap_read(phy->regs, SUN8I_HDMI_PHY_ANA_STS_REG, &val);
   206		val = (val & SUN8I_HDMI_PHY_ANA_STS_B_OUT_MSK) >>
   207			SUN8I_HDMI_PHY_ANA_STS_B_OUT_SHIFT;
   208		val = min(val + b_offset, (u32)0x3f);
   209	
   210		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
   211				   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
   212				   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD,
   213				   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
   214				   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD);
   215		regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
   216				   SUN8I_HDMI_PHY_PLL_CFG1_B_IN_MSK,
   217				   val << SUN8I_HDMI_PHY_PLL_CFG1_B_IN_SHIFT);
   218		msleep(100);
   219		regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG, ana_cfg1_end);
   220		regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG2_REG, ana_cfg2_init);
   221		regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG3_REG, ana_cfg3_init);
   222	
   223		return 0;
   224	}
   225	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59031 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/e25d95d9/attachment-0001.gz>
