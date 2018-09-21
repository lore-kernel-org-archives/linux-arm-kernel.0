From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 21 Sep 2018 09:35:13 +0800
Subject: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
In-Reply-To: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
 <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
Message-ID: <1dfae517-640a-fa56-34e8-52964c29a15f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/9/20 22:50, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Sent: Thursday, September 20, 2018 10:44 AM
>> To: YueHaibing <yuehaibing@huawei.com>
>> Cc: davem at davemloft.net; dmitry.tarnyagin at lockless.no;
>> wg at grandegger.com; mkl at pengutronix.de; michal.simek at xilinx.com;
>> hsweeten at visionengravers.com; madalin.bucur at nxp.com;
>> pantelis.antoniou at gmail.com; claudiu.manoil at nxp.com; leoyang.li at nxp.com;
>> linux at armlinux.org.uk; sammy at sammy.net; ralf at linux-mips.org;
>> nico at fluxnic.net; steve.glendinning at shawell.net; f.fainelli at gmail.com;
>> grygorii.strashko at ti.com; w-kwok2 at ti.com; m-karicheri2 at ti.com;
>> t.sailer at alumni.ethz.ch; jreuter at yaina.de; KY Srinivasan <kys@microsoft.com>;
>> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2 at citrix.com;
>> paul.durrant at citrix.com; arvid.brodin at alten.se; pshelar at ovn.org;
>> dev at openvswitch.org; linux-mips at linux-mips.org; xen-
>> devel at lists.xenproject.org; netdev at vger.kernel.org; linux-usb at vger.kernel.org;
>> linux-kernel at vger.kernel.org; linux-can at vger.kernel.org;
>> devel at linuxdriverproject.org; linux-hams at vger.kernel.org; linux-
>> omap at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
>> ndo_start_xmit function
>>
>> On Thu, 20 Sep 2018 20:33:01 +0800
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>> int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>>  	 */
>>>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>>>  	if (vf_netdev && netif_running(vf_netdev) &&
>>> -	    !netpoll_tx_running(net))
>>> -		return netvsc_vf_xmit(net, vf_netdev, skb);
>>> +	    !netpoll_tx_running(net)) {
>>> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
>>> +		if (ret)
>>> +			return NETDEV_TX_BUSY;
>>> +	}
>>
>> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
>> Please review and test your patches.
> 
> Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
> are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
> may cause infinite retry from the upper layer.
> 
> So, let's just always return NETDEV_TX_OK like this:
> 		netvsc_vf_xmit(net, vf_netdev, skb);
> 		return NETDEV_TX_OK;

Thank you for review.

Will do that in v2.

> 
> Thanks,
> - Haiyang
> 
> .
> 
