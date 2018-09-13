From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 09:38:51 +0800
Subject: [PATCH v3 08/21] nvmem: sunxi_sid: use devm_nvmem_register()
In-Reply-To: <20180912075129.25185-9-brgl@bgdev.pl>
References: <20180912075129.25185-9-brgl@bgdev.pl>
Message-ID: <201809130920.Bfc949m8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc3 next-20180912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180913-071053
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/nvmem/sunxi_sid.c: In function 'sunxi_sid_probe':
>> drivers/nvmem/sunxi_sid.c:190:18: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
      return PTR_ERR(-EINVAL);
                     ^
   In file included from include/linux/kernfs.h:11:0,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from drivers/nvmem/sunxi_sid.c:18:
   include/linux/err.h:29:33: note: expected 'const void *' but argument is of type 'int'
    static inline long __must_check PTR_ERR(__force const void *ptr)
                                    ^~~~~~~
   drivers/nvmem/sunxi_sid.c:157:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret, i, size;
         ^~~

vim +/PTR_ERR +190 drivers/nvmem/sunxi_sid.c

   150	
   151	static int sunxi_sid_probe(struct platform_device *pdev)
   152	{
   153		struct device *dev = &pdev->dev;
   154		struct resource *res;
   155		struct nvmem_device *nvmem;
   156		struct sunxi_sid *sid;
   157		int ret, i, size;
   158		char *randomness;
   159		const struct sunxi_sid_cfg *cfg;
   160	
   161		sid = devm_kzalloc(dev, sizeof(*sid), GFP_KERNEL);
   162		if (!sid)
   163			return -ENOMEM;
   164	
   165		cfg = of_device_get_match_data(dev);
   166		if (!cfg)
   167			return -EINVAL;
   168		sid->value_offset = cfg->value_offset;
   169	
   170		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   171		sid->base = devm_ioremap_resource(dev, res);
   172		if (IS_ERR(sid->base))
   173			return PTR_ERR(sid->base);
   174	
   175		size = cfg->size;
   176	
   177		econfig.size = size;
   178		econfig.dev = dev;
   179		if (cfg->need_register_readout)
   180			econfig.reg_read = sun8i_sid_read_by_reg;
   181		else
   182			econfig.reg_read = sunxi_sid_read;
   183		econfig.priv = sid;
   184		nvmem = devm_nvmem_register(dev, &econfig);
   185		if (IS_ERR(nvmem))
   186			return PTR_ERR(nvmem);
   187	
   188		randomness = kzalloc(size, GFP_KERNEL);
   189		if (!randomness)
 > 190			return PTR_ERR(-EINVAL);
   191	
   192		for (i = 0; i < size; i++)
   193			econfig.reg_read(sid, i, &randomness[i], 1);
   194	
   195		add_device_randomness(randomness, size);
   196		kfree(randomness);
   197	
   198		platform_set_drvdata(pdev, nvmem);
   199	
   200		return 0;
   201	}
   202	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23305 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/dc67e39e/attachment-0001.gz>
