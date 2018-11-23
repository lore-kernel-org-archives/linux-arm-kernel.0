From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Nov 2018 16:30:00 +0800
Subject: [PATCH 2/2] clk: core: link consumer with clock driver
In-Reply-To: <20181122212212.16039-3-miquel.raynal@bootlin.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
Message-ID: <201811231627.H7ojlKLL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.20-rc3 next-20181122]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/Link-consumer-with-clock-driver/20181123-113833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: sh-titan_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers//clk/clkdev.c: In function 'clk_get':
>> drivers//clk/clkdev.c:209:3: error: implicit declaration of function '__clk_device_link'; did you mean '__clk_free_clk'? [-Werror=implicit-function-declaration]
      __clk_device_link(dev, clk);
      ^~~~~~~~~~~~~~~~~
      __clk_free_clk
   drivers//clk/clkdev.c: In function 'clk_put':
>> drivers//clk/clkdev.c:217:2: error: implicit declaration of function '__clk_device_unlink'; did you mean 'device_online'? [-Werror=implicit-function-declaration]
     __clk_device_unlink(clk);
     ^~~~~~~~~~~~~~~~~~~
     device_online
   cc1: some warnings being treated as errors

vim +209 drivers//clk/clkdev.c

   193	
   194	struct clk *clk_get(struct device *dev, const char *con_id)
   195	{
   196		const char *dev_id = dev ? dev_name(dev) : NULL;
   197		struct clk *clk = NULL;
   198	
   199		if (dev && dev->of_node) {
   200			clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
   201			if (PTR_ERR(clk) == -EPROBE_DEFER)
   202				return clk;
   203		}
   204	
   205		if (IS_ERR_OR_NULL(clk))
   206			clk = clk_get_sys(dev_id, con_id);
   207	
   208		if (!IS_ERR(clk))
 > 209			__clk_device_link(dev, clk);
   210	
   211		return clk;
   212	}
   213	EXPORT_SYMBOL(clk_get);
   214	
   215	void clk_put(struct clk *clk)
   216	{
 > 217		__clk_device_unlink(clk);
   218		__clk_put(clk);
   219	}
   220	EXPORT_SYMBOL(clk_put);
   221	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16439 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/7a74ec89/attachment-0001.gz>
