From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 10 Mar 2016 10:24:13 +0200
Subject: [patch net 2/2] net: hns: fixes a bug of RSS
In-Reply-To: <1457576189-22924-3-git-send-email-yankejian@huawei.com>
References: <1457576189-22924-1-git-send-email-yankejian@huawei.com>
 <1457576189-22924-3-git-send-email-yankejian@huawei.com>
Message-ID: <1457598253.1347.52.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-10 at 10:16 +0800, Kejian Yan wrote:
> If trying to get receive flow hash indirection table by ethtool, it
> needs
> to call .get_rxnfc to get ring number first. So this patch implements
> the
> .get_rxnfc of ethtool. And the data type of rss_indir_table is u32,
> it has
> to be multiply by the width of data type when using memcpy.

+static int hns_get_rxnfc(struct net_device *netdev,
> +			?struct ethtool_rxnfc *cmd,
> +			?u32 *rule_locs)
> +{
> +	struct hns_nic_priv *priv = netdev_priv(netdev);
> +	int ret = 0;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_GRXRINGS:
> +		cmd->data = priv->ae_handle->q_num;
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;

Redundant ret variable.

switch (value) {
case X:
?break;
default:
?return -ERRNO;
}

return 0;

> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
