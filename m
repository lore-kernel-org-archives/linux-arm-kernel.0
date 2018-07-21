From: lkp@intel.com (kbuild test robot)
Date: Sat, 21 Jul 2018 12:21:35 +0800
Subject: [PATCH RESEND 3/7] of: address: Add parent pointer to the
 __of_translate_address args
In-Reply-To: <2f1db1ad423dcc845cab311432826da4976d2363.1532098561.git-series.maxime.ripard@bootlin.com>
References: <2f1db1ad423dcc845cab311432826da4976d2363.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <201807211245.PUl1H0mX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/sunxi-Add-DT-representation-for-the-MBUS-controller/20180721-052652
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/of/address.c:742:45: sparse: incorrect type in argument 2 (different base types) @@    expected struct device_node *[assigned] parent @@    got restrstruct device_node *[assigned] parent @@
   drivers/of/address.c:742:45:    expected struct device_node *[assigned] parent
   drivers/of/address.c:742:45:    got restricted __be32 const [usertype] *in_addr
>> drivers/of/address.c:742:54: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __be32 const [usertype] *in_addr @@    got ype] *in_addr @@
   drivers/of/address.c:742:54:    expected restricted __be32 const [usertype] *in_addr
   drivers/of/address.c:742:54:    got char *<noident>
>> drivers/of/address.c:742:65: sparse: incorrect type in argument 4 (different base types) @@    expected char const *rprop @@    got struct dechar const *rprop @@
   drivers/of/address.c:742:65:    expected char const *rprop
   drivers/of/address.c:742:65:    got struct device_node **<noident>
>> drivers/of/address.c:742:39: sparse: not enough arguments for function __of_translate_address
   drivers/of/address.c: In function 'of_translate_ioport':
   drivers/of/address.c:742:38: error: passing argument 2 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                         ^~~~~~~
   drivers/of/address.c:571:12: note: expected 'struct device_node *' but argument is of type 'const __be32 * {aka const unsigned int *}'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/of/address.c:742:47: error: passing argument 3 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                                  ^~~~~~~~
   drivers/of/address.c:571:12: note: expected 'const __be32 * {aka const unsigned int *}' but argument is of type 'char *'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/of/address.c:742:57: error: passing argument 4 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                                            ^
   drivers/of/address.c:571:12: note: expected 'const char *' but argument is of type 'struct device_node **'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/of/address.c:742:10: error: too few arguments to function '__of_translate_address'
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/of/address.c:571:12: note: declared here
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +742 drivers/of/address.c

dbbdee94 Grant Likely  2010-06-08  734  
65af618d Zhichang Yuan 2018-03-15  735  static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
65af618d Zhichang Yuan 2018-03-15  736  			u64 size)
65af618d Zhichang Yuan 2018-03-15  737  {
65af618d Zhichang Yuan 2018-03-15  738  	u64 taddr;
65af618d Zhichang Yuan 2018-03-15  739  	unsigned long port;
65af618d Zhichang Yuan 2018-03-15  740  	struct device_node *host;
65af618d Zhichang Yuan 2018-03-15  741  
65af618d Zhichang Yuan 2018-03-15 @742  	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
65af618d Zhichang Yuan 2018-03-15  743  	if (host) {
65af618d Zhichang Yuan 2018-03-15  744  		/* host-specific port access */
65af618d Zhichang Yuan 2018-03-15  745  		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
65af618d Zhichang Yuan 2018-03-15  746  		of_node_put(host);
65af618d Zhichang Yuan 2018-03-15  747  	} else {
65af618d Zhichang Yuan 2018-03-15  748  		/* memory-mapped I/O range */
65af618d Zhichang Yuan 2018-03-15  749  		port = pci_address_to_pio(taddr);
65af618d Zhichang Yuan 2018-03-15  750  	}
65af618d Zhichang Yuan 2018-03-15  751  
65af618d Zhichang Yuan 2018-03-15  752  	if (port == (unsigned long)-1)
65af618d Zhichang Yuan 2018-03-15  753  		return OF_BAD_ADDR;
65af618d Zhichang Yuan 2018-03-15  754  
65af618d Zhichang Yuan 2018-03-15  755  	return port;
65af618d Zhichang Yuan 2018-03-15  756  }
65af618d Zhichang Yuan 2018-03-15  757  

:::::: The code at line 742 was first introduced by commit
:::::: 65af618d2c559f8eb19d80d03a23029651a59de4 of: Add missing I/O range exception for indirect-IO devices

:::::: TO: Zhichang Yuan <yuanzhichang@hisilicon.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
