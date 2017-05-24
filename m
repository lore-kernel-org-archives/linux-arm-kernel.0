From: lkp@intel.com (kbuild test robot)
Date: Wed, 24 May 2017 21:55:28 +0800
Subject: [PATCH v11 7/9] coresight: add support for CPU debug module
In-Reply-To: <1495548980-30432-8-git-send-email-leo.yan@linaro.org>
Message-ID: <201705242111.zHlVfVnY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

[auto build test WARNING on next-20170522]
[cannot apply to linus/master linux/master robh/for-next v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.12-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Leo-Yan/coresight-enable-debug-module/20170524-075217
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-cpu-debug.c: In function 'debug_adjust_pc':
>> drivers/hwtracing/coresight/coresight-cpu-debug.c:263:44: warning: left shift count >= width of type [-Wshift-count-overflow]
      return (unsigned long)drvdata->edpcsr_hi << 32 |
                                               ^~

vim +263 drivers/hwtracing/coresight/coresight-cpu-debug.c

   247		if (drvdata->edvidsr_present)
   248			drvdata->edvidsr = readl_relaxed(drvdata->base + EDVIDSR);
   249	
   250	out:
   251		/* Restore EDPRCR register */
   252		writel_relaxed(save_edprcr, drvdata->base + EDPRCR);
   253	
   254		CS_LOCK(drvdata->base);
   255	}
   256	
   257	static unsigned long debug_adjust_pc(struct debug_drvdata *drvdata)
   258	{
   259		unsigned long arm_inst_offset = 0, thumb_inst_offset = 0;
   260		unsigned long pc;
   261	
   262		if (IS_ENABLED(CONFIG_64BIT))
 > 263			return (unsigned long)drvdata->edpcsr_hi << 32 |
   264			       (unsigned long)drvdata->edpcsr;
   265	
   266		pc = (unsigned long)drvdata->edpcsr;
   267	
   268		if (drvdata->pc_has_offset) {
   269			arm_inst_offset = 8;
   270			thumb_inst_offset = 4;
   271		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62479 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/349c38a2/attachment-0001.gz>
