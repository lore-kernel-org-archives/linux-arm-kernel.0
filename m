From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Oct 2012 10:23:30 -0500
Subject: alignment faults in 3.6
In-Reply-To: <1349963227.21172.9188.camel@edumazet-glaptop>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
 <1349952574.21172.8604.camel@edumazet-glaptop>
 <201210111228.25995.arnd@arndb.de>
 <1349959248.21172.8970.camel@edumazet-glaptop> <5076C78E.1020408@gmail.com>
 <1349963227.21172.9188.camel@edumazet-glaptop>
Message-ID: <5076E472.8030703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2012 08:47 AM, Eric Dumazet wrote:
> On Thu, 2012-10-11 at 08:20 -0500, Rob Herring wrote:
>> On 10/11/2012 07:40 AM, Eric Dumazet wrote:
>>> On Thu, 2012-10-11 at 12:28 +0000, Arnd Bergmann wrote:
>>>
>>>>
>>>> Rob Herring as the original reporter has dropped off the Cc list, adding
>>>> him back.
>>>>
>>>> I assume that the calxeda xgmac driver is the culprit then. It uses
>>>> netdev_alloc_skb() rather than netdev_alloc_skb_ip_align() in
>>>> xgmac_rx_refill but it is not clear whether it does so intentionally
>>>> or by accident.
>>
>> This in fact does work and eliminates the unaligned traps. However, not
>> all h/w can do IP aligned DMA (i.MX FEC for example), so I still think
>> this is a questionable optimization by the compiler. We're saving 1 load
>> instruction here for data that is likely already in the cache. It may be
>> legal per the ABI, but the downside of this optimization is much greater
>> than the upside.
> 
> Compiler is asked to perform a 32bit load, it does it.

Not exactly. It is asked to to perform 2 32-bit loads which are combined
into a single ldm (load multiple) which cannot handle unaligned
accesses. Here's a simple example that does the same thing:

void test(char * buf)
{
	printf("%d, %d\n", *((unsigned int *)&buf[0]), *((unsigned int *)&buf[4]));
}

So I guess the only ABI legal unaligned access is in a packed struct.

> There is no questionable optimization here. Really.
> Please stop pretending this, this makes no sense.

I'm not the one calling the networking stack bad code.

I can fix my h/w, so I'll stop caring about this. Others can all get
bitten by this new behavior in gcc 4.7.

Rob

> As I said, if some h/w cannot do IP aligned DMA, driver can use a
> workaround, or a plain memmove() (some drivers seems to do this to work
> around this h/w limitation, just grep for memmove() in drivers/net)
> 
>>
>>>
>>> Thanks Arnd
>>>
>>> It seems an accident, since driver doesnt check skb->data alignment at
>>> all (this can change with SLAB debug on/off)
>>>
>>> It also incorrectly adds 64 bytes to bfsize, there is no need for this.
>>
>> I'm pretty sure this was needed as the h/w writes out full bursts of
>> data, but I'll go back and check.
> 
> Maybe the ALIGN() was needed then. But the 64 + NE_IP_ALIGN sounds like
> the head room that we allocate/reserve in netdev_alloc_skb_ip_align()
> 
> So you allocate this extra room twice.
> 
> Thanks
> 
> 
