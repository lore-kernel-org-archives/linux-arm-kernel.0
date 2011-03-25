From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Mar 2011 10:50:32 +0800
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <201103241454.53337.ffainelli@freebox.fr>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<19850.62451.678409.328798@ipc1.ka-ro>
	<4D8B061C.5080200@freescale.com>
	<201103241454.53337.ffainelli@freebox.fr>
Message-ID: <4D8C02F8.50900@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian:


> Hello Huang,
>
> On Thursday 24 March 2011 09:51:40 Huang Shijie wrote:
>> Hi Lothar:
>>> Hi,
>>>
>>> Huang Shijie writes:
>>>> Hi Lothar:
>>>>>>> some general comments:
>>>>>>> - Why are you not using the existing nand_ids but inventing your own
>>>>>>>
>>>>>>>       database?
>>>>>> The nand_ids{} contains poor information for me.
>>>>>> Such as :
>>>>>> [1]The nand_ids does not have the enough information for the page
>>>>>> size,oob size for some new NANDs.
>>>>>>
>>>>>>        And you can not get the information from parsing the NAND ids,
>>>>>>        such
>>>>>>
>>>>>> as some Micron NANDs.
>>>>> You could use it for the standard chips where you do not need
>>>>> additional information. That way most NAND chips could be supported
>>>>> out of the box without having to modify the driver.
>>>> What the meaning of "standard chips"?
>>> Those chips that are supported by other drivers for long time.
>> see belowing.
>>
>>>> There are many nands in the world. Every vendor has its own rules, some
>>>> even does has :)
>>>>
>>>> Unluckily, the imx23/imx28 supports many nands that the nand_ids{} does
>>>> not support.
>>> That's no reason to scrap support for all chips that every other
>>> driver supports.
>> Frankly speaking, Which nand we should to support depends on the
>> customer's requires.
>>
>> So we really do not want to support other nands that the customer does
>> not have.
>>
>>>> I have many nands by my hand. I will add it gradually.
>>> So why not add them to the generic database?
>> I ever thought to change the generic database. But I found it would cost
>> a long time.
>>
>> The parsing code in nand_get_flash_type() can not parse out the page
>> size/oob size
>> in some cases. And IMHO I do not think to get the page size/oob size by
>> parsing the ids is a good way,
>> this really makes the code mess (sorry, David, I really think the
>> current code is ugly.).
>>
>> IMHO, the best solution is add a database like mine. Using the id bytes
>> as the keyword to match the nand.
>> then to get the page size /oob size , etc, from the database.
>>
>> I will send a patch about this in future, but now, I do not want to  be
>> stumbled by this problem.
>>
>>>> I want to get the page size/oob size from my own database which can not
>>>> get from the nand_ids.
>>> If there are parameters needed that cannot be obtained from the
>>> generic database, it might be worth upgrading that database instead of
>>> creating your own local database.
>>>
>>>>>> [2]I need the timing information of the NAND. The nand_ids DOES not
>>>>>> have it. I have to
>>>>>>
>>>>>>        read the datasheet of the NAND, and add it to my database.
>>>>> Do we really need exact timing data for each individual chip?
>>>>> Or couldn't we live with some sane timing that works for most chips
>>>>> and provide some means to specify a different timing via
>>>>> platform_data?
>>>> Most of the time, the timing is really based on a safe timing setting.
>>>> But in the original GPMI driver in the FREESCALE BSP, there exits some
>>>> nands need to be set with their own timing setting.
>>>>
>>>> So I do not use the safe timing for _ALL_ the nand, and i'd better get
>>>> it from the
>>>> database.
>>> It should be sufficient to provide timing info from platform_data in
>>> special cases instead of bloating the nand id database with that
>>> stuff. Platforms might need to adjust the timing because of
>>> peculiarities in the HW. Thus the timing info should be provided from
>>> there, not from the chip database.
>> The timing information is needed by the GPMI module, not other module.
>> So the
>> best way to get this is from the chip database.
> Such a database already exists in drivers/mtd/nand/nand_ids.c. The idea here
> would be for you to get the NAND geometry characteristics from nands_ids.c,
> which benefits to all drivers in general, and let platform code define specific
> timings, which is specific to your driver.
>
I will remove the timing fields.

thanks.
