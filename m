From: lkp@intel.com (kbuild test robot)
Date: Sat, 15 Jul 2017 02:52:30 +0800
Subject: [PATCH v5 1/2] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1499954552-20075-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <201707150222.ogIMUhKu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.12 next-20170714]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/gabriel-fernandez-st-com/clk-stm32h7-Add-stm32h743-clock-driver/20170714-170518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-lpc32xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/clk/nxp/clk-lpc32xx.c:906:12: error: static declaration of 'clk_gate_is_enabled' follows non-static declaration
    static int clk_gate_is_enabled(struct clk_hw *hw)
               ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/nxp/clk-lpc32xx.c:13:0:
   include/linux/clk-provider.h:346:5: note: previous declaration of 'clk_gate_is_enabled' was here
    int clk_gate_is_enabled(struct clk_hw *hw);
        ^~~~~~~~~~~~~~~~~~~

vim +/clk_gate_is_enabled +906 drivers/clk/nxp/clk-lpc32xx.c

f7c82a60 Vladimir Zapolskiy 2015-12-06  905  
f7c82a60 Vladimir Zapolskiy 2015-12-06 @906  static int clk_gate_is_enabled(struct clk_hw *hw)
f7c82a60 Vladimir Zapolskiy 2015-12-06  907  {
f7c82a60 Vladimir Zapolskiy 2015-12-06  908  	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
f7c82a60 Vladimir Zapolskiy 2015-12-06  909  	u32 val;
f7c82a60 Vladimir Zapolskiy 2015-12-06  910  	bool is_set;
f7c82a60 Vladimir Zapolskiy 2015-12-06  911  
f7c82a60 Vladimir Zapolskiy 2015-12-06  912  	regmap_read(clk_regmap, clk->reg, &val);
f7c82a60 Vladimir Zapolskiy 2015-12-06  913  	is_set = val & BIT(clk->bit_idx);
f7c82a60 Vladimir Zapolskiy 2015-12-06  914  
f7c82a60 Vladimir Zapolskiy 2015-12-06  915  	return (clk->flags & CLK_GATE_SET_TO_DISABLE ? !is_set : is_set);
f7c82a60 Vladimir Zapolskiy 2015-12-06  916  }
f7c82a60 Vladimir Zapolskiy 2015-12-06  917  

:::::: The code at line 906 was first introduced by commit
:::::: f7c82a60ba26c2f003662bcb2cff131021c1e828 clk: lpc32xx: add common clock framework driver

:::::: TO: Vladimir Zapolskiy <vz@mleia.com>
:::::: CC: Michael Turquette <mturquette@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21155 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170715/e8e16a82/attachment-0001.gz>
