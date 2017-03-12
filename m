From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 12 Mar 2017 20:23:45 +0800
Subject: [arm:clearfog 30/55] drivers/net/phy/phylink.c:141:11: error: too
 few arguments to function 'fwnode_get_named_gpiod'
Message-ID: <201703122040.bisMEQHh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

First bad commit (maybe != root cause):

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git clearfog
head:   b625d1fc5880eb7b86e82b28a12ab0d7a60bf94a
commit: e70e0c9c207478ad1b0884a5690d6839b21d0f92 [30/55] net: mvneta: convert to phylink
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout e70e0c9c207478ad1b0884a5690d6839b21d0f92
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/phy/phylink.c: In function 'phylink_parse_fixedlink':
>> drivers/net/phy/phylink.c:141:11: error: too few arguments to function 'fwnode_get_named_gpiod'
       desc = fwnode_get_named_gpiod(&fixed_node->fwnode,
              ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/phy/phylink.c:13:0:
   include/linux/gpio/consumer.h:137:19: note: declared here
    struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
                      ^~~~~~~~~~~~~~~~~~~~~~

vim +/fwnode_get_named_gpiod +141 drivers/net/phy/phylink.c

018b64cf Russell King 2015-09-22  125  
018b64cf Russell King 2015-09-22  126  	fixed_node = of_get_child_by_name(np, "fixed-link");
018b64cf Russell King 2015-09-22  127  	if (fixed_node) {
018b64cf Russell King 2015-09-22  128  		ret = of_property_read_u32(fixed_node, "speed", &speed);
018b64cf Russell King 2015-09-22  129  
018b64cf Russell King 2015-09-22  130  		pl->link_config.speed = speed;
018b64cf Russell King 2015-09-22  131  		pl->link_config.duplex = DUPLEX_HALF;
018b64cf Russell King 2015-09-22  132  
018b64cf Russell King 2015-09-22  133  		if (of_property_read_bool(fixed_node, "full-duplex"))
018b64cf Russell King 2015-09-22  134  			pl->link_config.duplex = DUPLEX_FULL;
018b64cf Russell King 2015-09-22  135  		if (of_property_read_bool(fixed_node, "pause"))
018b64cf Russell King 2015-09-22  136  			pl->link_config.pause |= MLO_PAUSE_SYM;
018b64cf Russell King 2015-09-22  137  		if (of_property_read_bool(fixed_node, "asym-pause"))
018b64cf Russell King 2015-09-22  138  			pl->link_config.pause |= MLO_PAUSE_ASYM;
018b64cf Russell King 2015-09-22  139  
018b64cf Russell King 2015-09-22  140  		if (ret == 0) {
018b64cf Russell King 2015-09-22 @141  			desc = fwnode_get_named_gpiod(&fixed_node->fwnode,
018b64cf Russell King 2015-09-22  142  						      "link-gpios");
018b64cf Russell King 2015-09-22  143  
018b64cf Russell King 2015-09-22  144  			if (!IS_ERR(desc))
018b64cf Russell King 2015-09-22  145  				pl->link_gpio = desc;
018b64cf Russell King 2015-09-22  146  			else if (desc == ERR_PTR(-EPROBE_DEFER))
018b64cf Russell King 2015-09-22  147  				ret = -EPROBE_DEFER;
018b64cf Russell King 2015-09-22  148  		}
018b64cf Russell King 2015-09-22  149  		of_node_put(fixed_node);

:::::: The code at line 141 was first introduced by commit
:::::: 018b64cf9beec1fab91333bfb2dbfe2a90ba4c0a phylink: add phylink infrastructure

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59007 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170312/850f5f3e/attachment-0001.gz>
