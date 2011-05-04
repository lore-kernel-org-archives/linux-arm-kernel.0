From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 04 May 2011 14:20:30 +0300
Subject: [RFC] About ARM expansion boards and others things
In-Reply-To: <4DC13032.5010404@compulab.co.il>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
	<4DC13032.5010404@compulab.co.il>
Message-ID: <4DC1367E.3010603@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the second send attempt, the first one was

accidentally sent to wrong addresses.


On 05/04/11 13:53, Igor Grinberg wrote:

> On 05/03/11 20:25, Enric Balletb? i Serra wrote:
>
>> Hi guys,
>> I'm thinking probably in a crazy idea, I hope someone can help me or
>> kill definitely this idea from my mind.
> This is not that crazy as you think it is...
>
>> I'll explain a little more, the real problem is I don't know how to
>> add support for an expansion board for IGEP v2 board. I see most of
>> boards adds the support inside the board-xxxxx.c file, for example if
>> the expansion board has a Touchscreen interface using ADS7846/TSC2046
>> they register ads7846 platform data in board-xxxx.c file. This is ok
>> beacause the ads7846 can be detected and if expansion board is not
>> present  the detection fails, but maybe other devices in expansion
>> board can't be detected (for example an I/O expansion). So which is
>> the best form to do this ?
>>
>> I'm thinking in create a kernel module for the expansion board that
>> add all the new features, the expansion board should come with a I2C
>> E2PROM for board ID storage, so the idea is create an i2c driver that
>> reads the E2PROM and if found the Board ID inits all the expansion
>> board devices.
> Why do you need to create a new driver? Why don't you use the existing one?
> at24 works nice with most i2c EEPROMs.
>
> Let me generalize:
> 1) Lets call each board that actually has SoC, like IGEP, a System On Module (SoM)
> 2) SoM has on-board and on-SoC devices
> 3) expansion has additional on-board devices
> 4) We are talking about X SoMs and Y extensions
> 5) Each SoM can be connected to each extension and communicate with its devices.
> 6) We are looking for a solution to be able to detect the expansion and register
>    the devices it has assembled.
>
>> I have done a few experiments, I've created a kernel module (driver)
>> for a custom expansion board for IGEP v2,  the expansion board has :
>>    - I2C E2PROM
>>    - ADS7846 touch controller (spi)
>>    - Seiko 7.0inch LCD
>>    - General purpose I/O
>>
>> The driver is capable to register correctly i2c and spi devices and
>> seems is working but I have problems with the Seiko 7.0inch LCD and
>> configuring the MUX from driver.
> Like Tony already said the generic MUX API should solve the problem of MUX.
> But, you will still have a problem with devices that have to be initialized
> very early, like IO chips.
>
>> Basically I wonder if it's possible add another omap_dss_device from
>> kernel module to the omap DSS driver (something like
>> omap_dss_register_new_device). Is a good or bad idea ? Why ? Is any
>> reason to not export the MUX functionality to be used for other
>> drivers ?
> ...
>
>> All of this is a crazy idea ? What's the best form to solve the problem ?
> This is not crazy at all.
> We already use this concept in our BSP, we detect the expansion
> by reading data from EEPROM, and register the devices accordingly.
> We solve the MUX problem by initializing the pins to some default state
> and once the expansion detection is done, we reconfigure the pins
> to their right state as required by connected devices.
>
> And yes the above is done from board file.
> I don't see any reason to create a driver for the expansion,
> unless it can be removed/attached "on the fly" while the SoM is up and running.
>
> Nevertheless, some framework or at least an agreement on how we should
> separate the SoM code from the expansion code.
>
> I thought of some convention like board-*.c will stay the code for the SoM
> and exp-*.c will be used for the expansion code.
> Now, the code in board-*.c will do the detection of the expansion and
> run the appropriate exp_*_init() function, which will do the initialization steps
> for the detected expansion.
> A bit more complicated solution will be needed if there are several expansions
> connected all together.
>
> I have had this in my mind for very long time, but did not want to bother,
> because there were discussions about a totally different approach which uses
> device trees (DT), where the detection of expansion is moved away
> from the kernel code.
>
> With the DT approach, the kernel (should) get(s) all the information regarding
> the devices and how they are wired for free (no detection).
> If I understand correctly, the information about devices
> (whether on SoM or expansion) could be either statically added to the DT
> structures or dynamically detected by the bootloader and passed to the
> kernel (like ATAGS work now).
>
> I still doubt what approach would be better...
>

-- 
Regards,
Igor.
