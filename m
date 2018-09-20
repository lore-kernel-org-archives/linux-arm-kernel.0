From: haiyangz@microsoft.com (Haiyang Zhang)
Date: Thu, 20 Sep 2018 14:40:20 +0000
Subject: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
In-Reply-To: <20180920123306.14772-18-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
Message-ID: <BN6PR21MB016115A6ACD7D2685DC0070DCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Thursday, September 20, 2018 8:33 AM
> To: davem at davemloft.net; dmitry.tarnyagin at lockless.no;
> wg at grandegger.com; mkl at pengutronix.de; michal.simek at xilinx.com;
> hsweeten at visionengravers.com; madalin.bucur at nxp.com;
> pantelis.antoniou at gmail.com; claudiu.manoil at nxp.com; leoyang.li at nxp.com;
> linux at armlinux.org.uk; sammy at sammy.net; ralf at linux-mips.org;
> nico at fluxnic.net; steve.glendinning at shawell.net; f.fainelli at gmail.com;
> grygorii.strashko at ti.com; w-kwok2 at ti.com; m-karicheri2 at ti.com;
> t.sailer at alumni.ethz.ch; jreuter at yaina.de; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2 at citrix.com;
> paul.durrant at citrix.com; arvid.brodin at alten.se; pshelar at ovn.org
> Cc: linux-kernel at vger.kernel.org; netdev at vger.kernel.org; linux-
> can at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linuxppc-
> dev at lists.ozlabs.org; linux-mips at linux-mips.org; linux-omap at vger.kernel.org;
> linux-hams at vger.kernel.org; devel at linuxdriverproject.org; linux-
> usb at vger.kernel.org; xen-devel at lists.xenproject.org; dev at openvswitch.org;
> YueHaibing <yuehaibing@huawei.com>
> Subject: [PATCH net-next 17/22] hv_netvsc: fix return type of ndo_start_xmit
> function
> 
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t', which is
> a typedef for an enum type, so make sure the implementation in this driver has
> returns 'netdev_tx_t' value, and change the function return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3af6d8d..056c472 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct
> net_device *vf_netdev,
>  	return rc;
>  }
> 
> -static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
> +static netdev_tx_t
> +netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  {
>  	struct net_device_context *net_device_ctx = netdev_priv(net);
>  	struct hv_netvsc_packet *packet = NULL; @@ -528,8 +529,11 @@
> static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  	 */
>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>  	if (vf_netdev && netif_running(vf_netdev) &&
> -	    !netpoll_tx_running(net))
> -		return netvsc_vf_xmit(net, vf_netdev, skb);
> +	    !netpoll_tx_running(net)) {
> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
> +		if (ret)
> +			return NETDEV_TX_BUSY;

For error case, please just return NETDEV_TX_OK. We are not sure if the 
error can go away after retrying, returning NETDEV_TX_BUSY may cause 
infinite retry from the upper layer.

Thanks,
- Haiyang
