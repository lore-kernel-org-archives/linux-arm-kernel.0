From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 17 Mar 2015 14:55:42 +0000
Subject: [PATCH] amba-pl011: simplify TX handling
In-Reply-To: <20150317154248.1675cd4c@north>
References: <1426547729-21255-1-git-send-email-moorray3@wp.pl>
 <20150317135844.GA3759@e103592.cambridge.arm.com>
 <20150317154248.1675cd4c@north>
Message-ID: <5508406E.5060607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resent with LAKML address fixed]
Hi Jakub,

On 17/03/15 14:42, Jakub Kici?ski wrote:
> On Tue, 17 Mar 2015 13:58:44 +0000, Dave P Martin wrote:
>> On Mon, Mar 16, 2015 at 11:15:29PM +0000, Jakub Kicinski wrote:
>>> From: Jakub Kicinski <kubakici@wp.pl>

[ ... ]
>>
>> My update still keeps the softirq stuff.  I wanted to avoid adding
>> status polling inside the interrupt handler's core loop, due to
>> concerns about performance overhead: without the polling, the
>> writes to DR are fire-and-forget, whereas polling FR each time
>> involves a whole round-trip to the UART which may involve significant
>> extra time cost and/or IRQ disable latency; however.
>>
>> Your approach does mitigate some of the cost by only starting to
>> poll after count chars have been transmitted, and will typically
>> halve the number of IRQs taken -- which could lead to a net benefit.
>> It would be good to see some benchmarks to understand how much
>> difference it makes to performance.
> 
> I will *try* to come up with some figures but I don't have any
> high-speed UARTs so my tests run at 115k tops.

Have you tried this?
http://fw.hardijzer.nl/?p=138

This drives the RPi PL011 from a higher frequency clock, thus you can
achieve much higher baud rates. Haven't tried this myself, but it looks
reasonable and not too complicated. You need a matching speed at the
other end, of course, AFAIK the FTDI USB chip can do this.

Cheers,
Andre.
