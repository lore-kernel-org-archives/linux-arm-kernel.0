From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Sep 2018 11:20:50 +0800
Subject: [PATCH] knav: qmss: Introduce queue descriptors monitor
In-Reply-To: <20180911211549.12092-1-gomonovych@gmail.com>
References: <20180911211549.12092-1-gomonovych@gmail.com>
Message-ID: <201809141145.t28aYmYU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasyl,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on keystone/next]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vasyl-Gomonovych/knav-qmss-Introduce-queue-descriptors-monitor/20180914-062448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/net//ethernet/ti/netcp_core.c: In function 'netcp_setup_navigator_resources':
>> drivers/net//ethernet/ti/netcp_core.c:1685:19: error: 'knav_qmssm_event_callback' undeclared (first use in this function); did you mean 'knav_qmss_device_ready'?
     monitor_cfg.fn = knav_qmssm_event_callback;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
                      knav_qmss_device_ready
   drivers/net//ethernet/ti/netcp_core.c:1685:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net//ethernet/ti/netcp_core.c:1687:30: warning: passing argument 3 of 'knav_queue_device_control' makes integer from pointer without a cast [-Wint-conversion]
         KNAV_QUEUE_SET_MONITOR, &monitor_cfg);
                                 ^
   In file included from drivers/net//ethernet/ti/netcp_core.c:29:0:
   include/linux/soc/ti/knav_qmss.h:88:5: note: expected 'long unsigned int' but argument is of type 'struct knav_queue_monitor_config *'
    int knav_queue_device_control(void *qhandle,
        ^~~~~~~~~~~~~~~~~~~~~~~~~

vim +1685 drivers/net//ethernet/ti/netcp_core.c

  1598	
  1599	static int netcp_setup_navigator_resources(struct net_device *ndev)
  1600	{
  1601		struct netcp_intf *netcp = netdev_priv(ndev);
  1602		struct knav_queue_notify_config notify_cfg;
  1603		struct knav_queue_monitor_config monitor_cfg;
  1604		struct knav_dma_cfg config;
  1605		u32 last_fdq = 0;
  1606		u8 name[16];
  1607		int ret;
  1608		int i;
  1609	
  1610		/* Create Rx/Tx descriptor pools */
  1611		snprintf(name, sizeof(name), "rx-pool-%s", ndev->name);
  1612		netcp->rx_pool = knav_pool_create(name, netcp->rx_pool_size,
  1613							netcp->rx_pool_region_id);
  1614		if (IS_ERR_OR_NULL(netcp->rx_pool)) {
  1615			dev_err(netcp->ndev_dev, "Couldn't create rx pool\n");
  1616			ret = PTR_ERR(netcp->rx_pool);
  1617			goto fail;
  1618		}
  1619	
  1620		snprintf(name, sizeof(name), "tx-pool-%s", ndev->name);
  1621		netcp->tx_pool = knav_pool_create(name, netcp->tx_pool_size,
  1622							netcp->tx_pool_region_id);
  1623		if (IS_ERR_OR_NULL(netcp->tx_pool)) {
  1624			dev_err(netcp->ndev_dev, "Couldn't create tx pool\n");
  1625			ret = PTR_ERR(netcp->tx_pool);
  1626			goto fail;
  1627		}
  1628	
  1629		/* open Tx completion queue */
  1630		snprintf(name, sizeof(name), "tx-compl-%s", ndev->name);
  1631		netcp->tx_compl_q = knav_queue_open(name, netcp->tx_compl_qid, 0);
  1632		if (IS_ERR(netcp->tx_compl_q)) {
  1633			ret = PTR_ERR(netcp->tx_compl_q);
  1634			goto fail;
  1635		}
  1636		netcp->tx_compl_qid = knav_queue_get_id(netcp->tx_compl_q);
  1637	
  1638		/* Set notification for Tx completion */
  1639		notify_cfg.fn = netcp_tx_notify;
  1640		notify_cfg.fn_arg = netcp;
  1641		ret = knav_queue_device_control(netcp->tx_compl_q,
  1642						KNAV_QUEUE_SET_NOTIFIER,
  1643						(unsigned long)&notify_cfg);
  1644		if (ret)
  1645			goto fail;
  1646	
  1647		knav_queue_disable_notify(netcp->tx_compl_q);
  1648	
  1649		/* open Rx completion queue */
  1650		snprintf(name, sizeof(name), "rx-compl-%s", ndev->name);
  1651		netcp->rx_queue = knav_queue_open(name, netcp->rx_queue_id, 0);
  1652		if (IS_ERR(netcp->rx_queue)) {
  1653			ret = PTR_ERR(netcp->rx_queue);
  1654			goto fail;
  1655		}
  1656		netcp->rx_queue_id = knav_queue_get_id(netcp->rx_queue);
  1657	
  1658		/* Set notification for Rx completion */
  1659		notify_cfg.fn = netcp_rx_notify;
  1660		notify_cfg.fn_arg = netcp;
  1661		ret = knav_queue_device_control(netcp->rx_queue,
  1662						KNAV_QUEUE_SET_NOTIFIER,
  1663						(unsigned long)&notify_cfg);
  1664		if (ret)
  1665			goto fail;
  1666	
  1667		knav_queue_disable_notify(netcp->rx_queue);
  1668	
  1669		/* open Rx FDQs */
  1670		for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN; i++)
  1671			monitor_cfg.fdq_arg[i] = NULL;
  1672	
  1673		for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN && netcp->rx_queue_depths[i];
  1674		     ++i) {
  1675			snprintf(name, sizeof(name), "rx-fdq-%s-%d", ndev->name, i);
  1676			netcp->rx_fdq[i] = knav_queue_open(name, KNAV_QUEUE_GP, 0);
  1677			if (IS_ERR(netcp->rx_fdq[i])) {
  1678				ret = PTR_ERR(netcp->rx_fdq[i]);
  1679				goto fail;
  1680			}
  1681			monitor_cfg.fdq_arg[i] = netcp->rx_fdq[i];
  1682		}
  1683	
  1684		/* Set monitor for Rx queue */
