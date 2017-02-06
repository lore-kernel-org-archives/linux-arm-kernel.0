From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 6 Feb 2017 15:02:52 +0300
Subject: [PATCH net-next 6/8] net: ethernet: annapurna: add wol helpers to
 the Alpine driver
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB027C6C3@AcuExch.aculab.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-7-antoine.tenart@free-electrons.com>
 <08b62752-8bb2-4633-c44f-74eb585e7e52@cogentembedded.com>
 <063D6719AE5E284EB5DD2968C1650D6DB027C6C3@AcuExch.aculab.com>
Message-ID: <b83bc8ad-7f16-5757-b629-be296046ca1e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2017 02:35 PM, David Laight wrote:

>>> Implement the get_wol() and set_wol() helpers in the Annapurna Labs
>>> Alpine Ethernet driver.
>>> ---
>>>  drivers/net/ethernet/annapurna/al_eth.c | 44 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/annapurna/al_eth.c b/drivers/net/ethernet/annapurna/al_eth.c
>>> index 8dd84f66b5d1..d06a75a49ce5 100644
>>> --- a/drivers/net/ethernet/annapurna/al_eth.c
>>> +++ b/drivers/net/ethernet/annapurna/al_eth.c
>>> @@ -2519,10 +2519,54 @@ static u32 al_eth_get_rxfh_indir_size(struct net_device *netdev)
>>>  	return AL_ETH_RX_RSS_TABLE_SIZE;
>>>  }
>>>
>>> +static void al_eth_get_wol(struct net_device *netdev,
>>> +			   struct ethtool_wolinfo *wol)
>>> +{
>>> +	struct al_eth_adapter *adapter = netdev_priv(netdev);
>>> +	struct phy_device *phydev;
>>> +
>>> +	wol->wolopts = adapter->wol;
>>> +
>>> +	if ((adapter) && (adapter->phy_exist) && (adapter->mdio_bus)) {
>>
>>     Now that's somewhat stupid looking... does the whole driver use this "style"?
>
> Not only that, in one of the two functions it is followed by:
>
> +	device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);

> Which assumes that 'adapter' is not NULL.
> Some verifiers will detect that as a possible NULL pointer dereference.

    I only meant unneeded parens. :-)

[...]

> 	David

MBR, Sergei
