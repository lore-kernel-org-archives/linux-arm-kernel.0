From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 23:23:00 +0800
Subject: [xlnx:xlnx_rebase_v4.14 441/937]
 drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1854:18: error: 'struct
 axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
Message-ID: <201805212303.kzHAs3O7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   6588700bdabc9bb1a0156770ed2ac41da7d823dd
commit: 27eb94d2931872784a5e740adbddd1b823dc7b95 [441/937] drivers: net: ethernet: TSN: Kconfig and Makefile
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 27eb94d2931872784a5e740adbddd1b823dc7b95
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/net//ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_start_xmit':
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1069:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      const struct ethhdr *eth;
      ^~~~~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_poll_controller':
>> drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1854:18: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     disable_irq(lp->tx_irq);
                     ^~~~~~
                     rtc_irq
>> drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1855:18: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     disable_irq(lp->rx_irq);
                     ^~~~~~
                     rtc_irq
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1856:21: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     axienet_rx_irq(lp->tx_irq, ndev);
                        ^~~~~~
                        rtc_irq
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1857:21: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     axienet_tx_irq(lp->rx_irq, ndev);
                        ^~~~~~
                        rtc_irq
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1858:17: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     enable_irq(lp->tx_irq);
                    ^~~~~~
                    rtc_irq
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1859:17: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     enable_irq(lp->rx_irq);
                    ^~~~~~
                    rtc_irq

vim +1854 drivers/net//ethernet/xilinx/xilinx_axienet_main.c

8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1841  
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1842  #ifdef CONFIG_NET_POLL_CONTROLLER
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1843  /**
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1844   * axienet_poll_controller - Axi Ethernet poll mechanism.
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1845   * @ndev:	Pointer to net_device structure
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1846   *
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1847   * This implements Rx/Tx ISR poll mechanisms. The interrupts are disabled prior
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1848   * to polling the ISRs and are enabled back after the polling is done.
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1849   */
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1850  static void axienet_poll_controller(struct net_device *ndev)
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1851  {
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1852  	struct axienet_local *lp = netdev_priv(ndev);
c0ebb862 Kedareswara rao Appana    2017-09-18  1853  
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @1854  	disable_irq(lp->tx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @1855  	disable_irq(lp->rx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1856  	axienet_rx_irq(lp->tx_irq, ndev);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1857  	axienet_tx_irq(lp->rx_irq, ndev);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1858  	enable_irq(lp->tx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1859  	enable_irq(lp->rx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1860  }
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1861  #endif
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1862  

:::::: The code at line 1854 was first introduced by commit
:::::: 8a3b7a252dca9fb28c23b5bf76c49180a2b60d3b drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver

:::::: TO: danborkmann at iogearbox.net <danborkmann@iogearbox.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64342 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/375e42cb/attachment-0001.gz>
