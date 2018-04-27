From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 27 Apr 2018 10:03:05 +0200
Subject: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
In-Reply-To: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
 <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
Message-ID: <2026db65-01e5-1cd3-0c11-144ae2ae3d97@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.4.2018 09:55, Marc Kleine-Budde wrote:
> On 04/27/2018 09:49 AM, Michal Simek wrote:
>> On 26.4.2018 23:13, Luc Van Oostenryck wrote:
>>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>>> which is a typedef for an enum type, but the implementation in this
>>> driver returns an 'int'.
>>>
>>> Fix this by returning 'netdev_tx_t' in this driver too.
>>>
>>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> ---
>>>  drivers/net/can/xilinx_can.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>>> index 89aec07c2..a19648606 100644
>>> --- a/drivers/net/can/xilinx_can.c
>>> +++ b/drivers/net/can/xilinx_can.c
>>> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>>>   *
>>>   * Return: 0 on success and failure value on error
>>>   */
>>> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>>  {
>>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>>  	struct net_device_stats *stats = &ndev->stats;
>>>
>>
>> It was applied already but there should be also kernel-doc update too to
>> use enum values instead of 0.
> 
> Like this:
> 
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index f07ce4945356..d0ad1473f689 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -398,7 +398,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>>   * function uses the next available free txbuff and populates their fields to
>>   * start the transmission.
>>   *
>> - * Return: 0 on success and failure value on error
>> + * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queue is full
>>   */
>>  static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>  {
> 
> I can squash in that change.

looks good to me.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
