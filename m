From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 Mar 2011 11:03:44 +0800
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <19850.2584.566366.251874@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>	<1300239773-4222-6-git-send-email-b32955@freescale.com>	<19848.39439.380861.195051@ipc1.ka-ro>	<4D8964F4.3070104@freescale.com>
	<19850.2584.566366.251874@ipc1.ka-ro>
Message-ID: <4D8AB490.30408@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar:
>
>>> some general comments:
>>> - Why are you not using the existing nand_ids but inventing your own
>>>     database?
>>>
>> The nand_ids{} contains poor information for me.
>> Such as :
>> [1]The nand_ids does not have the enough information for the page
>> size,oob size for some new NANDs.
>>      And you can not get the information from parsing the NAND ids, such
>> as some Micron NANDs.
>>
> You could use it for the standard chips where you do not need
> additional information. That way most NAND chips could be supported
> out of the box without having to modify the driver.
>
What the meaning of "standard chips"?

There are many nands in the world. Every vendor has its own rules, some 
even does has :)

Unluckily, the imx23/imx28 supports many nands that the nand_ids{} does 
not support.
I have many nands by my hand. I will add it gradually.

I want to get the page size/oob size from my own database which can not 
get from the nand_ids.


>> [2]I need the timing information of the NAND. The nand_ids DOES not have
>> it. I have to
>>      read the datasheet of the NAND, and add it to my database.
>>
> Do we really need exact timing data for each individual chip?
> Or couldn't we live with some sane timing that works for most chips
> and provide some means to specify a different timing via
> platform_data?
>
Most of the time, the timing is really based on a safe timing setting.
But in the original GPMI driver in the FREESCALE BSP, there exits some
nands need to be set with their own timing setting.

So I do not use the safe timing for _ALL_ the nand, and i'd better get 
it from the
database.
>>> - What is the purpose of the 'rom_helpers'? To me it looks like they
>>>     are doing something that should be done in the mtd partition
>>>     handlers, not in the flash chip driver.
>>>
>> We have saled a lot products based the imx23 or imx28.
>> All the products support the nand boot mode by flashing the kernel to
>> the kernel partitions of the nands.
>> In order to compliant to the old product, the layout of the nand is
>> constraint to the current situation:
>> [1] first a boot partition for the kernel.
>> [2] the rest is for other uses, such as rootfs.
>>
>> So I have to use the rom_helpers to split the kernel partition before
>> the real MTD partition initializations.
>>
> Why can't you just create appropriate partitions using the standard
> partition handlers?
>
thanks , I will try to change the code according to your advice.

Huang Shijie
