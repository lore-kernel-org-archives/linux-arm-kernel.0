From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 3 Apr 2018 16:52:37 -0500
Subject: [PATCH] net: thunderx: nicvf_main: Fix potential NULL pointer
 dereference
In-Reply-To: <f0deebb5-06e8-d788-0e68-0c15c979028c@gmail.com>
References: <20180403212925.GA31093@embeddedor.com>
 <f0deebb5-06e8-d788-0e68-0c15c979028c@gmail.com>
Message-ID: <15d8d776-3768-b93e-8e38-0f2387668477@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/03/2018 04:47 PM, Eric Dumazet wrote:
> 
> 
> On 04/03/2018 02:29 PM, Gustavo A. R. Silva wrote:
>> Add null check on kmalloc() return value in order to prevent
>> a null pointer dereference.
>>
>> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
>> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> index 1e9a31f..468321a 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
>> @@ -1999,6 +1999,8 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>>   				struct xcast_addr *xaddr;
>>   
>>   				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
>> +				if (unlikely(!mc_list))
>> +					return;
>>   				INIT_LIST_HEAD(&mc_list->list);
>>   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
>>   					xaddr = kmalloc(sizeof(*xaddr),
>>
> 
> What about the second kmalloc() right there ?
> 

Oops. I thought I had it covered.

I'll send v2 with that change shortly.

Thanks for the feedback, Eric.
--
Gustavo
