From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Mon, 05 Oct 2009 19:30:38 +0100
Subject: [PATCH v1.0 3/4] EP93XX: Add more register definition
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB767F@mi8nycmail19.Mi8.com>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>	<20091004011429.12578.27177.stgit@localhost.localdomain>	<BD79186B4FD85F4B8E60E381CAEE190901DB75AC@mi8nycmail19.Mi8.com>	<4AC9E138.1040309@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB767F@mi8nycmail19.Mi8.com>
Message-ID: <4ACA3B4E.8060801@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Monday, October 05, 2009 5:06 AM, Christian Gagneraud wrote:
>>> The ep93xx has been converted to full gpiolib support.  There
>>> is no need for the GPIO register defines.  Also, it's a bad
>>> idea to have them since anything using these will be "breaking"
>>> the gpiolib API.
>>>
>>> If you need to use the gpio debounce the ep93xx core already has
>>> support for this.  Please see ep93xx_gpio_int_debounce() in
>>> arch/arm/mach-ep93xx/core.c.
>> This was needed for a GPIO based keypad. I will have a look on how to 
>> convert it to use GPIO lib.
> 
> If you are referring to Matthieu Crapet's 0017-ts72xx_dio_keypad.patch,
> that patch appears to have already been converted over to use gpiolib.
> 
> Regardless, the in tree matrix_keypad.c driver will probably work
> instead of introducing another GPIO based keypad driver.
> 
>>> On a side note.  What tree did you base this patch on?  The
>>> EP93XX_GPIO_EEDRIVE is not currently in mainline.
>> Linus tree + a couple of pending patches from this ML.
> 
> Bad form.  Pending patches could always be dropped at some point.  You
> should only base your patches on published trees'.
> 
>>>>  #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
>>>>  
>>>> +#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
>>>>  #define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
>>>>  
>>>>  #define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
>>>> @@ -221,6 +235,7 @@
>>>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
>>>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
>>>>  #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
>>>> +#define EP93XX_SYSCON_CHIPID		EP93XX_SYSCON_REG(0x94)
>>>>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
>>>>  
>>>>  #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
>>> NAK.
>> OK for GPIO and SPI, but what about the SECURITY and SYSCON_CHIPID 
>> stuff? The idea behind that is to extend in some way board/cpu 
>> specific information.
>> For example the TS-7XXX boards comes with some options, there is 
>> currently a patch that add a /proc entry to display cpu and board 
>> information (CPU version, CPLD/FPGA firmware version, state of 
>> configuration jumpers, HW options installed, ...)
> 
> I think you are referring to Matthieu's 0006-ep93xx_cpuinfo.patch.
> This is IMHO a hack.  I have another approach for this that I proposed

Yes, this is a hack, and that's why I'm here, I would like to see most 
of these ideas pushed to mainline, and I know that almost all these 
patches won't be accepted, they need rework, heavy rework for some.

> to Russell a while ago.  He had some concern's about breaking userspace
> tools at that time.  I am planning on resubmitting my patch shortly
> in order to get more opinions.

That's true it could break some user space tools, so why not another 
/proc entry like /proc/machineinfo or /proc/boardinfo, ....
(without separator, to mimic /proc/cpuinfo)

In that respect, it will gives more freedom to display whatever 
revelant information machine maintainers can think of.

The approach you have in your "arm: add /proc/cpuinfo extension for 
ep93xx" patch sounds good to me.

Regards,
Chris

> 
> Please hold off on this for a bit.
> 
> Regards,
> Hartley
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
