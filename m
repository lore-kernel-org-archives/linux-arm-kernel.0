From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 29 Dec 2017 08:53:06 +0800
Subject: [clk:clk-next 20/21] drivers/clk/sprd/div.c:42:9: error: too few
 arguments to function 'divider_recalc_rate'
Message-ID: <201712290803.E0awnApy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   e717a189b1bc52a60f8c1177f277e4b6c2f0ae53
commit: 4508d70e6a5e9ad186dd4110e59f33d20483eb31 [20/21] Merge branch 'clk-divider-container' into clk-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4508d70e6a5e9ad186dd4110e59f33d20483eb31
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   drivers/clk/sprd/div.c: In function 'sprd_div_helper_recalc_rate':
>> drivers/clk/sprd/div.c:42:9: error: too few arguments to function 'divider_recalc_rate'
     return divider_recalc_rate(&common->hw, parent_rate, val, NULL, 0);
            ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/sprd/div.c:8:0:
   include/linux/clk-provider.h:413:15: note: declared here
    unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
                  ^~~~~~~~~~~~~~~~~~~
>> drivers/clk/sprd/div.c:43:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +/divider_recalc_rate +42 drivers/clk/sprd/div.c

e3f05d3b Chunyan Zhang 2017-12-07  30  
e3f05d3b Chunyan Zhang 2017-12-07  31  unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
e3f05d3b Chunyan Zhang 2017-12-07  32  					  const struct sprd_div_internal *div,
e3f05d3b Chunyan Zhang 2017-12-07  33  					  unsigned long parent_rate)
e3f05d3b Chunyan Zhang 2017-12-07  34  {
e3f05d3b Chunyan Zhang 2017-12-07  35  	unsigned long val;
e3f05d3b Chunyan Zhang 2017-12-07  36  	unsigned int reg;
e3f05d3b Chunyan Zhang 2017-12-07  37  
e3f05d3b Chunyan Zhang 2017-12-07  38  	regmap_read(common->regmap, common->reg, &reg);
e3f05d3b Chunyan Zhang 2017-12-07  39  	val = reg >> div->shift;
e3f05d3b Chunyan Zhang 2017-12-07  40  	val &= (1 << div->width) - 1;
e3f05d3b Chunyan Zhang 2017-12-07  41  
e3f05d3b Chunyan Zhang 2017-12-07 @42  	return divider_recalc_rate(&common->hw, parent_rate, val, NULL, 0);
e3f05d3b Chunyan Zhang 2017-12-07 @43  }
e3f05d3b Chunyan Zhang 2017-12-07  44  EXPORT_SYMBOL_GPL(sprd_div_helper_recalc_rate);
e3f05d3b Chunyan Zhang 2017-12-07  45  

:::::: The code at line 42 was first introduced by commit
:::::: e3f05d3b18e6cfbddaed687b4a57c280015acc1f clk: sprd: add divider clock support

:::::: TO: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37504 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/c2ef5cf5/attachment-0001.gz>
