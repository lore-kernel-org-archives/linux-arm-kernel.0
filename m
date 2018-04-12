From: lkp@intel.com (kbuild test robot)
Date: Thu, 12 Apr 2018 11:11:38 +0800
Subject: [PATCH 2/5] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
In-Reply-To: <1523440025-18077-3-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <201804121018.KrTZRo5n%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amelie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.16]
[cannot apply to next-20180411]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amelie-Delaunay/Introduce-STMFX-I2C-GPIO-expander/20180412-082837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-stmfx.c: In function 'stmfx_resume':
>> drivers/pinctrl/pinctrl-stmfx.c:949:3: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
      regulator_enable(stmfx->vdd);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/regulator_enable +949 drivers/pinctrl/pinctrl-stmfx.c

   943	
   944	static int stmfx_resume(struct device *dev)
   945	{
   946		struct stmfx *stmfx = dev_get_drvdata(dev);
   947	
   948		if (!IS_ERR(stmfx->vdd))
 > 949			regulator_enable(stmfx->vdd);
   950	
   951		/* Restore IRQ_OUT_PIN register */
   952		stmfx_irq_init(stmfx);
   953	
   954		/* Restore SYS_CTRL register */
   955		stmfx_gpio_function_enable(stmfx, stmfx->pctl->gpio_chip.ngpio);
   956	
   957		/* Restore all GPIO expander function relative registers */
   958		stmfx_gpio_restore_regs(stmfx->pctl);
   959	
   960		return 0;
   961	}
   962	#endif
   963	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53491 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/d751dd16/attachment-0001.gz>
