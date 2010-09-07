From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 07 Sep 2010 16:07:31 +1200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <AANLkTi=B7O9jDB_pzHS6feWTxHQTfDZ-QLx7jOKaA2vN@mail.gmail.com>
References: <280328.53116.qm@web180311.mail.gq1.yahoo.com>
	<4C85A71F.3010402@bluewatersys.com>
	<AANLkTi=B7O9jDB_pzHS6feWTxHQTfDZ-QLx7jOKaA2vN@mail.gmail.com>
Message-ID: <4C85BA83.9080002@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2010 03:54 PM, Eric Miao wrote:
> On Tue, Sep 7, 2010 at 10:44 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>> On 09/07/2010 02:23 PM, David Brownell wrote:
>>> Still not liking or accepting this proposed
>>> change to the GPIO framework.
>>>
>>> For the AT91 case (where integers 0..N are
>>> IRQs, but N..max are GPIOs)
>>>
>>> A simpler solution is just to use a bit in
>>> the integer to indicate IRQ vs GPIO.  Like
>>> maybe the sign bit.. which is never set on
>>> valid GPIO numbers, but platforms could let
>>> be set on IRQs.
>>>
>> How about this approach instead?
>>
> 
> This doesn't solve the problem with more complicated settings, e.g.
> some GPIOs within are not valid, not just the begining ones.

Agreed, but this does solve the immediate problem for AT91 in a simple
way. Are there boards in the kernel which have holes in the gpio layout?

Another possible solution is to loop through all the gpio_chips to see
if the number maps to a valid gpio. The obvious downside to this
approach is that the complexity of gpio_is_valid becomes reasonably high
for something which should be a very simple test and, as you say below,
we probably just don't need that fine-grained information.

> So the real question here is the semantics of gpio_is_valid(). I'd
> personally incline it reads as if a GPIO _number_ is valid generally,
> (e.g. like -1 is not a valid GPIO number), instead of that specific
> GPIO is valid on that specific platform. The latter can be judged
> with gpio_request().

Some drivers in the kernel appear to be using this behaviour to have
optional gpios, ie setting the foo_gpio = -1 in the platform data for
some driver. The documentation also suggests that this is what
gpio_is_valid is intended for. However, the documentation also says we
may want gpio_is_valid to return invalid on some other numbers.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
