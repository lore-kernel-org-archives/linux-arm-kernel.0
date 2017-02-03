From: lkp@intel.com (kbuild test robot)
Date: Sat, 4 Feb 2017 05:24:36 +0800
Subject: [PATCH net-next 5/8] net: ethernet: annapurna: add statistics
 helper
In-Reply-To: <20170203181216.30214-6-antoine.tenart@free-electrons.com>
Message-ID: <201702040504.GMXekeuX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Antoine-Tenart/ARM-Alpine-Ethernet-support/20170204-022156
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/annapurna/al_eth.c: In function 'al_eth_restore_ethtool_params':
   drivers/net/ethernet/annapurna/al_eth.c:2139:15: warning: unused variable 'rx_usecs' [-Wunused-variable]
     unsigned int rx_usecs = adapter->rx_usecs;
                  ^~~~~~~~
   drivers/net/ethernet/annapurna/al_eth.c:2138:15: warning: unused variable 'tx_usecs' [-Wunused-variable]
     unsigned int tx_usecs = adapter->tx_usecs;
                  ^~~~~~~~
   In file included from include/uapi/linux/posix_types.h:4:0,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/annapurna/al_eth.c:9:
   drivers/net/ethernet/annapurna/al_eth.c: In function 'al_eth_get_stats64':
>> include/linux/stddef.h:7:14: warning: 'return' with a value, in function returning void
    #define NULL ((void *)0)
                 ^
>> drivers/net/ethernet/annapurna/al_eth.c:2398:10: note: in expansion of macro 'NULL'
      return NULL;
             ^~~~
   drivers/net/ethernet/annapurna/al_eth.c:2391:13: note: declared here
    static void al_eth_get_stats64(struct net_device *netdev,
                ^~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/annapurna/al_eth.c:2423:9: warning: 'return' with a value, in function returning void
     return stats;
            ^~~~~
   drivers/net/ethernet/annapurna/al_eth.c:2391:13: note: declared here
    static void al_eth_get_stats64(struct net_device *netdev,
                ^~~~~~~~~~~~~~~~~~

vim +/NULL +2398 drivers/net/ethernet/annapurna/al_eth.c

  2392				       struct rtnl_link_stats64 *stats)
  2393	{
  2394		struct al_eth_adapter *adapter = netdev_priv(netdev);
  2395		struct al_eth_mac_stats *mac_stats = &adapter->mac_stats;
  2396	
  2397		if (!adapter->up)
> 2398			return NULL;
  2399	
  2400		al_eth_mac_stats_get(&adapter->hw_adapter, mac_stats);
  2401	
  2402		stats->rx_packets = mac_stats->aFramesReceivedOK; /* including pause frames */
  2403		stats->tx_packets = mac_stats->aFramesTransmittedOK; /* including pause frames */
  2404		stats->rx_bytes = mac_stats->aOctetsReceivedOK;
  2405		stats->tx_bytes = mac_stats->aOctetsTransmittedOK;
  2406		stats->rx_dropped = 0;
  2407		stats->multicast = mac_stats->ifInMulticastPkts;
  2408		stats->collisions = 0;
  2409	
  2410		stats->rx_length_errors = (mac_stats->etherStatsUndersizePkts + /* good but short */
  2411					   mac_stats->etherStatsFragments + /* short and bad*/
  2412					   mac_stats->etherStatsJabbers + /* with crc errors */
  2413					   mac_stats->etherStatsOversizePkts);
  2414		stats->rx_crc_errors = mac_stats->aFrameCheckSequenceErrors;
  2415		stats->rx_frame_errors = mac_stats->aAlignmentErrors;
  2416		stats->rx_fifo_errors = mac_stats->etherStatsDropEvents;
  2417		stats->rx_missed_errors = 0;
  2418		stats->tx_window_errors = 0;
  2419	
  2420		stats->rx_errors = mac_stats->ifInErrors;
  2421		stats->tx_errors = mac_stats->ifOutErrors;
  2422	
> 2423		return stats;
  2424	}
  2425	
  2426	static void al_eth_get_drvinfo(struct net_device *dev,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60463 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170204/90b7d779/attachment-0001.gz>
