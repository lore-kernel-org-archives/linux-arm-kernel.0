From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 7 Jul 2011 21:40:41 +0800
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <4E146B7C.7060607@scram.de>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<4E146B7C.7060607@scram.de>
Message-ID: <CAK5ve-JQhJxWOL=UiX9SUxa5Rw8VrANyd05nuRJbytoZRR+EzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 10:04 PM, Jochen Friedrich <jochen@scram.de> wrote:
> On 06.07.2011 14:34, Bryan Wu wrote:
>
>> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
>> index cfb7607..6f87258 100644
>> --- a/arch/arm/mach-sa1100/simpad.c
>> +++ b/arch/arm/mach-sa1100/simpad.c
>> @@ -13,6 +13,8 @@
>> ?#include<linux/mtd/mtd.h>
>> ?#include<linux/mtd/partitions.h>
>> ?#include<linux/io.h>
>> +#include<linux/leds.h>
>> +#include<linux/slab.h>
>>
>> ?#include<asm/irq.h>
>> ?#include<mach/hardware.h>
>> @@ -205,7 +207,53 @@ static struct platform_device *devices[] __initdata =
>> {
>> ? ? ? ?&simpad_mq200fb
>> ?};
>>
>> +/* LEDs */
>> +#define LED_GREEN ? ? ?1
>>
>> +static void simpad_led_set(struct led_classdev *cdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? enum led_brightness b)
>> +{
>> + ? ? ? if (b != LED_OFF)
>> + ? ? ? ? ? ? ? set_cs3_bit(LED_GREEN);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? clear_cs3_bit(LED_GREEN);
>> +}
>> +
>> +static enum led_brightness simpad_led_get(struct led_classdev *cdev)
>> +{
>> + ? ? ? u32 reg = *(CS3BUSTYPE *)(CS3_BASE);
>> +
>> + ? ? ? return (reg& ?LED_GREEN) ? LED_FULL : LED_OFF;
>> +}
>
> NACK, bit 1 on the CS3 register is PCMCIA power control (write) and PCMCIA
> BVD1 (read), but not LED_GREEN. LED2_ON would be correct for write, but you
> would need to read cs3_shadow instead of the register itself for the LED
> status.
>

Actually, I'm not familiar with this hardware in details. Thanks for
pointing out.

> BTW: Some time ago I wrote a similar patch for ARM that converts CS3
> functions to GPIOs, wich simplifies the LED stuff even further ;-)
>
> http://www.spinics.net/lists/arm-kernel/msg122479.html
>

This looks good and it's the right way to do that. We need gpiolib
supporting firstly. How's status of your patchset, I guess you're
trying to update it.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
