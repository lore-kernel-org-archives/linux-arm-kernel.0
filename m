From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Jul 2018 14:19:37 +0800
Subject: [PATCH 4/6] drm/i2c: tda998x: convert to bridge driver
In-Reply-To: <E1fbSCO-00076p-OV@rmk-PC.armlinux.org.uk>
References: <E1fbSCO-00076p-OV@rmk-PC.armlinux.org.uk>
Message-ID: <201807071240.hFfPjFGi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I love your patch! Yet something to improve:

[auto build test ERROR on arm/drm-tda998x-devel]
[cannot apply to v4.18-rc3 next-20180706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Russell-King/drm-i2c-tda998x-find-the-drm_device-via-the-drm_connector/20180707-030507
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
config: i386-randconfig-x007-07071008 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_bridge_disable':
>> drivers/gpu/drm/i2c/tda998x_drv.c:1336:7: error: 'priv' undeclared (first use in this function); did you mean 'pid'?
     if (!priv->is_on) {
          ^~~~
          pid
   drivers/gpu/drm/i2c/tda998x_drv.c:1336:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_create':
   drivers/gpu/drm/i2c/tda998x_drv.c:1827:25: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     priv->bridge.of_node = dev->of_node;
                            ^~~
                            cdev
   drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_bind':
   drivers/gpu/drm/i2c/tda998x_drv.c:1908:1: warning: label 'err_encoder' defined but not used [-Wunused-label]
    err_encoder:
    ^~~~~~~~~~~

vim +1336 drivers/gpu/drm/i2c/tda998x_drv.c

1772fa6e Peter Rosin         2018-07-06  1333  
3b94aa13 Russell King        2018-07-06  1334  static void tda998x_bridge_disable(struct drm_bridge *bridge)
1772fa6e Peter Rosin         2018-07-06  1335  {
1772fa6e Peter Rosin         2018-07-06 @1336  	if (!priv->is_on) {
db6aaf4d Russell King        2013-09-24  1337  		/* disable video ports */
2f7f730a Jean-Francois Moine 2014-01-25  1338  		reg_write(priv, REG_ENA_VP_0, 0x00);
2f7f730a Jean-Francois Moine 2014-01-25  1339  		reg_write(priv, REG_ENA_VP_1, 0x00);
2f7f730a Jean-Francois Moine 2014-01-25  1340  		reg_write(priv, REG_ENA_VP_2, 0x00);
e7792ce2 Rob Clark           2013-01-08  1341  
3cb43378 Russell King        2016-10-23  1342  		priv->is_on = false;
3cb43378 Russell King        2016-10-23  1343  	}
e7792ce2 Rob Clark           2013-01-08  1344  }
e7792ce2 Rob Clark           2013-01-08  1345  

:::::: The code at line 1336 was first introduced by commit
:::::: 1772fa6e1cb0338cee15728fd16679b6b2fc9fcb drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable

:::::: TO: Peter Rosin <peda@axentia.se>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180707/2d9183cf/attachment-0001.gz>
