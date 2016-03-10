From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Mar 2016 21:27:50 +0800
Subject: [PATCH v2 net-next 2/2] net: hns: fixes a bug of RSS
In-Reply-To: <1457616110-225844-3-git-send-email-yankejian@huawei.com>
Message-ID: <201603102147.GTaVcL9t%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kejian,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Kejian-Yan/net-hns-get-and-set-RSS-indirection-table-by-using-ethtool/20160310-210648
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function 'hns_get_rss':
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1214:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function 'hns_set_rss':
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1236:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function 'hns_get_rxnfc':
>> drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1267:11: error: 'ERRNO' undeclared (first use in this function)
      return -ERRNO;
              ^
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1267:11: note: each undeclared identifier is reported only once for each function it appears in

vim +/ERRNO +1267 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c

  1208	
  1209	static int
  1210	hns_get_rss(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
  1211	{
  1212		struct hns_nic_priv *priv = netdev_priv(netdev);
  1213		struct hnae_ae_ops *ops;
> 1214		int ret;
  1215	
  1216		if (AE_IS_VER1(priv->enet_ver)) {
  1217			netdev_err(netdev,
  1218				   "RSS feature is not supported on this hardware\n");
  1219			return -EOPNOTSUPP;
  1220		}
  1221	
  1222		ops = priv->ae_handle->dev->ops;
  1223	
  1224		if (!indir)
  1225			return 0;
  1226	
  1227		return ops->get_rss(priv->ae_handle, indir, key, hfunc);
  1228	}
  1229	
  1230	static int
  1231	hns_set_rss(struct net_device *netdev, const u32 *indir, const u8 *key,
  1232		    const u8 hfunc)
  1233	{
  1234		struct hns_nic_priv *priv = netdev_priv(netdev);
  1235		struct hnae_ae_ops *ops;
  1236		int ret;
  1237	
  1238		if (AE_IS_VER1(priv->enet_ver)) {
  1239			netdev_err(netdev,
  1240				   "RSS feature is not supported on this hardware\n");
  1241			return -EOPNOTSUPP;
  1242		}
  1243	
  1244		ops = priv->ae_handle->dev->ops;
  1245	
  1246		/* currently hfunc can only be Toeplitz hash */
  1247		if (key ||
  1248		    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
  1249			return -EOPNOTSUPP;
  1250		if (!indir)
  1251			return 0;
  1252	
  1253		return ops->set_rss(priv->ae_handle, indir, key, hfunc);
  1254	}
  1255	
  1256	static int hns_get_rxnfc(struct net_device *netdev,
  1257				 struct ethtool_rxnfc *cmd,
  1258				 u32 *rule_locs)
  1259	{
  1260		struct hns_nic_priv *priv = netdev_priv(netdev);
  1261	
  1262		switch (cmd->cmd) {
  1263		case ETHTOOL_GRXRINGS:
  1264			cmd->data = priv->ae_handle->q_num;
  1265			break;
  1266		default:
> 1267			return -ERRNO;
  1268		}
  1269	
  1270		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44124 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160310/2b5328b5/attachment-0001.obj>
