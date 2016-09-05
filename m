From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Sep 2016 09:43:27 +0800
Subject: [PATCH v4 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <20160904182320.671-5-martin.blumenstingl@googlemail.com>
Message-ID: <201609050935.igtFZIAr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

[auto build test ERROR on next-20160825]
[also build test ERROR on v4.8-rc5]
[cannot apply to robh/for-next net-next/master net/master v4.8-rc4 v4.8-rc3 v4.8-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/meson-Meson8b-and-GXBB-DWMAC-glue-driver/20160905-023130
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:63:18: error: field 'm250_mux' has incomplete type
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:67:21: error: field 'm250_div' has incomplete type
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:70:21: error: field 'm25_div' has incomplete type
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c: In function 'meson8b_init_clk':
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:88:23: error: storage size of 'init' isn't known
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:94:30: error: array type has incomplete element type
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:3: error: field name not in record or union initializer
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:3: error: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:3: error: field name not in record or union initializer
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:3: error: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:3: error: field name not in record or union initializer
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:3: error: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:3: error: field name not in record or union initializer
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:3: error: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:114:4: error: implicit declaration of function '__clk_get_name'
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:113:23: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:120:14: error: 'clk_mux_ops' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:120:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:132:2: error: implicit declaration of function 'devm_clk_register'
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:139:14: error: 'clk_divider_ops' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:140:15: error: 'CLK_SET_RATE_PARENT' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:141:21: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:149:26: error: 'CLK_DIVIDER_ONE_BASED' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:149:50: error: 'CLK_DIVIDER_ALLOW_ZERO' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:159:15: error: 'CLK_IS_BASIC' undeclared (first use in this function)
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:160:21: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:94:30: warning: unused variable 'clk_25m_div_table'
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:88:23: warning: unused variable 'init'
   cc1: some warnings being treated as errors

vim +94 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

    57		struct platform_device	*pdev;
    58	
    59		void __iomem		*regs;
    60	
    61		phy_interface_t		phy_mode;
    62	
  > 63		struct clk_mux		m250_mux;
    64		struct clk		*m250_mux_clk;
    65		struct clk		*m250_mux_parent[MUX_CLK_NUM_PARENTS];
    66	
    67		struct clk_divider	m250_div;
    68		struct clk		*m250_div_clk;
    69	
    70		struct clk_divider	m25_div;
    71		struct clk		*m25_div_clk;
    72	};
    73	
    74	static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
    75					    u32 mask, u32 value)
    76	{
    77		u32 data;
    78	
    79		data = readl(dwmac->regs + reg);
    80		data &= ~mask;
    81		data |= (value & mask);
    82	
    83		writel(data, dwmac->regs + reg);
    84	}
    85	
    86	static int meson8b_init_clk(struct meson8b_dwmac *dwmac)
    87	{
    88		struct clk_init_data init;
    89		int i, ret;
    90		struct device *dev = &dwmac->pdev->dev;
    91		char clk_name[32];
    92		const char *clk_div_parents[1];
    93		const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
  > 94		static struct clk_div_table clk_25m_div_table[] = {
    95			{ .val = 0, .div = 5 },
    96			{ .val = 1, .div = 10 },
    97			{ /* sentinel */ },

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45742 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/f6bd4e54/attachment-0001.obj>
