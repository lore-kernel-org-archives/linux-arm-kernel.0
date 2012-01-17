From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2012 20:12:56 +0000
Subject: [PATCH 2/2] ARM: sa1100: Refactor mcp-sa11x0 to use platform
 resources.
In-Reply-To: <4F154255.2020605@scram.de>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
 <1322427655-914-2-git-send-email-jochen@scram.de>
 <20120114092129.GO1068@n2100.arm.linux.org.uk> <4F154255.2020605@scram.de>
Message-ID: <20120117201256.GV1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 10:41:41AM +0100, Jochen Friedrich wrote:
> Accessing some random SoC registers and in the assabet case even board
> specific registers from device drivers is even worse IMHO. We don't get  
> a clean solution until we have a pinmux/pinctrl device driver owning  
> these peripheral control registers. At least having the setup in the  
> board files avoids a potential race condition accessing PPDR and PPSR  
> registers from multiple drivers.

Yes, but do we really need the exact same code repeated time and time
again in each different board file?  Could we not have a function which
sets the pins up for MCP?

>> Not only that, but...
>>
>>>   static struct resource sa11x0mcp_resources[] = {
>>>   	[0] = {
>>>   		.start	= __PREG(Ser4MCCR0),
>>> -		.end	= __PREG(Ser4MCCR0) + 0xffff,
>>> +		.end	= __PREG(Ser4MCCR0) + 0x1C - 1,
>>
>> Please leave this as +0xffff - we treat all devices has having 64K
>> resources on sa11x0 platforms.  (It's possible that the registers
>> repeat throughout the memory space.)
>
> OK, but...
>
>>>   		.flags	= IORESOURCE_MEM,
>>>   	},
>>>   	[1] = {
>>> +		.start	= __PREG(Ser4MCCR1),
>>> +		.end	= __PREG(Ser4MCCR1) + 0x4 - 1,
>>> +		.flags	= IORESOURCE_MEM,
>>> +	},
>
> How to treat this case then? Here one register is "borrowed" from a  
> different 64K block.
> The old driver version didn't even register access to this memory space.

I'm not complaining about this one - the MCCR1 shares its 64K space with
the peripheral pin controller, and I suspect we won't get to the point
where that's controlled by a driver.  So it's probably going to remain a
feature dealt with primerily by arch/arm/mach-sa1100 code.
