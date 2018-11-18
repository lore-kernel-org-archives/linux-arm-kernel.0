From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Nov 2018 15:05:43 +0800
Subject: [PATCH v1 2/2] i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support
 for I2C STM32F7
In-Reply-To: <1542370822-14721-3-git-send-email-pierre-yves.mordret@st.com>
References: <1542370822-14721-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201811181524.WpzzWNmB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

I love your patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.20-rc2 next-20181116]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/SYSCFG-Fast-Mode-Plus-support-for-I2C-STM32F7/20181118-135056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: s390-allmodconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-stm32f7.c: In function 'stm32f7_i2c_setup_fm_plus_bits':
>> drivers/i2c/busses/i2c-stm32f7.c:1790:9: error: implicit declaration of function 'regmap_update_bits'; did you mean 'set_pgste_bits'? [-Werror=implicit-function-declaration]
     return regmap_update_bits(i2c_dev->regmap, reg, mask, mask);
            ^~~~~~~~~~~~~~~~~~
            set_pgste_bits
   cc1: some warnings being treated as errors

vim +1790 drivers/i2c/busses/i2c-stm32f7.c

  1768	
  1769	static int stm32f7_i2c_setup_fm_plus_bits(struct platform_device *pdev,
  1770						  struct stm32f7_i2c_dev *i2c_dev)
  1771	{
  1772		struct device_node *np = pdev->dev.of_node;
  1773		int ret;
  1774		u32 reg, mask;
  1775	
  1776		i2c_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg-fmp");
  1777		if (IS_ERR(i2c_dev->regmap)) {
  1778			/* Optional */
  1779			return 0;
  1780		}
  1781	
  1782		ret = of_property_read_u32_index(np, "st,syscfg-fmp", 1, &reg);
  1783		if (ret)
  1784			return ret;
  1785	
  1786		ret = of_property_read_u32_index(np, "st,syscfg-fmp", 2, &mask);
  1787		if (ret)
  1788			return ret;
  1789	
> 1790		return regmap_update_bits(i2c_dev->regmap, reg, mask, mask);
  1791	}
  1792	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52103 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181118/0e97a6da/attachment-0001.gz>
