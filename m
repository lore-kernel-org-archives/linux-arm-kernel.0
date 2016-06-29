From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 02:31:33 +0800
Subject: [PATCH V2 7/8] clk: imx7d: using api with flag
 CLK_OPS_PARENT_ENABLE
In-Reply-To: <1467212351-16626-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606300234.RnWQraE7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.7-rc5 next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-core-support-clocks-which-requires-parents-enable/20160629-231445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-imx_v6_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx7d.c:23:0:
   drivers/clk/imx/clk.h: In function 'imx_clk_divider2':
   drivers/clk/imx/clk.h:104:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h:104:26: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clk/imx/clk.h: In function 'imx_clk_gate3':
   drivers/clk/imx/clk.h:148:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h: In function 'imx_clk_gate4':
   drivers/clk/imx/clk.h:156:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h: In function 'imx_clk_mux2':
   drivers/clk/imx/clk.h:172:31: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ON,
                                  ^
>> drivers/clk/imx/clk.h:174:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/clk/imx/clk.h: In function 'imx_clk_gate3':
   drivers/clk/imx/clk.h:150:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/clk/imx/clk.h: In function 'imx_clk_divider2':
   drivers/clk/imx/clk.h:106:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/clk/imx/clk.h: In function 'imx_clk_gate4':
   drivers/clk/imx/clk.h:158:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +174 drivers/clk/imx/clk.h

236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  150  }
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  151  
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  152  static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  153  		void __iomem *reg, u8 shift)
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  154  {
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  155  	return clk_register_gate2(NULL, name, parent,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29 @156  			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  157  			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  158  }
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  159  
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  160  static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  161  		u8 shift, u8 width, const char **parents, int num_parents)
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  162  {
819c1de3 arch/arm/mach-imx/clk.h James Hogan   2013-07-29  163  	return clk_register_mux(NULL, name, parents, num_parents,
819c1de3 arch/arm/mach-imx/clk.h James Hogan   2013-07-29  164  			CLK_SET_RATE_NO_REPARENT, reg, shift,
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  165  			width, 0, &imx_ccm_lock);
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  166  }
6c7b0685 arch/arm/mach-imx/clk.h Sascha Hauer  2012-03-07  167  
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  168  static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  169  		u8 shift, u8 width, const char **parents, int num_parents)
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  170  {
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  171  	return clk_register_mux(NULL, name, parents, num_parents,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  172  			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ON,
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  173  			reg, shift, width, 0, &imx_ccm_lock);
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29 @174  }
236d68c6 drivers/clk/imx/clk.h   Dong Aisheng  2016-06-29  175  
3ce92170 arch/arm/mach-imx/clk.h Philipp Zabel 2013-03-27  176  static inline struct clk *imx_clk_mux_flags(const char *name,
3ce92170 arch/arm/mach-imx/clk.h Philipp Zabel 2013-03-27  177  		void __iomem *reg, u8 shift, u8 width, const char **parents,

:::::: The code at line 174 was first introduced by commit
:::::: 236d68c6e8a8cbe8757cc0da7f625b1e8202bcaa clk: imx: add clk api for supporting CLK_OPS_PARENT_ENABLE clocks

:::::: TO: Dong Aisheng <aisheng.dong@nxp.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29841 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/eefbb657/attachment-0001.obj>
