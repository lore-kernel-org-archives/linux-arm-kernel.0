From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 15 Dec 2010 08:52:31 +1300
Subject: [PATCH 15/54] ARM: ep93xx: irq_data conversion.
In-Reply-To: <20101214192835.GM15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133639.GP15575@mail.wantstofly.org>
	<4CF55185.6010808@bluewatersys.com>
	<20101201001945.GI15575@mail.wantstofly.org>
	<4CF5963E.8060500@bluewatersys.com>
	<20101214192835.GM15575@mail.wantstofly.org>
Message-ID: <4D07CAFF.2030705@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2010 08:28 AM, Lennert Buytenhek wrote:
> On Wed, Dec 01, 2010 at 01:26:38PM +1300, Ryan Mallon wrote:
> 
>>>>> -static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
>>>>> +static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
>>>>>  {
>>>>> -	struct irq_desc *desc = irq_desc + irq;
>>>>> -	const int gpio = irq_to_gpio(irq);
>>>>> +	struct irq_desc *desc = irq_desc + d->irq;
>>>>
>>>> Is this still correct? I haven't followed much of the irq_data
>>>> discussion, but this post (https://patchwork.kernel.org/patch/230221/)
>>>> says that with sparse irq converting irq number to irq_desc is now a
>>>> radix tree lookup.
>>>>
>>>> I get the impression from the above email that we should be avoiding
>>>> using irq_desc directly in these functions?
>>>
>>> You are correct in that this construct is no longer valid with
>>> CONFIG_SPARSE_IRQ.  It should be using irq_to_desc() instead, or
>>> actually, it should not be looking at the irq_desc here at all.
>>>
>>> What ep93xx wants to achieve should be possible to achieve by just
>>> calling set_irq_handler() instead of frobbing fields in the irq_desc
>>> directly -- that would work, right?
>>
>> I think set_irq_handler should be okay. The other way would be to use
>> irq_to_desc for the lookup.
> 
> I can do that, but that's really an orthogonal issue, and ought to be
> a separate patch.
> 
> Are you OK with this patch as-is?

Yes. We don't select SPARSE_IRQ for EP93xx so it's not a pressing issue.
The code should be fixed to be correct though, but as you say this is a
separate issue and can be handled with another patch.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
