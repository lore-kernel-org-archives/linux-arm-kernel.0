From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Jun 2017 10:56:47 +0800
Subject: [arm:phy 25/29] net/core/ethtool.c:2208: undefined reference to
 `sfp_get_module_info'
Message-ID: <201706061044.NTf0IPmc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   3a9fc132d462fcbef5aac7a8b4fe7abcabb9ef1e
commit: 1b72c8ec227c007d6e49f7e780349d4db6ddb257 [25/29] sfp: move module eeprom ethtool access into netdev core ethtool
config: cris-allmodconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1b72c8ec227c007d6e49f7e780349d4db6ddb257
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   net/built-in.o: In function `__ethtool_get_module_info':
>> net/core/ethtool.c:2208: undefined reference to `sfp_get_module_info'
   net/built-in.o: In function `__ethtool_get_module_eeprom':
>> net/core/ethtool.c:2245: undefined reference to `sfp_get_module_eeprom'

vim +2208 net/core/ethtool.c

  2202					     struct ethtool_modinfo *modinfo)
  2203	{
  2204		const struct ethtool_ops *ops = dev->ethtool_ops;
  2205		struct phy_device *phydev = dev->phydev;
  2206	
  2207		if (dev->sfp_bus)
> 2208			return sfp_get_module_info(dev->sfp_bus, modinfo);
  2209	
  2210		if (phydev && phydev->drv && phydev->drv->module_info)
  2211			return phydev->drv->module_info(phydev, modinfo);
  2212	
  2213		if (ops->get_module_info)
  2214			return ops->get_module_info(dev, modinfo);
  2215	
  2216		return -EOPNOTSUPP;
  2217	}
  2218	
  2219	static int ethtool_get_module_info(struct net_device *dev,
  2220					   void __user *useraddr)
  2221	{
  2222		int ret;
  2223		struct ethtool_modinfo modinfo;
  2224	
  2225		if (copy_from_user(&modinfo, useraddr, sizeof(modinfo)))
  2226			return -EFAULT;
  2227	
  2228		ret = __ethtool_get_module_info(dev, &modinfo);
  2229		if (ret)
  2230			return ret;
  2231	
  2232		if (copy_to_user(useraddr, &modinfo, sizeof(modinfo)))
  2233			return -EFAULT;
  2234	
  2235		return 0;
  2236	}
  2237	
  2238	static int __ethtool_get_module_eeprom(struct net_device *dev,
  2239					       struct ethtool_eeprom *ee, u8 *data)
  2240	{
  2241		const struct ethtool_ops *ops = dev->ethtool_ops;
  2242		struct phy_device *phydev = dev->phydev;
  2243	
  2244		if (dev->sfp_bus)
> 2245			return sfp_get_module_eeprom(dev->sfp_bus, ee, data);
  2246	
  2247		if (phydev && phydev->drv && phydev->drv->module_eeprom)
  2248			return phydev->drv->module_eeprom(phydev, ee, data);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43045 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/55c39010/attachment-0001.gz>
