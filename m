From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 15 Dec 2009 15:15:14 -0500
Subject: GPIO support for HTC Dream
In-Reply-To: <20091215194725.GH24406@elf.ucw.cz>
References: <20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9E6@mi8nycmail19.Mi8.com>
	<20091215194725.GH24406@elf.ucw.cz>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EBE8@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 15, 2009 12:47 PM, Pavel Machek wrote:
>
> Hi!
>
>>> +int gpio_to_irq(unsigned gpio)
>>> +{
>>> +	return -EINVAL;
>>> +}
>> 
>> This should probably just be an inline function in
>> arch/arm/mach-msm/include/mach/gpio.h
>
> Well, it is not performance critical in any way and it is likely to
> change in future. I'd leave it here.

Comment below..

>>> diff --git a/arch/arm/mach-msm/board-dream.h b/arch/arm/mach-msm/board-dream.h
>>> index 4f345a5..dbd78b9 100644
>>> --- a/arch/arm/mach-msm/board-dream.h
>>> +++ b/arch/arm/mach-msm/board-dream.h
>>> @@ -1,5 +1,58 @@
>>>  
>>> -#define TROUT_CPLD_BASE   0xE8100000
>>> -#define TROUT_CPLD_START  0x98000000
>>> -#define TROUT_CPLD_SIZE   SZ_4K
>>> +#define MSM_SMI_BASE		0x00000000
>>> +#define MSM_SMI_SIZE		0x00800000
...
>>> +#define DREAM_CPLD_BASE   0xE8100000
>>> +#define DREAM_CPLD_START  0x98000000
>>> +#define DREAM_CPLD_SIZE   SZ_4K
>>> +
>>
>> This header might need to be a separate patch.  The only thing in it
>> related to the rest of this is DREAM_CPLD_BASE.
>
> Yep.
>
>>> +#ifndef __ASM_ARCH_MSM_GPIO_H
>>> +#define __ASM_ARCH_MSM_GPIO_H
>>> +
>>> +extern int gpio_to_irq(unsigned gpio);
>> 
>> This should probably be an inline as mentioned above.
>> 
>> For completeness you should probably also add:
>> 
>> static inline int irq_to_gpio(unsigned irq)
>> {
>> 	return -EINVAL;
>> }
>
> I'd say that would be overdoing it.

I only mentioned that one because it is one of the functions listed in
Documentation/gpio.txt.  I'm not sure if that means it's "required".  You
make the call...

>> And, nitpick, move both of them after the gpio_cansleep below.
>
> I'll do the move.
>
>>> +#define DREAM_GPIO_CABLE_IN1		(83)
>>> +#define DREAM_GPIO_CABLE_IN2		(49)
>>> +
>>> +#define DREAM_GPIO_START (128)
>> 
>> Nitpick.  Tab align these three with the ones below.
>
> Ok.
>
>>> +#define DREAM_GPIO_SDMC_CD_N                (DREAM_GPIO_VIRTUAL_BASE + 0)
>>> +#define DREAM_GPIO_END                      (DREAM_GPIO_SDMC_CD_N)
>>> +#define DREAM_GPIO_BANK1_FIRST_INT_SOURCE   (DREAM_GPIO_SDMC_CD_N)
>>> +#define DREAM_GPIO_BANK1_LAST_INT_SOURCE    (DREAM_GPIO_SDMC_CD_N)
>>> +
>>> +#endif
>> 
>> Otherwise, looks good to me.  Just test it to make sure it works :-).
>> 
>> Since I have no way of compiling or testing this...
>> 
>> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> I believe inlining that function would be bad change. Can I still use
> reviewed-by tag?

The reason I suggest making it an inline in the header is you might
eventually want to change both gpio_to_irq and irq_to_gpio into macros
so that they can be used for static initializers.  For right now both
are simple return -EINVAL but when gpio irq's are supported you might
find a need to use one or the other in a platform init...

Regardless, yes you can still use my reviesed-by tag.

Regards,
Hartley
