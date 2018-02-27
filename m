From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Feb 2018 10:18:28 +0800
Subject: [PATCH 12/15] drm/sun4i: Allow building on arm64
In-Reply-To: <20180224214545.3740-13-jernej.skrabec@siol.net>
References: <20180224214545.3740-13-jernej.skrabec@siol.net>
Message-ID: <201802271003.S2PF7sfl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on next-20180226]
[cannot apply to robh/for-next v4.16-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Implement-H3-H5-HDMI-driver/20180227-054135
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu//drm/sun4i/sun8i_dw_hdmi.h:12:0,
                    from drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c:9:
   drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c: In function 'sun8i_hdmi_phy_config_h3':
>> drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c:188:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
          ~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK, pll_cfg2_init);
          ^
   include/linux/regmap.h:75:36: note: in definition of macro 'regmap_update_bits'
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
                                       ^~~~

vim +188 drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c

b7c7436a Jernej Skrabec 2018-02-14    8  
b7c7436a Jernej Skrabec 2018-02-14   @9  #include "sun8i_dw_hdmi.h"
b7c7436a Jernej Skrabec 2018-02-14   10  
b7c7436a Jernej Skrabec 2018-02-14   11  /*
b7c7436a Jernej Skrabec 2018-02-14   12   * Address can be actually any value. Here is set to same value as
b7c7436a Jernej Skrabec 2018-02-14   13   * it is set in BSP driver.
b7c7436a Jernej Skrabec 2018-02-14   14   */
b7c7436a Jernej Skrabec 2018-02-14   15  #define I2C_ADDR	0x69
b7c7436a Jernej Skrabec 2018-02-14   16  
322900e8 Jernej Skrabec 2018-02-24   17  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
322900e8 Jernej Skrabec 2018-02-24   18  				      struct sun8i_hdmi_phy *phy,
322900e8 Jernej Skrabec 2018-02-24   19  				      unsigned int clk_rate)
b7c7436a Jernej Skrabec 2018-02-14   20  {
b7c7436a Jernej Skrabec 2018-02-14   21  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
b7c7436a Jernej Skrabec 2018-02-14   22  			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
b7c7436a Jernej Skrabec 2018-02-14   23  			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
b7c7436a Jernej Skrabec 2018-02-14   24  
b7c7436a Jernej Skrabec 2018-02-14   25  	/* power down */
b7c7436a Jernej Skrabec 2018-02-14   26  	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
b7c7436a Jernej Skrabec 2018-02-14   27  	dw_hdmi_phy_gen2_pddq(hdmi, 1);
b7c7436a Jernej Skrabec 2018-02-14   28  
b7c7436a Jernej Skrabec 2018-02-14   29  	dw_hdmi_phy_reset(hdmi);
b7c7436a Jernej Skrabec 2018-02-14   30  
b7c7436a Jernej Skrabec 2018-02-14   31  	dw_hdmi_phy_gen2_pddq(hdmi, 0);
b7c7436a Jernej Skrabec 2018-02-14   32  
b7c7436a Jernej Skrabec 2018-02-14   33  	dw_hdmi_phy_i2c_set_addr(hdmi, I2C_ADDR);
b7c7436a Jernej Skrabec 2018-02-14   34  
b7c7436a Jernej Skrabec 2018-02-14   35  	/*
b7c7436a Jernej Skrabec 2018-02-14   36  	 * Values are taken from BSP HDMI driver. Although AW didn't
b7c7436a Jernej Skrabec 2018-02-14   37  	 * release any documentation, explanation of this values can
b7c7436a Jernej Skrabec 2018-02-14   38  	 * be found in i.MX 6Dual/6Quad Reference Manual.
b7c7436a Jernej Skrabec 2018-02-14   39  	 */
322900e8 Jernej Skrabec 2018-02-24   40  	if (clk_rate <= 27000000) {
b7c7436a Jernej Skrabec 2018-02-14   41  		dw_hdmi_phy_i2c_write(hdmi, 0x01e0, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   42  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   43  		dw_hdmi_phy_i2c_write(hdmi, 0x08da, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   44  		dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   45  		dw_hdmi_phy_i2c_write(hdmi, 0x0318, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   46  		dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
322900e8 Jernej Skrabec 2018-02-24   47  	} else if (clk_rate <= 74250000) {
b7c7436a Jernej Skrabec 2018-02-14   48  		dw_hdmi_phy_i2c_write(hdmi, 0x0540, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   49  		dw_hdmi_phy_i2c_write(hdmi, 0x0005, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   50  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   51  		dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   52  		dw_hdmi_phy_i2c_write(hdmi, 0x02b5, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   53  		dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
322900e8 Jernej Skrabec 2018-02-24   54  	} else if (clk_rate <= 148500000) {
b7c7436a Jernej Skrabec 2018-02-14   55  		dw_hdmi_phy_i2c_write(hdmi, 0x04a0, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   56  		dw_hdmi_phy_i2c_write(hdmi, 0x000a, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   57  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   58  		dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   59  		dw_hdmi_phy_i2c_write(hdmi, 0x0021, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   60  		dw_hdmi_phy_i2c_write(hdmi, 0x8029, 0x09);
b7c7436a Jernej Skrabec 2018-02-14   61  	} else {
b7c7436a Jernej Skrabec 2018-02-14   62  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   63  		dw_hdmi_phy_i2c_write(hdmi, 0x000f, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   64  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   65  		dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   66  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   67  		dw_hdmi_phy_i2c_write(hdmi, 0x802b, 0x09);
b7c7436a Jernej Skrabec 2018-02-14   68  	}
b7c7436a Jernej Skrabec 2018-02-14   69  
b7c7436a Jernej Skrabec 2018-02-14   70  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x1e);
b7c7436a Jernej Skrabec 2018-02-14   71  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x13);
b7c7436a Jernej Skrabec 2018-02-14   72  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x17);
b7c7436a Jernej Skrabec 2018-02-14   73  
b7c7436a Jernej Skrabec 2018-02-14   74  	dw_hdmi_phy_gen2_txpwron(hdmi, 1);
b7c7436a Jernej Skrabec 2018-02-14   75  
b7c7436a Jernej Skrabec 2018-02-14   76  	return 0;
2175cff9 Jernej Skrabec 2018-02-24   77  }
2175cff9 Jernej Skrabec 2018-02-24   78  
2175cff9 Jernej Skrabec 2018-02-24   79  static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
2175cff9 Jernej Skrabec 2018-02-24   80  				    struct sun8i_hdmi_phy *phy,
2175cff9 Jernej Skrabec 2018-02-24   81  				    unsigned int clk_rate)
2175cff9 Jernej Skrabec 2018-02-24   82  {
2175cff9 Jernej Skrabec 2018-02-24   83  	u32 pll_cfg1_init;
2175cff9 Jernej Skrabec 2018-02-24   84  	u32 pll_cfg2_init;
2175cff9 Jernej Skrabec 2018-02-24   85  	u32 ana_cfg1_end;
2175cff9 Jernej Skrabec 2018-02-24   86  	u32 ana_cfg2_init;
2175cff9 Jernej Skrabec 2018-02-24   87  	u32 ana_cfg3_init;
2175cff9 Jernej Skrabec 2018-02-24   88  	u32 b_offset = 0;
2175cff9 Jernej Skrabec 2018-02-24   89  	u32 val;
2175cff9 Jernej Skrabec 2018-02-24   90  
2175cff9 Jernej Skrabec 2018-02-24   91  	/* bandwidth / frequency independent settings */
2175cff9 Jernej Skrabec 2018-02-24   92  
2175cff9 Jernej Skrabec 2018-02-24   93  	pll_cfg1_init = SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN |
2175cff9 Jernej Skrabec 2018-02-24   94  			SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN |
2175cff9 Jernej Skrabec 2018-02-24   95  			SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(7) |
2175cff9 Jernej Skrabec 2018-02-24   96  			SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(1) |
2175cff9 Jernej Skrabec 2018-02-24   97  			SUN8I_HDMI_PHY_PLL_CFG1_PLLDBEN |
2175cff9 Jernej Skrabec 2018-02-24   98  			SUN8I_HDMI_PHY_PLL_CFG1_CS |
2175cff9 Jernej Skrabec 2018-02-24   99  			SUN8I_HDMI_PHY_PLL_CFG1_CP_S(2) |
2175cff9 Jernej Skrabec 2018-02-24  100  			SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63) |
2175cff9 Jernej Skrabec 2018-02-24  101  			SUN8I_HDMI_PHY_PLL_CFG1_BWS;
2175cff9 Jernej Skrabec 2018-02-24  102  
2175cff9 Jernej Skrabec 2018-02-24  103  	pll_cfg2_init = SUN8I_HDMI_PHY_PLL_CFG2_SV_H |
2175cff9 Jernej Skrabec 2018-02-24  104  			SUN8I_HDMI_PHY_PLL_CFG2_VCOGAIN_EN |
2175cff9 Jernej Skrabec 2018-02-24  105  			SUN8I_HDMI_PHY_PLL_CFG2_SDIV2;
2175cff9 Jernej Skrabec 2018-02-24  106  
2175cff9 Jernej Skrabec 2018-02-24  107  	ana_cfg1_end = SUN8I_HDMI_PHY_ANA_CFG1_REG_SVBH(1) |
2175cff9 Jernej Skrabec 2018-02-24  108  		       SUN8I_HDMI_PHY_ANA_CFG1_AMP_OPT |
2175cff9 Jernej Skrabec 2018-02-24  109  		       SUN8I_HDMI_PHY_ANA_CFG1_EMP_OPT |
2175cff9 Jernej Skrabec 2018-02-24  110  		       SUN8I_HDMI_PHY_ANA_CFG1_AMPCK_OPT |
2175cff9 Jernej Skrabec 2018-02-24  111  		       SUN8I_HDMI_PHY_ANA_CFG1_EMPCK_OPT |
2175cff9 Jernej Skrabec 2018-02-24  112  		       SUN8I_HDMI_PHY_ANA_CFG1_ENRCAL |
2175cff9 Jernej Skrabec 2018-02-24  113  		       SUN8I_HDMI_PHY_ANA_CFG1_ENCALOG |
2175cff9 Jernej Skrabec 2018-02-24  114  		       SUN8I_HDMI_PHY_ANA_CFG1_REG_SCKTMDS |
2175cff9 Jernej Skrabec 2018-02-24  115  		       SUN8I_HDMI_PHY_ANA_CFG1_TMDSCLK_EN |
2175cff9 Jernej Skrabec 2018-02-24  116  		       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK |
2175cff9 Jernej Skrabec 2018-02-24  117  		       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_ALL |
2175cff9 Jernej Skrabec 2018-02-24  118  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDSCLK |
2175cff9 Jernej Skrabec 2018-02-24  119  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS2 |
2175cff9 Jernej Skrabec 2018-02-24  120  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS1 |
2175cff9 Jernej Skrabec 2018-02-24  121  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS0 |
2175cff9 Jernej Skrabec 2018-02-24  122  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS2 |
2175cff9 Jernej Skrabec 2018-02-24  123  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS1 |
2175cff9 Jernej Skrabec 2018-02-24  124  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS0 |
2175cff9 Jernej Skrabec 2018-02-24  125  		       SUN8I_HDMI_PHY_ANA_CFG1_CKEN |
2175cff9 Jernej Skrabec 2018-02-24  126  		       SUN8I_HDMI_PHY_ANA_CFG1_LDOEN |
2175cff9 Jernej Skrabec 2018-02-24  127  		       SUN8I_HDMI_PHY_ANA_CFG1_ENVBS |
2175cff9 Jernej Skrabec 2018-02-24  128  		       SUN8I_HDMI_PHY_ANA_CFG1_ENBI;
2175cff9 Jernej Skrabec 2018-02-24  129  
2175cff9 Jernej Skrabec 2018-02-24  130  	ana_cfg2_init = SUN8I_HDMI_PHY_ANA_CFG2_M_EN |
2175cff9 Jernej Skrabec 2018-02-24  131  			SUN8I_HDMI_PHY_ANA_CFG2_REG_DENCK |
2175cff9 Jernej Skrabec 2018-02-24  132  			SUN8I_HDMI_PHY_ANA_CFG2_REG_DEN |
2175cff9 Jernej Skrabec 2018-02-24  133  			SUN8I_HDMI_PHY_ANA_CFG2_REG_CKSS(1) |
2175cff9 Jernej Skrabec 2018-02-24  134  			SUN8I_HDMI_PHY_ANA_CFG2_REG_CSMPS(1);
2175cff9 Jernej Skrabec 2018-02-24  135  
2175cff9 Jernej Skrabec 2018-02-24  136  	ana_cfg3_init = SUN8I_HDMI_PHY_ANA_CFG3_REG_WIRE(0x3e0) |
2175cff9 Jernej Skrabec 2018-02-24  137  			SUN8I_HDMI_PHY_ANA_CFG3_SDAEN |
2175cff9 Jernej Skrabec 2018-02-24  138  			SUN8I_HDMI_PHY_ANA_CFG3_SCLEN;
2175cff9 Jernej Skrabec 2018-02-24  139  
2175cff9 Jernej Skrabec 2018-02-24  140  	/* bandwidth / frequency dependent settings */
2175cff9 Jernej Skrabec 2018-02-24  141  	if (clk_rate <= 27000000) {
2175cff9 Jernej Skrabec 2018-02-24  142  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  143  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  144  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  145  				 SUN8I_HDMI_PHY_PLL_CFG2_S(4);
2175cff9 Jernej Skrabec 2018-02-24  146  		ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
2175cff9 Jernej Skrabec 2018-02-24  147  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
2175cff9 Jernej Skrabec 2018-02-24  148  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
2175cff9 Jernej Skrabec 2018-02-24  149  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(3) |
2175cff9 Jernej Skrabec 2018-02-24  150  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(5);
2175cff9 Jernej Skrabec 2018-02-24  151  	} else if (clk_rate <= 74250000) {
2175cff9 Jernej Skrabec 2018-02-24  152  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  153  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  154  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  155  				 SUN8I_HDMI_PHY_PLL_CFG2_S(5);
2175cff9 Jernej Skrabec 2018-02-24  156  		ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
2175cff9 Jernej Skrabec 2018-02-24  157  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
2175cff9 Jernej Skrabec 2018-02-24  158  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
2175cff9 Jernej Skrabec 2018-02-24  159  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(5) |
2175cff9 Jernej Skrabec 2018-02-24  160  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(7);
2175cff9 Jernej Skrabec 2018-02-24  161  	} else if (clk_rate <= 148500000) {
2175cff9 Jernej Skrabec 2018-02-24  162  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  163  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  164  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  165  				 SUN8I_HDMI_PHY_PLL_CFG2_S(6);
2175cff9 Jernej Skrabec 2018-02-24  166  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
2175cff9 Jernej Skrabec 2018-02-24  167  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
2175cff9 Jernej Skrabec 2018-02-24  168  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(2);
2175cff9 Jernej Skrabec 2018-02-24  169  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(7) |
2175cff9 Jernej Skrabec 2018-02-24  170  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(9);
2175cff9 Jernej Skrabec 2018-02-24  171  	} else {
2175cff9 Jernej Skrabec 2018-02-24  172  		b_offset = 2;
2175cff9 Jernej Skrabec 2018-02-24  173  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63);
2175cff9 Jernej Skrabec 2018-02-24  174  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(6) |
2175cff9 Jernej Skrabec 2018-02-24  175  				 SUN8I_HDMI_PHY_PLL_CFG2_S(7);
2175cff9 Jernej Skrabec 2018-02-24  176  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
2175cff9 Jernej Skrabec 2018-02-24  177  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
2175cff9 Jernej Skrabec 2018-02-24  178  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4);
2175cff9 Jernej Skrabec 2018-02-24  179  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(9) |
2175cff9 Jernej Skrabec 2018-02-24  180  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(13);
2175cff9 Jernej Skrabec 2018-02-24  181  	}
2175cff9 Jernej Skrabec 2018-02-24  182  
2175cff9 Jernej Skrabec 2018-02-24  183  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  184  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
2175cff9 Jernej Skrabec 2018-02-24  185  
2175cff9 Jernej Skrabec 2018-02-24  186  	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
2175cff9 Jernej Skrabec 2018-02-24  187  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
2175cff9 Jernej Skrabec 2018-02-24 @188  			   ~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK, pll_cfg2_init);
2175cff9 Jernej Skrabec 2018-02-24  189  	usleep_range(10000, 15000);
2175cff9 Jernej Skrabec 2018-02-24  190  	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG3_REG,
2175cff9 Jernej Skrabec 2018-02-24  191  		     SUN8I_HDMI_PHY_PLL_CFG3_SOUT_DIV2);
2175cff9 Jernej Skrabec 2018-02-24  192  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  193  			   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN,
2175cff9 Jernej Skrabec 2018-02-24  194  			   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN);
2175cff9 Jernej Skrabec 2018-02-24  195  	msleep(100);
2175cff9 Jernej Skrabec 2018-02-24  196  
2175cff9 Jernej Skrabec 2018-02-24  197  	/* get B value */
2175cff9 Jernej Skrabec 2018-02-24  198  	regmap_read(phy->regs, SUN8I_HDMI_PHY_ANA_STS_REG, &val);
2175cff9 Jernej Skrabec 2018-02-24  199  	val = (val & SUN8I_HDMI_PHY_ANA_STS_B_OUT_MSK) >>
2175cff9 Jernej Skrabec 2018-02-24  200  		SUN8I_HDMI_PHY_ANA_STS_B_OUT_SHIFT;
2175cff9 Jernej Skrabec 2018-02-24  201  	val = min(val + b_offset, (u32)0x3f);
2175cff9 Jernej Skrabec 2018-02-24  202  
2175cff9 Jernej Skrabec 2018-02-24  203  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  204  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
2175cff9 Jernej Skrabec 2018-02-24  205  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD,
2175cff9 Jernej Skrabec 2018-02-24  206  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
2175cff9 Jernej Skrabec 2018-02-24  207  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD);
2175cff9 Jernej Skrabec 2018-02-24  208  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  209  			   SUN8I_HDMI_PHY_PLL_CFG1_B_IN_MSK,
2175cff9 Jernej Skrabec 2018-02-24  210  			   val << SUN8I_HDMI_PHY_PLL_CFG1_B_IN_SHIFT);
2175cff9 Jernej Skrabec 2018-02-24  211  	msleep(100);
2175cff9 Jernej Skrabec 2018-02-24  212  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG, ana_cfg1_end);
2175cff9 Jernej Skrabec 2018-02-24  213  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG2_REG, ana_cfg2_init);
2175cff9 Jernej Skrabec 2018-02-24  214  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG3_REG, ana_cfg3_init);
2175cff9 Jernej Skrabec 2018-02-24  215  
2175cff9 Jernej Skrabec 2018-02-24  216  	return 0;
2175cff9 Jernej Skrabec 2018-02-24  217  }
b7c7436a Jernej Skrabec 2018-02-14  218  

:::::: The code at line 188 was first introduced by commit
:::::: 2175cff9150f7944c01f90b9354f35b976362d0b drm/sun4i: Add support for H3 HDMI PHY variant

:::::: TO: Jernej Skrabec <jernej.skrabec@siol.net>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/9a2ef36f/attachment-0001.gz>
