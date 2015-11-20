From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Nov 2015 17:07:17 +0300
Subject: [PATCH V3 net-next 4/5] net:hns: Add support of ethtool TSO set
 option for Hip06 in HNS
In-Reply-To: <1447966706-16219-5-git-send-email-salil.mehta@huawei.com>
References: <1447966706-16219-1-git-send-email-salil.mehta@huawei.com>
 <1447966706-16219-5-git-send-email-salil.mehta@huawei.com>
Message-ID: <564F2915.1090507@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2015 11:58 PM, Salil Mehta wrote:

> From: Salil <salil.mehta@huawei.com>
>
> This patch adds the support of ethtool TSO option to V1 patch,
> meant to add support of Hip06 SoC to HNS
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: lisheng <lisheng011@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns/hns_enet.c |   47 +++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index 055e14c..a0763ab 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> @@ -1386,6 +1386,51 @@ static int hns_nic_change_mtu(struct net_device *ndev, int new_mtu)
>   	return ret;
>   }
>
> +static int hns_nic_set_features(struct net_device *netdev,
> +				netdev_features_t features)
> +{
> +	struct hns_nic_priv *priv = netdev_priv(netdev);
> +	struct hnae_handle *h = priv->ae_handle;
> +
> +	switch (priv->enet_ver) {
> +	case AE_VERSION_1:
> +		if ((features & NETIF_F_TSO) || (features & NETIF_F_TSO6))

		if ((features & (NETIF_F_TSO| NETIF_F_TSO6))

> +			netdev_info(netdev, "enet v1 do not support tso!\n");
> +	break;

    The *break* should have the same indentation level as *if*.

> +	default:
> +		if ((features & NETIF_F_TSO) || (features & NETIF_F_TSO6)) {

	if ((features & (NETIF_F_TSO| NETIF_F_TSO6))

> +			priv->ops.fill_desc = fill_tso_desc;
> +			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
> +			/* The chip only support 7*4096 */
> +			netif_set_gso_max_size(netdev, 7 * 4096);
> +			h->dev->ops->set_tso_stats(h, 1);
> +		} else {
> +			priv->ops.fill_desc = fill_v2_desc;
> +			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
> +			h->dev->ops->set_tso_stats(h, 0);
> +		}
> +	break;

    Same here.

> +	}
> +	netdev->features = features;
> +	return 0;
> +}
> +
> +static netdev_features_t hns_nic_fix_features(
> +		struct net_device *netdev, netdev_features_t features)
> +{
> +	struct hns_nic_priv *priv = netdev_priv(netdev);
> +
> +	switch (priv->enet_ver) {
> +	case AE_VERSION_1:
> +		features &= ~(NETIF_F_TSO | NETIF_F_TSO6 |
> +				NETIF_F_HW_VLAN_CTAG_FILTER);
> +		break;
> +	default:
> +		break;
> +	}

    Here it's indented correctly.

> +	return features;
> +}
> +
>   /**
>    * nic_set_multicast_list - set mutl mac address
>    * @netdev: net device
[...]

MBR, Sergei
