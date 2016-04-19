From: lkp@intel.com (kbuild test robot)
Date: Tue, 19 Apr 2016 20:38:04 +0800
Subject: [PATCH 3/8] gpio: stmpe: fix edge and rising/falling edge
 detection
In-Reply-To: <1461068317-28016-4-git-send-email-patrice.chotard@st.com>
Message-ID: <201604192051.Uq459IuG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.6-rc4 next-20160419]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/patrice-chotard-st-com/STMPE-fixes-rework-and-add-STMPE1600-support/20160419-202526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-randconfig-x010-201616 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-stmpe.c: In function 'stmpe_dbg_show':
>> drivers/gpio/gpio-stmpe.c:284:3: warning: 'fall' may be used uninitialized in this function [-Wmaybe-uninitialized]
      seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s %s%s%s",
      ^
   drivers/gpio/gpio-stmpe.c:240:8: note: 'fall' was declared here
      bool fall;
           ^
>> drivers/gpio/gpio-stmpe.c:284:3: warning: 'rise' may be used uninitialized in this function [-Wmaybe-uninitialized]
      seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s %s%s%s",
      ^
   drivers/gpio/gpio-stmpe.c:239:8: note: 'rise' was declared here
      bool rise;
           ^
>> drivers/gpio/gpio-stmpe.c:284:3: warning: 'edge_det' may be used uninitialized in this function [-Wmaybe-uninitialized]
      seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s %s%s%s",
      ^
   drivers/gpio/gpio-stmpe.c:238:8: note: 'edge_det' was declared here
      bool edge_det;
           ^

vim +/fall +284 drivers/gpio/gpio-stmpe.c

98190e59 Patrice Chotard 2016-04-19  234  		u8 edge_det_reg;
98190e59 Patrice Chotard 2016-04-19  235  		u8 rise_reg;
98190e59 Patrice Chotard 2016-04-19  236  		u8 fall_reg;
98190e59 Patrice Chotard 2016-04-19  237  		u8 irqen_reg;
27ec8a9c Linus Walleij   2014-10-02  238  		bool edge_det;
27ec8a9c Linus Walleij   2014-10-02  239  		bool rise;
27ec8a9c Linus Walleij   2014-10-02 @240  		bool fall;
27ec8a9c Linus Walleij   2014-10-02  241  		bool irqen;
27ec8a9c Linus Walleij   2014-10-02  242  
98190e59 Patrice Chotard 2016-04-19  243  		switch (stmpe->partnum) {
98190e59 Patrice Chotard 2016-04-19  244  		case STMPE610:
98190e59 Patrice Chotard 2016-04-19  245  		case STMPE811:
98190e59 Patrice Chotard 2016-04-19  246  		case STMPE1601:
98190e59 Patrice Chotard 2016-04-19  247  		case STMPE2401:
98190e59 Patrice Chotard 2016-04-19  248  		case STMPE2403:
98190e59 Patrice Chotard 2016-04-19  249  			edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] +
98190e59 Patrice Chotard 2016-04-19  250  				       num_banks - 1 - (offset / 8);
27ec8a9c Linus Walleij   2014-10-02  251  			ret = stmpe_reg_read(stmpe, edge_det_reg);
27ec8a9c Linus Walleij   2014-10-02  252  			if (ret < 0)
27ec8a9c Linus Walleij   2014-10-02  253  				return;
27ec8a9c Linus Walleij   2014-10-02  254  			edge_det = !!(ret & mask);
98190e59 Patrice Chotard 2016-04-19  255  
98190e59 Patrice Chotard 2016-04-19  256  		case STMPE1801:
98190e59 Patrice Chotard 2016-04-19  257  			rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] -
98190e59 Patrice Chotard 2016-04-19  258  				   (offset / 8);
98190e59 Patrice Chotard 2016-04-19  259  			fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] -
98190e59 Patrice Chotard 2016-04-19  260  				   (offset / 8);
27ec8a9c Linus Walleij   2014-10-02  261  			ret = stmpe_reg_read(stmpe, rise_reg);
27ec8a9c Linus Walleij   2014-10-02  262  			if (ret < 0)
27ec8a9c Linus Walleij   2014-10-02  263  				return;
27ec8a9c Linus Walleij   2014-10-02  264  			rise = !!(ret & mask);
27ec8a9c Linus Walleij   2014-10-02  265  			ret = stmpe_reg_read(stmpe, fall_reg);
27ec8a9c Linus Walleij   2014-10-02  266  			if (ret < 0)
27ec8a9c Linus Walleij   2014-10-02  267  				return;
27ec8a9c Linus Walleij   2014-10-02  268  			fall = !!(ret & mask);
98190e59 Patrice Chotard 2016-04-19  269  
98190e59 Patrice Chotard 2016-04-19  270  		case STMPE801:
98190e59 Patrice Chotard 2016-04-19  271  			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] -
98190e59 Patrice Chotard 2016-04-19  272  				    (offset / 8);
98190e59 Patrice Chotard 2016-04-19  273  			break;
98190e59 Patrice Chotard 2016-04-19  274  
98190e59 Patrice Chotard 2016-04-19  275  		default:
98190e59 Patrice Chotard 2016-04-19  276  			return;
98190e59 Patrice Chotard 2016-04-19  277  		}
98190e59 Patrice Chotard 2016-04-19  278  
27ec8a9c Linus Walleij   2014-10-02  279  		ret = stmpe_reg_read(stmpe, irqen_reg);
27ec8a9c Linus Walleij   2014-10-02  280  		if (ret < 0)
27ec8a9c Linus Walleij   2014-10-02  281  			return;
27ec8a9c Linus Walleij   2014-10-02  282  		irqen = !!(ret & mask);
27ec8a9c Linus Walleij   2014-10-02  283  
27ec8a9c Linus Walleij   2014-10-02 @284  		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s %s%s%s",
27ec8a9c Linus Walleij   2014-10-02  285  			   gpio, label ?: "(none)",
27ec8a9c Linus Walleij   2014-10-02  286  			   val ? "hi" : "lo",
27ec8a9c Linus Walleij   2014-10-02  287  			   edge_det ? "edge-asserted" : "edge-inactive",

:::::: The code at line 284 was first introduced by commit
:::::: 27ec8a9cb504e9995c123dc74e0cca0cba81d07f gpio: stmpe: add verbose debug code

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23724 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/e78f1935/attachment-0001.obj>
