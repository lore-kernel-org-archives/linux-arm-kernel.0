From: lkp@intel.com (kbuild test robot)
Date: Sun, 4 Oct 2015 01:29:26 +0800
Subject: [PATCH 1/4] ARM: OMAP: dmtimer: check for fixed timers during
 config
In-Reply-To: <1443727960-32232-2-git-send-email-s-anna@ti.com>
Message-ID: <201510040126.SfMisWv2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm-omap1_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   arch/arm/plat-omap/dmtimer.c: In function 'omap_dm_timer_set_source':
>> arch/arm/plat-omap/dmtimer.c:509:2: error: implicit declaration of function 'clk_hw_get_num_parents' [-Werror=implicit-function-declaration]
     if (!clk_hw_get_num_parents(__clk_get_hw(timer->fclk)))
     ^
>> arch/arm/plat-omap/dmtimer.c:509:2: error: implicit declaration of function '__clk_get_hw' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/clk_hw_get_num_parents +509 arch/arm/plat-omap/dmtimer.c

   503			return pdata->set_timer_src(timer->pdev, source);
   504	
   505		if (IS_ERR(timer->fclk))
   506			return -EINVAL;
   507	
   508		/* Check if the clock has parents if not no point checking */
 > 509		if (!clk_hw_get_num_parents(__clk_get_hw(timer->fclk)))
   510			return 0;
   511	
   512		switch (source) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18413 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151004/25ce697a/attachment-0001.obj>
