From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Feb 2016 11:29:20 +0800
Subject: [PATCH V2 11/12] net-next: mediatek: add Kconfig and Makefile
In-Reply-To: <1456496504-50429-12-git-send-email-blogic@openwrt.org>
Message-ID: <201602271159.LQufbxSQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

[auto build test ERROR on net/master]
[also build test ERROR on v4.5-rc5 next-20160226]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/net-next-mediatek-add-ethernet-driver/20160226-223245
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_init_fq_dma':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:771:22: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
     eth->scratch_ring = dma_alloc_coherent(eth->dev,
                         ^
   In file included from drivers/net/ethernet/mediatek/mtk_eth_soc.c:18:0:
   include/linux/dma-mapping.h:396:21: note: expected 'dma_addr_t *' but argument is of type 'unsigned int *'
    static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                        ^
   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_probe':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:2059:2: warning: ignoring return value of 'device_reset', declared with attribute warn_unused_result [-Wunused-result]
     device_reset(&pdev->dev);
     ^
--
   drivers/net/ethernet/mediatek/ethtool.c: In function 'mtk_set_settings':
>> drivers/net/ethernet/mediatek/ethtool.c:49:38: error: 'struct phy_device' has no member named 'addr'
     if (cmd->phy_address != mac->phy_dev->addr) {
                                         ^
>> drivers/net/ethernet/mediatek/ethtool.c:54:23: error: 'struct mii_bus' has no member named 'phy_map'
          mac->hw->mii_bus->phy_map[cmd->phy_address]) {
                          ^
   drivers/net/ethernet/mediatek/ethtool.c:56:21: error: 'struct mii_bus' has no member named 'phy_map'
        mac->hw->mii_bus->phy_map[cmd->phy_address];
                        ^

vim +49 drivers/net/ethernet/mediatek/ethtool.c

79b0e682 John Crispin 2016-02-26  43  {
79b0e682 John Crispin 2016-02-26  44  	struct mtk_mac *mac = netdev_priv(dev);
79b0e682 John Crispin 2016-02-26  45  
79b0e682 John Crispin 2016-02-26  46  	if (!mac->phy_dev)
79b0e682 John Crispin 2016-02-26  47  		return -ENODEV;
79b0e682 John Crispin 2016-02-26  48  
79b0e682 John Crispin 2016-02-26 @49  	if (cmd->phy_address != mac->phy_dev->addr) {
79b0e682 John Crispin 2016-02-26  50  		if (mac->hw->phy->phy_node[cmd->phy_address]) {
79b0e682 John Crispin 2016-02-26  51  			mac->phy_dev = mac->hw->phy->phy[cmd->phy_address];
79b0e682 John Crispin 2016-02-26  52  			mac->phy_flags = MTK_PHY_FLAG_PORT;
79b0e682 John Crispin 2016-02-26  53  		} else if (mac->hw->mii_bus &&
79b0e682 John Crispin 2016-02-26 @54  			   mac->hw->mii_bus->phy_map[cmd->phy_address]) {
79b0e682 John Crispin 2016-02-26  55  			mac->phy_dev =
79b0e682 John Crispin 2016-02-26  56  				mac->hw->mii_bus->phy_map[cmd->phy_address];
79b0e682 John Crispin 2016-02-26  57  			mac->phy_flags = MTK_PHY_FLAG_ATTACH;

:::::: The code at line 49 was first introduced by commit
:::::: 79b0e682b3b2ed2a983b0263c6b8b3af61fdbf8e net-next: mediatek: add the drivers core files

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 47927 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160227/7e0d86b8/attachment-0001.obj>
