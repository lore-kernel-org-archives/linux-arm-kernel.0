From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Jun 2017 19:38:13 +0800
Subject: [PATCH] ASoC: rockchip: Fix an error handling in
 'rockchip_i2s_probe'
In-Reply-To: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
Message-ID: <201706151948.nzHz2kMo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.12-rc5 next-20170615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christophe-JAILLET/ASoC-rockchip-Fix-an-error-handling-in-rockchip_i2s_probe/20170615-184817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   sound/soc//rockchip/rockchip_i2s.c: In function 'rockchip_i2s_probe':
>> sound/soc//rockchip/rockchip_i2s.c:619:11: error: expected ')' before 'sizeof'
              sizeof(*soc_dai), GFP_KERNEL);
              ^
>> sound/soc//rockchip/rockchip_i2s.c:618:12: error: too few arguments to function 'devm_kmemdup'
     soc_dai = devm_kmemdup(&pdev->dev, &rockchip_i2s_dai
               ^
   In file included from include/linux/gpio/driver.h:4:0,
                    from include/asm-generic/gpio.h:12,
                    from include/linux/gpio.h:51,
                    from include/linux/of_gpio.h:20,
                    from sound/soc//rockchip/rockchip_i2s.c:16:
   include/linux/device.h:684:14: note: declared here
    extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
                 ^
>> sound/soc//rockchip/rockchip_i2s.c:621:3: error: 'err' undeclared (first use in this function)
      err = -ENOMEM;
      ^
   sound/soc//rockchip/rockchip_i2s.c:621:3: note: each undeclared identifier is reported only once for each function it appears in

vim +/devm_kmemdup +618 sound/soc//rockchip/rockchip_i2s.c

   612		if (!pm_runtime_enabled(&pdev->dev)) {
   613			ret = i2s_runtime_resume(&pdev->dev);
   614			if (ret)
   615				goto err_pm_disable;
   616		}
   617	
 > 618		soc_dai = devm_kmemdup(&pdev->dev, &rockchip_i2s_dai
 > 619				       sizeof(*soc_dai), GFP_KERNEL);
   620		if (!soc_dai) {
 > 621			err = -ENOMEM;
   622			goto err_pm_disable;
   623		}
   624	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50141 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170615/b6456d57/attachment-0001.gz>
