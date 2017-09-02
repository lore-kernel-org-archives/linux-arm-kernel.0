From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Sep 2017 20:07:26 +0800
Subject: [net-next PATCHv6 2/2] net: socionext: Add NetSec driver
In-Reply-To: <1504088771-6255-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <201709022034.p6dCjEt6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Jassi-Brar/net-ethernet-Socionext-Netsec/20170902-181854
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/socionext/netsec/netsec_platform.c: In function 'netsec_runtime_suspend':
>> drivers/net/ethernet/socionext/netsec/netsec_platform.c:246:3: error: implicit declaration of function 'disable_irq' [-Werror=implicit-function-declaration]
      disable_irq(priv->ndev->irq);
      ^~~~~~~~~~~
   drivers/net/ethernet/socionext/netsec/netsec_platform.c: In function 'netsec_runtime_resume':
>> drivers/net/ethernet/socionext/netsec/netsec_platform.c:272:3: error: implicit declaration of function 'enable_irq' [-Werror=implicit-function-declaration]
      enable_irq(priv->ndev->irq);
      ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/disable_irq +246 drivers/net/ethernet/socionext/netsec/netsec_platform.c

   236	
   237	#ifdef CONFIG_PM
   238	static int netsec_runtime_suspend(struct device *dev)
   239	{
   240		struct netsec_priv *priv = dev_get_drvdata(dev);
   241		int n;
   242	
   243		netif_dbg(priv, drv, priv->ndev, "%s\n", __func__);
   244	
   245		if (priv->irq_registered)
 > 246			disable_irq(priv->ndev->irq);
   247	
   248		netsec_writel(priv, NETSEC_REG_CLK_EN, 0);
   249	
   250		for (n = priv->clock_count - 1; n >= 0; n--)
   251			clk_disable_unprepare(priv->clk[n]);
   252	
   253		return 0;
   254	}
   255	
   256	static int netsec_runtime_resume(struct device *dev)
   257	{
   258		struct netsec_priv *priv = dev_get_drvdata(dev);
   259		int n;
   260	
   261		netif_dbg(priv, drv, priv->ndev, "%s\n", __func__);
   262	
   263		/* first let the clocks back on */
   264	
   265		for (n = 0; n < priv->clock_count; n++)
   266			clk_prepare_enable(priv->clk[n]);
   267	
   268		netsec_writel(priv, NETSEC_REG_CLK_EN, NETSEC_CLK_EN_REG_DOM_D |
   269				NETSEC_CLK_EN_REG_DOM_C | NETSEC_CLK_EN_REG_DOM_G);
   270	
   271		if (priv->irq_registered)
 > 272			enable_irq(priv->ndev->irq);
   273	
   274		return 0;
   275	}
   276	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61064 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170902/dbbf16e5/attachment-0001.gz>
