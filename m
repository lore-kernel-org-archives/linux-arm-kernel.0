From: lkp@intel.com (kbuild test robot)
Date: Fri, 19 Jan 2018 15:28:27 +0800
Subject: [patch v17 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1516087139-7510-3-git-send-email-oleksandrs@mellanox.com>
References: <1516087139-7510-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201801191425.thXhXD7a%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc8]
[cannot apply to next-20180118]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/drivers-jtag-Add-JTAG-core-driver/20180119-123719
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: the linux-review/Oleksandr-Shamray/drivers-jtag-Add-JTAG-core-driver/20180119-123719 HEAD b9c3d4721186f8264960ad87c6c499cdd1b6c2e8 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers/jtag/jtag-aspeed.c: In function 'aspeed_jtag_init':
>> drivers/jtag/jtag-aspeed.c:657:21: error: implicit declaration of function 'devm_reset_control_get_shared'; did you mean 'devm_pinctrl_get_select'? [-Werror=implicit-function-declaration]
     aspeed_jtag->rst = devm_reset_control_get_shared(aspeed_jtag->dev,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        devm_pinctrl_get_select
>> drivers/jtag/jtag-aspeed.c:657:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     aspeed_jtag->rst = devm_reset_control_get_shared(aspeed_jtag->dev,
                      ^
>> drivers/jtag/jtag-aspeed.c:664:2: error: implicit declaration of function 'reset_control_deassert' [-Werror=implicit-function-declaration]
     reset_control_deassert(aspeed_jtag->rst);
     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/jtag/jtag-aspeed.c: In function 'aspeed_jtag_deinit':
>> drivers/jtag/jtag-aspeed.c:707:2: error: implicit declaration of function 'reset_control_assert' [-Werror=implicit-function-declaration]
     reset_control_assert(aspeed_jtag->rst);
     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +657 drivers/jtag/jtag-aspeed.c

   631	
   632	int aspeed_jtag_init(struct platform_device *pdev,
   633			     struct aspeed_jtag *aspeed_jtag)
   634	{
   635		struct resource *res;
   636		int err;
   637	
   638		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   639		aspeed_jtag->reg_base = devm_ioremap_resource(aspeed_jtag->dev, res);
   640		if (IS_ERR(aspeed_jtag->reg_base))
   641			return -ENOMEM;
   642	
   643		aspeed_jtag->pclk = devm_clk_get(aspeed_jtag->dev, NULL);
   644		if (IS_ERR(aspeed_jtag->pclk)) {
   645			dev_err(aspeed_jtag->dev, "devm_clk_get failed\n");
   646			return PTR_ERR(aspeed_jtag->pclk);
   647		}
   648	
   649		aspeed_jtag->irq = platform_get_irq(pdev, 0);
   650		if (aspeed_jtag->irq < 0) {
   651			dev_err(aspeed_jtag->dev, "no irq specified\n");
   652			return -ENOENT;
   653		}
   654	
   655		clk_prepare_enable(aspeed_jtag->pclk);
   656	
 > 657		aspeed_jtag->rst = devm_reset_control_get_shared(aspeed_jtag->dev,
   658								 NULL);
   659		if (IS_ERR(aspeed_jtag->rst)) {
   660			dev_err(aspeed_jtag->dev,
   661				"missing or invalid reset controller device tree entry");
   662			return PTR_ERR(aspeed_jtag->rst);
   663		}
 > 664		reset_control_deassert(aspeed_jtag->rst);
   665	
   666		/* Enable clock */
   667		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_CTL_ENG_EN |
   668				  ASPEED_JTAG_CTL_ENG_OUT_EN, ASPEED_JTAG_CTRL);
   669		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_SW_MODE_EN |
   670				  ASPEED_JTAG_SW_MODE_TDIO, ASPEED_JTAG_SW);
   671	
   672		err = devm_request_irq(aspeed_jtag->dev, aspeed_jtag->irq,
   673				       aspeed_jtag_interrupt, 0,
   674				       "aspeed-jtag", aspeed_jtag);
   675		if (err) {
   676			dev_err(aspeed_jtag->dev, "unable to get IRQ");
   677			goto clk_unprep;
   678		}
   679		dev_dbg(&pdev->dev, "IRQ %d.\n", aspeed_jtag->irq);
   680	
   681		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_ISR_INST_PAUSE |
   682				  ASPEED_JTAG_ISR_INST_COMPLETE |
   683				  ASPEED_JTAG_ISR_DATA_PAUSE |
   684				  ASPEED_JTAG_ISR_DATA_COMPLETE |
   685				  ASPEED_JTAG_ISR_INST_PAUSE_EN |
   686				  ASPEED_JTAG_ISR_INST_COMPLETE_EN |
   687				  ASPEED_JTAG_ISR_DATA_PAUSE_EN |
   688				  ASPEED_JTAG_ISR_DATA_COMPLETE_EN,
   689				  ASPEED_JTAG_ISR);
   690	
   691		aspeed_jtag->flag = 0;
   692		aspeed_jtag->mode = 0;
   693		init_waitqueue_head(&aspeed_jtag->jtag_wq);
   694		return 0;
   695	
   696	clk_unprep:
   697		clk_disable_unprepare(aspeed_jtag->pclk);
   698		return err;
   699	}
   700	
   701	int aspeed_jtag_deinit(struct platform_device *pdev,
   702			       struct aspeed_jtag *aspeed_jtag)
   703	{
   704		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_ISR);
   705		/* Disable clock */
   706		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_CTRL);
 > 707		reset_control_assert(aspeed_jtag->rst);
   708		clk_disable_unprepare(aspeed_jtag->pclk);
   709		return 0;
   710	}
   711	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180119/6ad64a5e/attachment-0001.gz>
