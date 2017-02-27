From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Feb 2017 20:21:02 +0800
Subject: [PATCH v2 net-next 5/6] drivers: net: xgene-v2: Add transmit and
 receive
In-Reply-To: <1488172706-29577-6-git-send-email-isubramanian@apm.com>
Message-ID: <201702272053.fL0xZ22g%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iyappan,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/drivers-net-xgene-v2-Add-RGMII-based-1G-driver/20170227-182414
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/apm/xgene-v2/main.c: In function 'is_tx_slot_available':
>> drivers/net/ethernet/apm/xgene-v2/main.c:182:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (GET_BITS(E, le64_to_cpu(raw_desc->m0)) &&
     ^~
   drivers/net/ethernet/apm/xgene-v2/main.c:186:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      return false;
      ^~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c: In function 'is_tx_hw_done':
   drivers/net/ethernet/apm/xgene-v2/main.c:246:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (GET_BITS(E, le64_to_cpu(raw_desc->m0)) &&
     ^~
   drivers/net/ethernet/apm/xgene-v2/main.c:250:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      return false;
      ^~~~~~

vim +/if +182 drivers/net/ethernet/apm/xgene-v2/main.c

   166		if (ret)
   167			netdev_err(ndev, "Failed to request irq %s\n", pdata->irq_name);
   168	
   169		return ret;
   170	}
   171	
   172	static void xge_free_irq(struct net_device *ndev)
   173	{
   174		struct xge_pdata *pdata = netdev_priv(ndev);
   175		struct device *dev = &pdata->pdev->dev;
   176	
   177		devm_free_irq(dev, pdata->resources.irq, pdata);
   178	}
   179	
   180	static bool is_tx_slot_available(struct xge_raw_desc *raw_desc)
   181	{
 > 182		if (GET_BITS(E, le64_to_cpu(raw_desc->m0)) &&
   183		    (GET_BITS(PKT_SIZE, le64_to_cpu(raw_desc->m0)) == SLOT_EMPTY))
   184			return true;
   185	
   186			return false;
   187	}
   188	
   189	static netdev_tx_t xge_start_xmit(struct sk_buff *skb, struct net_device *ndev)
   190	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58535 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/e620ab63/attachment-0001.gz>