> 1685		monitor_cfg.fn = knav_qmssm_event_callback;
  1686		ret = knav_queue_device_control(netcp->rx_queue,
> 1687						KNAV_QUEUE_SET_MONITOR, &monitor_cfg);
  1688		if (ret)
  1689			dev_err(netcp->ndev_dev, "fail set qmms %d", netcp->rx_queue_id);
  1690	
  1691		memset(&config, 0, sizeof(config));
  1692		config.direction		= DMA_DEV_TO_MEM;
  1693		config.u.rx.einfo_present	= true;
  1694		config.u.rx.psinfo_present	= true;
  1695		config.u.rx.err_mode		= DMA_DROP;
  1696		config.u.rx.desc_type		= DMA_DESC_HOST;
  1697		config.u.rx.psinfo_at_sop	= false;
  1698		config.u.rx.sop_offset		= NETCP_SOP_OFFSET;
  1699		config.u.rx.dst_q		= netcp->rx_queue_id;
  1700		config.u.rx.thresh		= DMA_THRESH_NONE;
  1701	
  1702		for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN; ++i) {
  1703			if (netcp->rx_fdq[i])
  1704				last_fdq = knav_queue_get_id(netcp->rx_fdq[i]);
  1705			config.u.rx.fdq[i] = last_fdq;
  1706		}
  1707	
  1708		netcp->rx_channel = knav_dma_open_channel(netcp->netcp_device->device,
  1709						netcp->dma_chan_name, &config);
  1710		if (IS_ERR(netcp->rx_channel)) {
  1711			dev_err(netcp->ndev_dev, "failed opening rx chan(%s\n",
  1712				netcp->dma_chan_name);
  1713			ret = PTR_ERR(netcp->rx_channel);
  1714			goto fail;
  1715		}
  1716	
  1717		dev_dbg(netcp->ndev_dev, "opened RX channel: %p\n", netcp->rx_channel);
  1718		return 0;
  1719	
  1720	fail:
  1721		netcp_free_navigator_resources(netcp);
  1722		return ret;
  1723	}
  1724	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67104 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/279baa2d/attachment-0001.gz>
