From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 11 Oct 2012 14:32:55 +0100
Subject: alignment faults in 3.6
In-Reply-To: <5076C78E.1020408@gmail.com> (Rob Herring's message of "Thu, 11
 Oct 2012 08:20:14 -0500")
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
 <1349952574.21172.8604.camel@edumazet-glaptop>
 <201210111228.25995.arnd@arndb.de>
 <1349959248.21172.8970.camel@edumazet-glaptop>
 <5076C78E.1020408@gmail.com>
Message-ID: <yw1x626hp20o.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2@gmail.com> writes:

> On 10/11/2012 07:40 AM, Eric Dumazet wrote:
>> On Thu, 2012-10-11 at 12:28 +0000, Arnd Bergmann wrote:
>> 
>>>
>>> Rob Herring as the original reporter has dropped off the Cc list, adding
>>> him back.
>>>
>>> I assume that the calxeda xgmac driver is the culprit then. It uses
>>> netdev_alloc_skb() rather than netdev_alloc_skb_ip_align() in
>>> xgmac_rx_refill but it is not clear whether it does so intentionally
>>> or by accident.
>
> This in fact does work and eliminates the unaligned traps. However, not
> all h/w can do IP aligned DMA (i.MX FEC for example), so I still think
> this is a questionable optimization by the compiler. We're saving 1 load
> instruction here for data that is likely already in the cache. It may be
> legal per the ABI, but the downside of this optimization is much greater
> than the upside.

The compiler is working *exactly* as it should.  Merging the loads saves
cycles *and* code size.  Many of these added up can make a real difference.

When writing code, you must follow all the rules, whether you like them
or not.  Without rules, the compiler would be very limited in the
optimisations it could perform.

Unfortunately, new optimisations occasionally uncover broken code
violating some constraint or other.  When this happens, the correct
course of action is to fix the code, not cripple the compiler.

-- 
M?ns Rullg?rd
mans at mansr.com
