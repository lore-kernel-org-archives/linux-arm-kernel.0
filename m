From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Apr 2018 18:41:14 +0800
Subject: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180419162751.25223-8-peda@axentia.se>
References: <20180419162751.25223-8-peda@axentia.se>
Message-ID: <201804201731.D3OnDg0p%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/Add-tda998x-HDMI-support-to-atmel-hlcdc/20180420-160131
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-randconfig-a0-201815 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_probe':
>> drivers/gpu/drm/i2c/tda998x_drv.c:1859:16: error: 'struct drm_bridge' has no member named 'of_node'
     bridge->bridge.of_node = dev->of_node;
                   ^

vim +1859 drivers/gpu/drm/i2c/tda998x_drv.c

  1838	
  1839	static int
  1840	tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
  1841	{
  1842		struct device *dev = &client->dev;
  1843		struct tda998x_bridge *bridge;
  1844		int ret;
  1845	
  1846		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
  1847			dev_warn(&client->dev, "adapter does not support I2C\n");
  1848			return -EIO;
  1849		}
  1850	
  1851		bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
  1852		if (!bridge)
  1853			return -ENOMEM;
  1854	
  1855		bridge->dev = dev;
  1856		dev_set_drvdata(dev, bridge);
  1857	
  1858		bridge->bridge.funcs = &tda998x_bridge_funcs;
> 1859		bridge->bridge.of_node = dev->of_node;
  1860		drm_bridge_add(&bridge->bridge);
  1861	
  1862		ret = component_add(dev, &tda998x_ops);
  1863	
  1864		if (ret)
  1865			drm_bridge_remove(&bridge->bridge);
  1866	
  1867		return ret;
  1868	}
  1869	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31929 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/2bc893dc/attachment-0001.gz>
