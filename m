From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 25 Jan 2011 10:06:21 +1300
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <Pine.LNX.4.64.1101242200500.3167@ask.diku.dk>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
	<4D3DDD07.1030809@bluewatersys.com>
	<Pine.LNX.4.64.1101242126570.3167@ask.diku.dk>
	<4D3DE35B.1030102@bluewatersys.com>
	<Pine.LNX.4.64.1101242200500.3167@ask.diku.dk>
Message-ID: <4D3DE9CD.2040800@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2011 10:01 AM, Julia Lawall wrote:
> On Tue, 25 Jan 2011, Ryan Mallon wrote:
> 
>> On 01/25/2011 09:28 AM, Julia Lawall wrote:
>>>> Julia is correct. Some architectures can return NULL from clk_get, but I
>>>> didn't check the at91 before posting :-/. If we can't return NULL from
>>>> clk_get then we shouldn't bother checking for it. I do think we should
>>>> drop the !IS_ERR(clk_get(dev, func)) check though.
>>>
>>> It seems a bit subtle, because the clk manipulated by clk_get in the call 
>>> of clk_get(dev, func) is not necessarily the same as the one in 
>>> clock_associate.  But perhaps this is the only possibility in practice?
>>
>> Not sure I follow. The at91 clk_get does not modify the clk. In
>> at91_clock_associate we have:
>>
>> 	clk->function = func;
>> 	clk->dev = dev;
>>
>> and in clk_get we have:
>>
>> 	if (clk->function && (dev == clk->dev) &&
>> 		strcmp(id, clk->function) == 0)
>>             return clk;
>>
>> So at91_clock_associate sets the function for a clock, and clk_get
>> returns clocks based on the function association if the name lookup
>> fails. The only caveat to this is that the the clock function name
>> (clk->function) is not the same as any others clock's clk->name.
> 
> Right, that was what I was worried about.  That one would find the same 
> information already present but somewhere else.  But perhaps it can't 
> happen, or it doesn't matter if it does?

I think that users are expected to ensure that clock names and clock
function names do not overlap.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
