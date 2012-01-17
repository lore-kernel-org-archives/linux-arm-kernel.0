From: jochen@scram.de (Jochen Friedrich)
Date: Tue, 17 Jan 2012 10:41:41 +0100
Subject: [PATCH 2/2] ARM: sa1100: Refactor mcp-sa11x0 to use platform
 resources.
In-Reply-To: <20120114092129.GO1068@n2100.arm.linux.org.uk>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
 <1322427655-914-2-git-send-email-jochen@scram.de>
 <20120114092129.GO1068@n2100.arm.linux.org.uk>
Message-ID: <4F154255.2020605@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 14.01.2012 10:21, Russell King - ARM Linux wrote:

> I should have spotted this patch earlier.

Sorry for my late response as well.

> This is the obviously wrong approach - if you're having to add the same
> code to almost every board, then you're doing something wrong.

Accessing some random SoC registers and in the assabet case even board
specific registers from device drivers is even worse IMHO. We don't get 
a clean solution until we have a pinmux/pinctrl device driver owning 
these peripheral control registers. At least having the setup in the 
board files avoids a potential race condition accessing PPDR and PPSR 
registers from multiple drivers.

>
> Not only that, but...
>
>>   static struct resource sa11x0mcp_resources[] = {
>>   	[0] = {
>>   		.start	= __PREG(Ser4MCCR0),
>> -		.end	= __PREG(Ser4MCCR0) + 0xffff,
>> +		.end	= __PREG(Ser4MCCR0) + 0x1C - 1,
>
> Please leave this as +0xffff - we treat all devices has having 64K
> resources on sa11x0 platforms.  (It's possible that the registers
> repeat throughout the memory space.)

OK, but...

>>   		.flags	= IORESOURCE_MEM,
>>   	},
>>   	[1] = {
>> +		.start	= __PREG(Ser4MCCR1),
>> +		.end	= __PREG(Ser4MCCR1) + 0x4 - 1,
>> +		.flags	= IORESOURCE_MEM,
>> +	},

How to treat this case then? Here one register is "borrowed" from a 
different 64K block.
The old driver version didn't even register access to this memory space.

> 	void __iomem *
>
> Note the '__iomem'.  That must stay with the cookie.  Check your code
> with sparse.

OK, will do.

>> +	__raw_writel(priv->mccr0, priv->mccr0_base + MCCR0);
>
> writel?  writel_relaxed?

writel_relaxed should be fine. The old version didn't use any barriers, 
so I assume that's OK. I'll check if reorders would cause any problem.

>> +	size0 = res_mem0->end - res_mem0->start + 1;
>
> resource_size() ?

Jamie pointed me to this already. I'll change this.

>> +	priv->mccr0_base = ioremap(res_mem0->start, size0);
>> +	priv->mccr1_base = ioremap(res_mem1->start, size1);
>
> You want to oops the kernel?  Where's the error checking?

Good catch!

Thanks for the review,
Jochen
