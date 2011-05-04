From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 04 May 2011 16:17:04 +0300
Subject: [RFC] About ARM expansion boards and others things
In-Reply-To: <BANLkTin2ud=Qda8OZUQ1k+7ghD4VWKi_TA@mail.gmail.com>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>	<4DC13032.5010404@compulab.co.il>
	<BANLkTin2ud=Qda8OZUQ1k+7ghD4VWKi_TA@mail.gmail.com>
Message-ID: <4DC151D0.1040300@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/11 15:28, Enric Balletb? i Serra wrote:

> 2011/5/4 Igor Grinberg <grinberg@compulab.co.il>:
>> On 05/03/11 20:25, Enric Balletb? i Serra wrote:

[...]

>>> I'll explain a little more, the real problem is I don't know how to
>>> add support for an expansion board for IGEP v2 board. I see most of
>>> boards adds the support inside the board-xxxxx.c file, for example if
>>> the expansion board has a Touchscreen interface using ADS7846/TSC2046
>>> they register ads7846 platform data in board-xxxx.c file. This is ok
>>> beacause the ads7846 can be detected and if expansion board is not
>>> present  the detection fails, but maybe other devices in expansion
>>> board can't be detected (for example an I/O expansion). So which is
>>> the best form to do this ?
>>>
>>> I'm thinking in create a kernel module for the expansion board that
>>> add all the new features, the expansion board should come with a I2C
>>> E2PROM for board ID storage, so the idea is create an i2c driver that
>>> reads the E2PROM and if found the Board ID inits all the expansion
>>> board devices.
>> Why do you need to create a new driver? Why don't you use the existing one?
>> at24 works nice with most i2c EEPROMs.
>>
>> Let me generalize:
>> 1) Lets call each board that actually has SoC, like IGEP, a System On Module (SoM)
>> 2) SoM has on-board and on-SoC devices
>> 3) expansion has additional on-board devices
>> 4) We are talking about X SoMs and Y extensions
>> 5) Each SoM can be connected to each extension and communicate with its devices.
>> 6) We are looking for a solution to be able to detect the expansion and register
>>   the devices it has assembled.
> Great generalitzation !

Thanks, please, consider "extension" = "expansion".

>>> I have done a few experiments, I've created a kernel module (driver)
>>> for a custom expansion board for IGEP v2,  the expansion board has :
>>>    - I2C E2PROM
>>>    - ADS7846 touch controller (spi)
>>>    - Seiko 7.0inch LCD
>>>    - General purpose I/O
>>>
>>> The driver is capable to register correctly i2c and spi devices and
>>> seems is working but I have problems with the Seiko 7.0inch LCD and
>>> configuring the MUX from driver.
>> Like Tony already said the generic MUX API should solve the problem of MUX.
>> But, you will still have a problem with devices that have to be initialized
>> very early, like IO chips.
> Right, about the MUX, there is any patch or specification for the MUX API ?

You can read here:
http://www.spinics.net/lists/arm-kernel/msg123703.html
and here:
http://www.spinics.net/lists/arm-kernel/msg123702.html

I still haven't had a chance to look into it.


[...]

>>> All of this is a crazy idea ? What's the best form to solve the problem ?
>> This is not crazy at all.
>> We already use this concept in our BSP, we detect the expansion
>> by reading data from EEPROM, and register the devices accordingly.
>> We solve the MUX problem by initializing the pins to some default state
>> and once the expansion detection is done, we reconfigure the pins
>> to their right state as required by connected devices.
>>
>> And yes the above is done from board file.
> So its possilbe read the EEPROM in board file ? How ? I was thinking
> wasn't possible read the EEPROM in board initialitzation because was
> in a early state.

You should take a look at the at24 driver (drivers/misc/at24.c)
While registering the EEPROM device structure, you can provide
the setup() callback inside the at24_platform_data, which will be called
once the at24 driver is initialized. Though, this will not happen early,
but there are still plenty of things you can do.
You can see the usage example in davinci code, if I'm not mistaken,
they setup the MAC address this way.
This will not solve you the dynamic DSS device registration problem.

>> I don't see any reason to create a driver for the expansion,
>> unless it can be removed/attached "on the fly" while the SoM is up and running.
> Completely agree, normally expansion board can't be connected "on the fly"
>
>> Nevertheless, some framework or at least an agreement on how we should
>> separate the SoM code from the expansion code.
>>
>> I thought of some convention like board-*.c will stay the code for the SoM
>> and exp-*.c will be used for the expansion code.
>> Now, the code in board-*.c will do the detection of the expansion and
>> run the appropriate exp_*_init() function, which will do the initialization steps
>> for the detected expansion.
>> A bit more complicated solution will be needed if there are several expansions
>> connected all together.
>>
> Looks good for me if this is the accepted solution.
>
>> I have had this in my mind for very long time, but did not want to bother,
>> because there were discussions about a totally different approach which uses
>> device trees (DT), where the detection of expansion is moved away
>> from the kernel code.
>>
>> With the DT approach, the kernel (should) get(s) all the information regarding
>> the devices and how they are wired for free (no detection).
>> If I understand correctly, the information about devices
>> (whether on SoM or expansion) could be either statically added to the DT
>> structures or dynamically detected by the bootloader and passed to the
>> kernel (like ATAGS work now).
> Really interesting, I'll look that, do you think is the future to
> solve this problem ? Have you tested ?

Nope, I haven't, mostly because it is still not ready for ARM.

>> I still doubt what approach would be better...
> Me too, but I think it's interesting doing a brainstorming about this
> theme because it's a common problem for board manufacturers.


-- 
Regards,
Igor.
