From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 09:56:35 +0800
Subject: [PATCH 8/8] [media] s5p-mfc: Use clk bulk API
In-Reply-To: <1519055046-2399-9-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-9-git-send-email-m.purski@samsung.com>
Message-ID: <201802200934.6OQHn9ra%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.16-rc2 next-20180219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Use-clk-bulk-API-in-exynos5433-drivers/20180220-054431
base:   git://linuxtv.org/media_tree.git master
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/media/platform/s5p-mfc/s5p_mfc_pm.c: In function 's5p_mfc_init_pm':
>> drivers/media/platform/s5p-mfc/s5p_mfc_pm.c:39:7: warning: passing argument 3 of 'devm_clk_bulk_alloc' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
          pm->clk_names);
          ^~
   In file included from drivers/media/platform/s5p-mfc/s5p_mfc_pm.c:13:0:
   include/linux/clk.h:654:37: note: expected 'const char **' but argument is of type 'const char * const*'
    static inline struct clk_bulk_data *devm_clk_bulk_alloc(struct device *dev,
                                        ^~~~~~~~~~~~~~~~~~~

vim +39 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c

    24	
    25	int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
    26	{
    27		int ret;
    28	
    29		pm = &dev->pm;
    30		p_dev = dev;
    31	
    32		pm->num_clocks = dev->variant->num_clocks;
    33		pm->clk_names = dev->variant->clk_names;
    34		pm->device = &dev->plat_dev->dev;
    35		pm->clock_gate = NULL;
    36	
    37		/* clock control */
    38		pm->clocks = devm_clk_bulk_alloc(pm->device, pm->num_clocks,
  > 39						 pm->clk_names);
    40		if (IS_ERR(pm->clocks))
    41			return PTR_ERR(pm->clocks);
    42	
    43		ret = devm_clk_bulk_get(pm->device, pm->num_clocks, pm->clocks);
    44		if (ret < 0)
    45			return ret;
    46	
    47		if (dev->variant->use_clock_gating)
    48			pm->clock_gate = pm->clocks[0].clk;
    49	
    50		pm_runtime_enable(pm->device);
    51		atomic_set(&clk_ref, 0);
    52		return 0;
    53	}
    54	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53401 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180220/403d2ce6/attachment-0001.gz>
