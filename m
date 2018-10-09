From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 02:49:05 +0800
Subject: [xlnx:master 1870/2013]
 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c:130:21: warning:
 cast from pointer to integer of different size
Message-ID: <201810100203.5q7gpxzS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: 74788b36bff8a38bd9070823a3e5e03dcb77c99c [1870/2013] staging: clocking-wizard: Add support for dynamic reconfiguration
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 74788b36bff8a38bd9070823a3e5e03dcb77c99c
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c: In function 'clk_wzrd_recalc_rate':
>> drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c:130:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       (void __iomem *)((u64)divider->base + divider->offset);
                        ^
>> drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c:130:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       (void __iomem *)((u64)divider->base + divider->offset);
       ^
   drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c: In function 'clk_wzrd_dynamic_reconfig':
   drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c:150:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       (void __iomem *)((u64)divider->base + divider->offset);
                        ^
   drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c:150:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       (void __iomem *)((u64)divider->base + divider->offset);
       ^

vim +130 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c

   124	
   125	static unsigned long clk_wzrd_recalc_rate(struct clk_hw *hw,
   126						  unsigned long parent_rate)
   127	{
   128		struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
   129		void __iomem *div_addr =
 > 130				(void __iomem *)((u64)divider->base + divider->offset);
   131		unsigned int val;
   132	
   133		val = readl(div_addr) >> divider->shift;
   134		val &= div_mask(divider->width);
   135	
   136		return divider_recalc_rate(hw, parent_rate, val, divider->table,
   137				divider->flags);
   138	}
   139	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/c6472d3b/attachment-0001.gz>
