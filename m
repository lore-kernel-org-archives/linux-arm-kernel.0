From: saeed@marvell.com (Saeed Bishara)
Date: Wed, 9 Jun 2010 11:21:47 +0300
Subject: [PATCH 1/2] mv643xx_eth: disable csum offloading if the hw
	limited by max size
In-Reply-To: <20100608170846.GR1743@mail.wantstofly.org>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<20100608170846.GR1743@mail.wantstofly.org>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Lennert Buytenhek [mailto:buytenh at wantstofly.org] 
>Sent: Tuesday, June 08, 2010 8:09 PM
>To: Saeed Bishara
>Cc: linux-net at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 1/2] mv643xx_eth: disable csum offloading 
>if the hw limited by max size
>
>On Sun, Jun 06, 2010 at 03:28:55PM +0300, Saeed Bishara wrote:
>
>> diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
>> index e345ec8..79243dd 100644
>> --- a/drivers/net/mv643xx_eth.c
>> +++ b/drivers/net/mv643xx_eth.c
>> @@ -289,6 +289,7 @@ struct mv643xx_eth_shared_private {
>>  	unsigned int t_clk;
>>  	int extended_rx_coal_limit;
>>  	int tx_bw_control;
>> +	int tx_csum_limit;
>>  };
>>  
>>  #define TX_BW_CONTROL_ABSENT		0
>> @@ -2468,6 +2469,14 @@ static int 
>mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
>>  	mv643xx_eth_recalc_skb_size(mp);
>>  	tx_set_rate(mp, 1000000000, 16777216);
>>  
>> +	if (mp->shared->tx_csum_limit && dev->mtu > 
>mp->shared->tx_csum_limit) {
>> +		dev->features &= ~NETIF_F_IP_CSUM;
>> +		dev->vlan_features &= ~NETIF_F_IP_CSUM;
>> +	} else {
>> +		dev->features |= NETIF_F_IP_CSUM;
>> +		dev->vlan_features |= NETIF_F_IP_CSUM;
>> +	}
>
>I wonder if it would be better to still advertise NETIF_F_IP_CSUM in
>this case, but just call skb_checksum_help() if skb->len is > dev->mtu
>in txq_submit_skb(), like we do for the case where the ethernet header
>is of an unsupported length -- that way, we'd still have hardware
>checksum offload for TX packets that _do_ fit inside the hardware TX
>fifo, e.g. when communicating with hosts on another subnet where the
>default MTU is used.
Goog idea, I'll add a check to skb->len > mp->shared->tx_csum_limit.
>
>
>> diff --git a/include/linux/mv643xx_eth.h 
>b/include/linux/mv643xx_eth.h
>> index cbbbe9b..7402718 100644
>> --- a/include/linux/mv643xx_eth.h
>> +++ b/include/linux/mv643xx_eth.h
>> @@ -19,6 +19,10 @@ struct mv643xx_eth_shared_platform_data {
>>  	struct mbus_dram_target_info	*dram;
>>  	struct platform_device	*shared_smi;
>>  	unsigned int		t_clk;
>> +	/*
>> +	 * Max packet size for Tx IP/Layer 4 checksum (0 -> no limit)
>
>There's always a limit. :-)  You might as well just fill in the right
>values for orion5x/kw/dd/loki while you're at it.
Right, kirkwood and dove are limited to 1600, the others to 9*1024. Don't know about loki.
>
>
>thanks,
>Lennert
>
