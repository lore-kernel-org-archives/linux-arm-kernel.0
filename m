From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 4 Apr 2018 01:41:27 -0500
Subject: [PATCH v2] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereferences
In-Reply-To: <6aa876e8-c94c-1ab8-2a3a-02b2b77df65f@gmail.com>
References: <20180403220423.GA718@embeddedor.com>
 <6aa876e8-c94c-1ab8-2a3a-02b2b77df65f@gmail.com>
Message-ID: <ddc66fb1-a04e-5c93-9521-2949f5112e44@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/2018 01:36 AM, Eric Dumazet wrote:
> 
> 
> On 04/03/2018 03:04 PM, Gustavo A. R. Silva wrote:
>> Add null check on kmalloc() return value in order to prevent
>> a null pointer dereference.
>>
>> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
>> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>   - Add a null check on a second kmalloc a few lines below. Thanks to
>>     Eric Dumazet for pointing this out.
>>
>>   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> index 1e9a31f..f7b5ca5 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> @@ -1999,10 +1999,14 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>>   				struct xcast_addr *xaddr;
>>   
>>   				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
>> +				if (unlikely(!mc_list))
>> +					return;
>>   				INIT_LIST_HEAD(&mc_list->list);
>>   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>>   					xaddr = kmalloc(sizeof(*xaddr),
>>   							GFP_ATOMIC);
>> +					if (unlikely(!xaddr))
>> +						return;
> 
> So now you leak memory :/
> 

Oh god. I'm sorry.

I had problems with this file since the beginning.

I'll send v3 shortly.

Thanks
--
Gustavo
