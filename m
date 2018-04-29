From: lkp@intel.com (kbuild test robot)
Date: Sun, 29 Apr 2018 18:59:54 +0800
Subject: [PATCH v3] clk: at91: PLL recalc_rate() now using cached MUL+DIV
 values
In-Reply-To: <20180427175609.GA83298@hak8or>
References: <20180427175609.GA83298@hak8or>
Message-ID: <201804291635.81zGTBNg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.17-rc2]
[also build test ERROR on next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marcin-Ziemianowicz/clk-at91-PLL-recalc_rate-now-using-cached-MUL-DIV-values/20180429-134826
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/clk/at91/clk-pll.c: In function 'clk_pll_recalc_rate':
>> drivers/clk/at91/clk-pll.c:136:9: error: expected expression before 'return'
     return return (parent_rate / pll->div) * (pll->mul + 1);
            ^~~~~~
   drivers/clk/at91/clk-pll.c:134:18: warning: unused variable 'pll' [-Wunused-variable]
     struct clk_pll *pll = to_clk_pll(hw);
                     ^~~
>> drivers/clk/at91/clk-pll.c:137:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +/return +136 drivers/clk/at91/clk-pll.c

   130	
   131	static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
   132						 unsigned long parent_rate)
   133	{
   134		struct clk_pll *pll = to_clk_pll(hw);
   135	
 > 136		return return (parent_rate / pll->div) * (pll->mul + 1);
 > 137	}
   138	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23245 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180429/06d90c2a/attachment-0001.gz>
