From: david@lechnology.com (David Lechner)
Date: Wed, 23 Mar 2016 13:06:57 -0500
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <56F2D0AD.4040005@ti.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56F2D0AD.4040005@ti.com>
Message-ID: <56F2DB41.7010708@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 12:21 PM, Sekhar Nori wrote:
>> +/* DA8xx CFGCHIP2 (USB PHY Control) register bits */
>> +#define PHYCLKGD		(1 << 17)
>> +#define VBUSSENSE		(1 << 16)
>> +#define RESET			(1 << 15)
>> +#define OTGMODE_MASK		(3 << 13)
>> +#define NO_OVERRIDE		(0 << 13)
>> +#define FORCE_HOST		(1 << 13)
>> +#define FORCE_DEVICE		(2 << 13)
>> +#define FORCE_HOST_VBUS_LOW	(3 << 13)
>> +#define USB1PHYCLKMUX		(1 << 12)
>> +#define USB2PHYCLKMUX		(1 << 11)
>> +#define PHYPWRDN		(1 << 10)
>> +#define OTGPWRDN		(1 << 9)
>> +#define DATPOL			(1 << 8)
>> +#define USB1SUSPENDM		(1 << 7)
>> +#define PHY_PLLON		(1 << 6)
>> +#define SESENDEN		(1 << 5)
>> +#define VBDTCTEN		(1 << 4)
>> +#define REFFREQ_MASK		(0xf << 0)
>> +#define REFFREQ_12MHZ		(1 << 0)
>> +#define REFFREQ_24MHZ		(2 << 0)
>> +#define REFFREQ_48MHZ		(3 << 0)
>> +#define REFFREQ_19_2MHZ		(4 << 0)
>> +#define REFFREQ_38_4MHZ		(5 << 0)
>> +#define REFFREQ_13MHZ		(6 << 0)
>> +#define REFFREQ_26MHZ		(7 << 0)
>> +#define REFFREQ_20MHZ		(8 << 0)
>> +#define REFFREQ_40MHZ		(9 << 0)
>
> Many of these register bits are unused. I guess opinion varies around
> this, but I get confused with unnecessary bit definitions and register
> offsets. I tend to search for it and its sort of disappointing to see
> that its basically unused. Of course, you should wait for PHY
> maintainers preference.

My thinking was that since this driver *owns* the CFGCHIP2 register that 
is would eventually register clocks using the common clock framework, in 
which case, it would use many of these registers.

But, based on feedback on another commit, if we go the syscon route, 
then yes, I will remove the unused values.


>> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
>
> Hmm, since this driver exports this symbol, I think it should also
> provide an include file in include/linux/phy for users of the symbol. Or
> perhaps there should be a generic API around this since it looks like
> most USB phys will need something similar?
>

The reason I didn't make a header file is that this function is only 
meant to be use in one place and would likely cause a crash if used 
anywhere else.

I agree that it would be nice if the generic phy driver had a mechanism 
for user-defined callbacks such as this, however, I think the scope of 
this patch series has grown enough already.
