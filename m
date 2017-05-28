From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 28 May 2017 15:09:02 +0800
Subject: [xlnx:master 585/596]
 drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1855:16: error: 'struct
 axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
Message-ID: <201705281557.YNFDlq2R%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4d47e5726038e6535427945805572442e6f0e7b2
commit: 87223be758604b2eee18af6546cb695a2a846723 [585/596] drivers: net: ethernet: TSN: Kconfig and Makefile
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 87223be758604b2eee18af6546cb695a2a846723
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_ptp_clock.c:18:
   drivers/net//ethernet/xilinx/xilinx_tsn_ptp_clock.c: In function 'xlnx_rtc_offset_write':
>> drivers/net//ethernet/xilinx/xilinx_tsn_ptp_clock.c:55:11: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'time64_t {aka const long long int}' [-Wformat=]
     pr_debug("%s: sec: %ld nsec: %ld\n", __func__, ts->tv_sec, ts->tv_nsec);
              ^
   include/linux/printk.h:261:21: note: in definition of macro 'pr_fmt'
    #define pr_fmt(fmt) fmt
                        ^~~
   include/linux/printk.h:309:2: note: in expansion of macro 'dynamic_pr_debug'
     dynamic_pr_debug(fmt, ##__VA_ARGS__)
     ^~~~~~~~~~~~~~~~
>> drivers/net//ethernet/xilinx/xilinx_tsn_ptp_clock.c:55:2: note: in expansion of macro 'pr_debug'
     pr_debug("%s: sec: %ld nsec: %ld\n", __func__, ts->tv_sec, ts->tv_nsec);
     ^~~~~~~~
--
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_start_xmit':
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1067:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      const struct ethhdr *eth;
      ^~~~~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_poll_controller':
>> drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1855:16: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     disable_irq(lp->tx_irq);
                   ^~
>> drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1856:16: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     disable_irq(lp->rx_irq);
                   ^~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1857:19: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     axienet_rx_irq(lp->tx_irq, ndev);
                      ^~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1858:19: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     axienet_tx_irq(lp->rx_irq, ndev);
                      ^~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1859:15: error: 'struct axienet_local' has no member named 'tx_irq'; did you mean 'rtc_irq'?
     enable_irq(lp->tx_irq);
                  ^~
   drivers/net//ethernet/xilinx/xilinx_axienet_main.c:1860:15: error: 'struct axienet_local' has no member named 'rx_irq'; did you mean 'rtc_irq'?
     enable_irq(lp->rx_irq);
                  ^~

vim +1855 drivers/net//ethernet/xilinx/xilinx_axienet_main.c

8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1849   * to polling the ISRs and are enabled back after the polling is done.
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1850   */
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1851  static void axienet_poll_controller(struct net_device *ndev)
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1852  {
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1853  	struct axienet_local *lp = netdev_priv(ndev);
51a69287 Kedareswara rao Appana    2015-09-10  1854  
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @1855  	disable_irq(lp->tx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19 @1856  	disable_irq(lp->rx_irq);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1857  	axienet_rx_irq(lp->tx_irq, ndev);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1858  	axienet_tx_irq(lp->rx_irq, ndev);
8a3b7a25 danborkmann at iogearbox.net 2012-01-19  1859  	enable_irq(lp->tx_irq);

:::::: The code at line 1855 was first introduced by commit
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
Size: 59813 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170528/2efb76d6/attachment-0001.gz>
